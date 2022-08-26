// Copyright (c) 2022, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';
import 'dart:convert';

import 'package:jni_gen/src/writers/bindings_writer.dart';
import 'package:jni_gen/src/config/config.dart';
import 'package:jni_gen/src/elements/elements.dart';
import 'package:jni_gen/src/writers/files_writer.dart';
import 'package:jni_gen/src/tools/build_summarizer.dart';
import 'package:jni_gen/src/tools/maven_utils.dart';
import 'package:jni_gen/src/tools/android_sdk_utils.dart';

import 'config_provider.dart';

// jni_gen:setup function should be run if summarizer is not built
// class MavenDownloads - source_deps, source_folder=java, jar_only_deps, jar_folder=jar
// class AndroidConfig - android_sdk_root, versions, use_sources

/// Configuration for dependencies to be downloaded using maven.
///
/// Dependency names should be listed in groupId:artifactId:version format.
/// For [sourceDeps], sources will be unpacked to [sourcePath] root and JAR files
/// will also be downloaded. For the packages in jarOnlyDeps, only JAR files
/// will be downloaded.
///
/// When passed as a parameter to [JniGenTask], the downloaded sources and
/// JAR files will be automatically added to source path and class path
/// respectively.
class MavenDownloads {
  MavenDownloads({
    this.sourceDeps = const [],
    this.sourcePath = 'java',
    this.jarOnlyDeps = const [],
    this.jarPath = 'jar',
  });
  List<String> sourceDeps;
  String sourcePath;
  List<String> jarOnlyDeps;
  String jarPath;
}

/// Configuration for Android SDK sources and stub JAR files.
///
/// The SDK directories for platform stub JARs and sources are searched in the
/// same order in which [versions] are specified.
///
/// If [sdkRoot] is not provided, an attempt is made to discover it
/// using the environment variable `ANDROID_SDK_ROOT`, which will fail if the
/// environment variable is not set.
///
/// If [includeSources] is true, `jni_gen` searches for Android SDK sources
/// as well in the SDK directory and adds them to the source path.
class AndroidSdkConfig {
  AndroidSdkConfig(
      {required this.versions,
      required this.sdkRoot,
      this.includeSources = false});
  List<int> versions;
  String sdkRoot;
  bool includeSources;
}

/// Additional options to pass to the summary generator component.
class SummarizerOptions {
  SummarizerOptions(
      {this.extraArgs = const [], this.workingDirectory, this.backend});
  List<String> extraArgs;
  Uri? workingDirectory;
  String? backend;
}

/// Backend for reading summary of Java libraries
enum SummarizerBackend {
  /// Generate Java API summaries using JARs in provided `classPath`s.
  asm,

  /// Generate Java API summaries using source files in provided `sourcePath`s.
  doclet,
}

class MemberExclusions {
  MemberExclusions({required this.methods, required this.fields});
  MethodFilter? methods;
  FieldFilter? fields;
}

/// Represents a complete jni_gen binding generation configuration.
///
/// The default constructor mirrors YAML configuration for ease of use.
/// A [JniGenTask] can alternatively be constructed using its constituents using
/// [JniGenTask.ofComponents] constructor.
class JniGenTask {
  JniGenTask({
    /// List of classes or packages for which bindings have to be generated.
    ///
    /// The names must be fully qualified, and it's assumed that the directory
    /// structure corresponds to package naming. For example, com.abc.MyClass
    /// should be resolvable as `com/abc/MyClass.java` from one of the provided
    /// source paths. Same applies if ASM backend is used, except that the file
    /// name suffix is `.class`.
    required List<String> classes,

    /// Name of generated library in CMakeLists.txt configuration.
    ///
    /// This will determine the name of shared object file.
    required String libraryName,

    /// Directory to write JNI C Bindings.
    required Uri cRoot,

    /// Directory to write Dart bindings.
    required Uri dartRoot,

    /// Methods and fields to be excluded from generated bindings.
    MemberExclusions? exclude,

    /// Paths to search for java source files.
    ///
    /// If a source package is downloaded through [mavenDownloads] option,
    /// the corresponding source folder is automatically added and does not
    /// need to be explicitly specified.
    List<Uri>? sourcePath,

    /// class path for scanning java libraries. If [backend] is `asm`, the
    /// specified classpath is used to search for [classes], otherwise it's
    /// merely used by the doclet API to find transitively referenced classes,
    /// but not the specified classes / packages themselves.
    List<Uri>? classPath,

    /// Additional java package -> dart package mappings (Experimental).
    Map<String, String> importMap = const {},

    /// Configuration to search for Android SDK libraries (Experimental).
    this.androidSdkConfig,

    /// Configuration for libraries to be downloaded automatically using maven.
    this.mavenDownloads,

    /// Common text to be pasted on top of generated C and Dart files.
    String? preamble,

    /// Additional options for the summarizer component
    SummarizerOptions? summarizerOptions,
  })  : outputWriter = FilesWriter(
            preamble: preamble,
            libraryName: libraryName,
            cWrapperDir: cRoot,
            dartWrappersRoot: dartRoot),
        options = WrapperOptions(
          importPaths: importMap,
          fieldFilter: exclude?.fields,
          methodFilter: exclude?.methods,
        ),
        summarizer = SummarizerCommand(
            sourcePaths: sourcePath,
            classPaths: classPath,
            classes: classes,
            extraArgs: summarizerOptions?.extraArgs ?? const [],
            backend: summarizerOptions?.backend);
  JniGenTask.ofComponents(
      {required this.summarizer,
      this.options = const WrapperOptions(),
      required this.outputWriter,
      this.mavenDownloads,
      this.androidSdkConfig});
  BindingsWriter outputWriter;
  SummarizerCommand summarizer;
  WrapperOptions options;
  AndroidSdkConfig? androidSdkConfig;
  MavenDownloads? mavenDownloads;

  // execute this task
  Future<void> run({bool dumpJson = false}) async {
    await buildSummarizerIfNotExists();

    final mvn = mavenDownloads;
    final extraSourcePaths = <Uri>[];
    final extraJarPaths = <Uri>[];
    if (mvn != null) {
      final sourcePath = mvn.sourcePath;
      Directory(sourcePath).create(recursive: true);
      await MavenTools.downloadMavenSources(
          MavenTools.deps(mvn.sourceDeps), sourcePath);
      extraSourcePaths.add(Uri.directory(sourcePath));
      final jarPath = mvn.jarPath;
      Directory(jarPath).create(recursive: true);
      await MavenTools.downloadMavenJars(
          MavenTools.deps(mvn.sourceDeps + mvn.jarOnlyDeps), jarPath);
      extraJarPaths.addAll(await Directory(jarPath)
          .list()
          .where((entry) => entry.path.endsWith('.jar'))
          .map((entry) => entry.uri)
          .toList());
    }

    final androidConfig = androidSdkConfig;
    if (androidConfig != null) {
      final androidJar = await AndroidSdkUtils.getAndroidJarPath(
          sdkRoot: androidConfig.sdkRoot, versionOrder: androidConfig.versions);
      if (androidJar != null) {
        extraJarPaths.add(Uri.directory(androidJar));
      }
      if (androidConfig.includeSources) {
        final androidSources = await AndroidSdkUtils.getAndroidSourcesPath(
            sdkRoot: androidConfig.sdkRoot,
            versionOrder: androidConfig.versions);
        if (androidSources != null) {
          extraSourcePaths.add(Uri.directory(androidSources));
        }
      }
    }

    summarizer.addSourcePaths(extraSourcePaths);
    summarizer.addClassPaths(extraJarPaths);

    Stream<List<int>> input;
    try {
      input = await summarizer.getInputStream();
    } on Exception catch (e) {
      stderr.writeln('error obtaining API summary: $e');
      return;
    }
    final stream = JsonDecoder().bind(Utf8Decoder().bind(input));
    dynamic json;
    try {
      json = await stream.single;
    } on Exception catch (e) {
      stderr.writeln('error while parsing summary: $e');
      return;
    }
    if (json == null) {
      stderr.writeln('error: expected JSON element from summarizer.');
      return;
    }
    if (dumpJson) {
      stderr.writeln(json);
    }
    final list = json as List;
    try {
      await outputWriter.writeBindings(
          list.map((c) => ClassDecl.fromJson(c)), options);
    } on Exception catch (e, trace) {
      stderr.writeln(trace);
      stderr.writeln('error writing bindings: $e');
    }
  }

  static JniGenTask parseArgs(List<String> args) {
    final config = ConfigProvider.parseArgs(args);

    final List<String> missingValues = [];
    T must<T>(T? Function(String) f, T ifNull, String property) {
      final res = f(property);
      if (res == null) {
        missingValues.add(property);
        return ifNull;
      }
      return res;
    }

    List<Uri>? toUris(List<String>? paths) => paths?.map(Uri.file).toList();

    MemberFilter<T>? regexFilter<T extends ClassMember>(String property) {
      final exclusions = config.getStringList(property);
      if (exclusions == null) return null;
      final List<MemberFilter<T>> filters = [];
      for (var exclusion in exclusions) {
        final split = exclusion.split('#');
        if (split.length != 2) {
          throw FormatException('Error parsing exclusion: "$exclusion"; '
              'expected to be in binaryName#member format.');
        }
        filters.add(MemberNameFilter<T>.exclude(
          RegExp(split[0]),
          RegExp(split[1]),
        ));
      }
      return CombinedMemberFilter<T>(filters);
    }

    String getSdkRoot() {
      final root = config.getString(_Props.androidSdkRoot) ??
          Platform.environment['ANDROID_SDK_ROOT'];
      if (root == null) {
        missingValues.add(_Props.androidSdkRoot);
        return '?';
      }
      return root;
    }

    final task = JniGenTask(
      sourcePath: toUris(config.getStringList(_Props.sourcePath)),
      classPath: toUris(config.getStringList(_Props.classPath)),
      classes: must(config.getStringList, [], _Props.classes),
      summarizerOptions: SummarizerOptions(
        extraArgs: config.getStringList(_Props.summarizerArgs) ?? [],
        backend: config.getString(_Props.backend),
        workingDirectory:
            Uri.directory(config.getString(_Props.summarizerWorkingDir) ?? '.'),
      ),
      exclude: MemberExclusions(
        methods: regexFilter<Method>(_Props.excludeMethods),
        fields: regexFilter<Field>(_Props.excludeFields),
      ),
      cRoot: Uri.directory(must(config.getString, '', _Props.cRoot)),
      dartRoot: Uri.directory(must(config.getString, '', _Props.dartRoot)),
      preamble: config.getString(_Props.preamble) ?? '',
      libraryName: must(config.getString, '', _Props.libraryName),
      importMap: config.getStringMap(_Props.importMap) ?? const {},
      mavenDownloads: config.hasValue(_Props.mavenDownloads)
          ? MavenDownloads(
              sourceDeps: config.getStringList(_Props.sourceDeps) ?? const [],
              sourcePath: config.getString(_Props.mavenSourceDir) ?? 'java',
              jarOnlyDeps: config.getStringList(_Props.jarOnlyDeps) ?? const [],
              jarPath: config.getString(_Props.mavenJarDir) ?? 'jar')
          : null,
      androidSdkConfig: config.hasValue(_Props.androidSdkConfig)
          ? AndroidSdkConfig(
              versions: must<List<String>>(
                      config.getStringList, [], _Props.androidSdkVersions)
                  .map(int.parse)
                  .toList(),
              sdkRoot: getSdkRoot(),
              includeSources:
                  config.getBool(_Props.includeAndroidSources) ?? false,
            )
          : null,
    );
    if (missingValues.isNotEmpty) {
      stderr.write('Following config values are required but not provided\n'
          'Please provide these properties through YAML '
          'or use the command line switch -D<property_name>=<value>.\n');
      for (var missing in missingValues) {
        stderr.writeln('* $missing');
      }
      if (missingValues.contains(_Props.androidSdkRoot)) {
        stderr.writeln('Please specify ${_Props.androidSdkRoot} through '
            'command line or ensure that the ANDROID_SDK_ROOT environment '
            'variable is set.');
      }
      exit(1);
    }
    return task;
  }
}

class _Props {
  static const summarizer = 'summarizer';
  static const summarizerArgs = '$summarizer.extra_args';
  static const summarizerWorkingDir = '$summarizer.working_dir';
  static const backend = '$summarizer.backend';

  static const sourcePath = 'source_path';
  static const classPath = 'class_path';
  static const classes = 'classes';
  static const exclude = 'exclude';
  static const excludeMethods = '$exclude.methods';
  static const excludeFields = '$exclude.fields';

  static const importMap = 'import_map';
  static const cRoot = 'c_root';
  static const dartRoot = 'dart_root';
  static const preamble = 'preamble';
  static const libraryName = 'library_name';

  static const mavenDownloads = 'maven_downloads';
  static const sourceDeps = '$mavenDownloads.source_deps';
  static const mavenSourceDir = '$mavenDownloads.source_dir';
  static const jarOnlyDeps = '$mavenDownloads.jar_only_deps';
  static const mavenJarDir = '$mavenDownloads.jar_dir';

  static const androidSdkConfig = 'android_sdk_config';
  static const androidSdkRoot = '$androidSdkConfig.sdk_root';
  static const androidSdkVersions = '$androidSdkConfig.versions';
  static const includeAndroidSources = '$androidSdkConfig.include_sources';
}
