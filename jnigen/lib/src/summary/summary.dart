// Copyright (c) 2022, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import '../../tools.dart';
import '../config/config.dart';
import '../elements/elements.dart';
import '../generate_bindings.dart';
import '../logging/logging.dart';

/// A command based summary source which calls the ApiSummarizer command.
/// [sourcePaths] and [classPaths] can be provided for the summarizer to find
/// required dependencies. The [classes] argument specifies the fully qualified
/// names of classes or packages included in the generated summary. when a
/// package is specified, its contents are included recursively.
///
/// When the default summarizer scans the [sourcePaths], it assumes that
/// the directory names reflect actual package paths. For example, a class name
/// com.example.pkg.Cls will be mapped to com/example/pkg/Cls.java.
///
/// The default summarizer needs to be built with `jnigen:setup`
/// script before this API is used.
class SummarizerCommand {
  SummarizerCommand({
    this.command = "java -jar .dart_tool/jnigen/ApiSummarizer.jar",
    List<Uri>? sourcePath,
    List<Uri>? classPath,
    this.extraArgs = const [],
    required this.classes,
    this.workingDirectory,
    this.backend,
  })  : sourcePaths = sourcePath ?? [],
        classPaths = classPath ?? [] {
    if (backend != null && !{'asm', 'doclet'}.contains(backend)) {
      throw ArgumentError('Supported backends: asm, doclet');
    }
  }

  static const sourcePathsOption = '-s';
  static const classPathsOption = '-c';

  String command;
  List<Uri> sourcePaths, classPaths;

  List<String> extraArgs;
  List<String> classes;

  Uri? workingDirectory;
  String? backend;

  void addSourcePaths(List<Uri> paths) {
    sourcePaths.addAll(paths);
  }

  void addClassPaths(List<Uri> paths) {
    classPaths.addAll(paths);
  }

  void _addPathParam(List<String> args, String option, List<Uri> paths) {
    if (paths.isNotEmpty) {
      final joined = paths
          .map((uri) => uri.toFilePath())
          .join(Platform.isWindows ? ';' : ':');
      if (option.endsWith("=")) {
        args.add(option + joined);
      } else {
        args.addAll([option, joined]);
      }
    }
  }

  Future<Process> runProcess() async {
    final commandSplit = command.split(" ");
    final exec = commandSplit[0];
    final List<String> args = commandSplit.sublist(1);

    _addPathParam(args, sourcePathsOption, sourcePaths);
    _addPathParam(args, classPathsOption, classPaths);
    if (backend != null) {
      args.addAll(['--backend', backend!]);
    }
    args.addAll(extraArgs);
    args.addAll(classes);
    log.info('execute $exec ${args.join(' ')}');
    final proc = await Process.start(exec, args,
        workingDirectory: workingDirectory?.toFilePath() ?? '.');
    return proc;
  }
}

Future<Classes?> getSummary(Config config) async {
  setLoggingLevel(config.logLevel);
  final summarizer = SummarizerCommand(
    sourcePath: config.sourcePath,
    classPath: config.classPath,
    classes: config.classes,
    workingDirectory: config.summarizerOptions?.workingDirectory,
    extraArgs: config.summarizerOptions?.extraArgs ?? const [],
    backend: config.summarizerOptions?.backend,
  );

  // Additional sources added using maven downloads and gradle trickery.
  final extraSources = <Uri>[];
  final extraJars = <Uri>[];
  final mavenDl = config.mavenDownloads;
  if (mavenDl != null) {
    final sourcePath = mavenDl.sourceDir;
    await Directory(sourcePath).create(recursive: true);
    await MavenTools.downloadMavenSources(
        MavenTools.deps(mavenDl.sourceDeps), sourcePath);
    extraSources.add(Uri.directory(sourcePath));
    final jarPath = mavenDl.jarDir;
    await Directory(jarPath).create(recursive: true);
    await MavenTools.downloadMavenJars(
        MavenTools.deps(mavenDl.sourceDeps + mavenDl.jarOnlyDeps), jarPath);
    extraJars.addAll(await Directory(jarPath)
        .list()
        .where((entry) => entry.path.endsWith('.jar'))
        .map((entry) => entry.uri)
        .toList());
  }
  final androidConfig = config.androidSdkConfig;
  if (androidConfig != null && androidConfig.addGradleDeps) {
    final deps = AndroidSdkTools.getGradleClasspaths(
      configRoot: config.configRoot,
      androidProject: androidConfig.androidExample ?? '.',
    );
    extraJars.addAll(deps.map(Uri.file));
  }
  if (androidConfig != null && androidConfig.versions != null) {
    final versions = androidConfig.versions!;
    final androidSdkRoot =
        androidConfig.sdkRoot ?? AndroidSdkTools.getAndroidSdkRoot();
    final androidJar = await AndroidSdkTools.getAndroidJarPath(
        sdkRoot: androidSdkRoot, versionOrder: versions);
    if (androidJar != null) {
      extraJars.add(Uri.directory(androidJar));
    }
  }

  summarizer.addSourcePaths(extraSources);
  summarizer.addClassPaths(extraJars);

  Process process;
  Stream<List<int>> input;
  try {
    process = await summarizer.runProcess();
    input = process.stdout;
  } on Exception catch (e) {
    log.fatal('Cannot obtain API summary: $e');
    return null;
  }
  final errorLog = StringBuffer();
  collectOutputStream(process.stderr, errorLog);
  final stream = const JsonDecoder().bind(const Utf8Decoder().bind(input));
  dynamic json;
  try {
    json = await stream.single;
  } on Exception catch (e) {
    printError(errorLog);
    log.fatal('Cannot parse summary: $e');
    return null;
  }
  if (json == null) {
    log.fatal('Expected JSON element from summarizer.');
    return null;
  }
  final list = json as List;
  final classes = Classes.fromJson(list);
  return classes;
}
