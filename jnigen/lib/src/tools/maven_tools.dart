// Copyright (c) 2022, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart';

import '../logging/logging.dart';

/// Deletes all files in the directory, but leaves the directory intact.
void _cleanDirectory(String directoryPath) {
  Directory(directoryPath)
      .listSync()
      .forEach((entry) => entry.deleteSync(recursive: true));
}

/// Type of downloaded artifact (JAR or sources.)
///
/// It does not correspond to maven's formal notion of artifact type.
enum MavenArtifactType {
  jar,
  sources,
}

/// In order to avoid invoking maven every time, jnigen writes a record of
/// downloaded dependencies to the target folder, and uses that file to
/// determine when re-invoking maven is needed. (Eg when dependencies change).
///
/// This is the version string used to indicate breaking changes in layout of
/// cached / downloaded maven dependencies.
///
/// Increment this version to force invalidation.
const _cacheVersion = 'jnigen-maven-cache-v1';

const _cacheRecordNames = {
  MavenArtifactType.jar: 'jnigen_maven_jar_cache.json',
  MavenArtifactType.sources: 'jnigen_maven_src_cache.json',
};

class MavenDependencyCachingTools {
  static String computeCacheRecord(
    MavenArtifactType artifactType,
    List<MavenDependency> mavenDeps,
  ) {
    return jsonEncode({
      'cacheVersion': _cacheVersion,
      'artifactType': artifactType.name.toString(),
      'dependencies': mavenDeps.map((e) => e.toString()).toList(),
    });
  }

  /// Write the cache record for the folder in a JSON file.
  ///
  /// This be invoked after maven dependencies are downloaded.
  static void writeCacheRecord(
    String directoryPath,
    MavenArtifactType artifactType,
    String cacheRecord,
  ) {
    final recordPath = join(directoryPath, _cacheRecordNames[artifactType]);
    final record = File(recordPath);
    record.writeAsStringSync(cacheRecord);
  }

  /// Returns true if there is any file newer than [filename] in directoryPath.
  static bool _isNewestFile(String directoryPath, String filename) {
    final dir = Directory(directoryPath);
    final referenceFile = File(join(directoryPath, filename));
    final referenceLastModified = referenceFile.statSync().modified;
    final files = dir.listSync(recursive: true);
    for (final file in files) {
      if (file.statSync().modified.isAfter(referenceLastModified)) {
        return false;
      }
    }
    // If any file was deleted later, the directory last write time will have
    // changed.
    if (dir.statSync().modified.isAfter(referenceLastModified)) {
      return false;
    }
    return true;
  }

  /// Compares existing cache record to required one.
  ///
  /// If cache is stale, deletes the existing record and returns false.
  /// Otherwise, returns true.
  static bool validateCache(
    String directoryPath,
    MavenArtifactType artifactType,
    String cacheRecord,
  ) {
    final recordName = _cacheRecordNames[artifactType]!;
    final recordPath = join(directoryPath, recordName);
    final record = File(recordPath);
    if (record.existsSync()) {
      final currentCache = record.readAsStringSync();
      if (currentCache == cacheRecord &&
          _isNewestFile(directoryPath, recordName)) {
        return true;
      } else {
        log.info('Cache stale in $directoryPath');
        _cleanDirectory(directoryPath);
        return false;
      }
    }
    return false;
  }

  /// Ensures the target directory exists and is empty.
  static void _ensureEmptyTargetDir(String targetDirPath) {
    final targetDir = Directory(targetDirPath);
    targetDir.createSync(recursive: true);
    if (targetDir.listSync().isNotEmpty) {
      log.severe("Maven target directory not empty.");
    }
  }

  /// Runs [downloaderCallback] wrapped in cache record checks.
  static Future<void> downloadWithCaching(
      String targetDir,
      List<MavenDependency> deps,
      MavenArtifactType artifactType,
      Future<void> Function(List<MavenDependency> deps, String targetDir)
          downloaderCallback,
      {bool logCacheHit = true}) async {
    final cacheRecord = computeCacheRecord(artifactType, deps);
    if (validateCache(targetDir, artifactType, cacheRecord)) {
      if (logCacheHit) {
        log.info('Cached maven ${artifactType.name} dependencies found'
            ' in $targetDir');
      }
      return;
    }
    _ensureEmptyTargetDir(targetDir);

    await downloaderCallback(deps, targetDir);
    writeCacheRecord(targetDir, artifactType, cacheRecord);
  }
}

/// This class provides some utility methods to download a sources / jars
/// using maven along with transitive dependencies.
class MavenTools {
  static final currentDir = Directory(".");

  /// Helper method since we can't pass inheritStdio option to [Process.run].
  static Future<int> _runCmd(String exec, List<String> args,
      [String? workingDirectory]) async {
    log.info('execute $exec ${args.join(" ")}');
    final proc = await Process.start(exec, args,
        workingDirectory: workingDirectory,
        runInShell: true,
        mode: ProcessStartMode.inheritStdio);
    return proc.exitCode;
  }

  static void invalidateCacheRecords({String? jarDir, String? sourceDir}) {
    if (jarDir != null) {
      log.info('Invalidating cached JARs in $jarDir');
      _cleanDirectory(jarDir);
    }
    if (sourceDir != null) {
      log.info('Invalidating cached sources in $sourceDir');
      _cleanDirectory(sourceDir);
    }
  }

  static Future<void> _runMavenCommand(
    List<MavenDependency> deps,
    List<String> mvnArgs,
    Directory tempDir,
  ) async {
    final pom = _getStubPom(deps);
    final tempPom = join(tempDir.path, "temp_pom.xml");
    final tempTarget = join(tempDir.path, "target");
    log.finer('using POM stub:\n$pom');
    await File(tempPom).writeAsString(pom);
    await Directory(tempTarget).create();
    await _runCmd('mvn', ['-q', '-f', tempPom, ...mvnArgs]);
    await File(tempPom).delete();
    await Directory(tempTarget).delete(recursive: true);
  }

  /// Create a list of [MavenDependency] objects from maven coordinates in string form.
  static List<MavenDependency> deps(List<String> depNames) =>
      depNames.map(MavenDependency.fromString).toList();

  /// Downloads and unpacks source files of [deps] into [targetDir].
  static Future<void> _fetchMavenSources(
      List<MavenDependency> deps, String targetDir) async {
    final tempDir = await currentDir.createTemp("maven_temp_");
    await _runMavenCommand(
      deps,
      [
        'dependency:unpack-dependencies',
        '-DexcludeTransitive=true',
        '-DoutputDirectory=../$targetDir',
        '-Dclassifier=sources',
      ],
      tempDir,
    );
    await tempDir.delete(recursive: true);
  }

  /// Downloads JAR files of all [deps] transitively into [targetDir].
  static Future<void> _fetchMavenJars(
      List<MavenDependency> deps, String targetDir) async {
    final tempDir = await currentDir.createTemp("maven_temp_");
    await _runMavenCommand(
      deps,
      [
        'dependency:copy-dependencies',
        '-DoutputDirectory=../$targetDir',
      ],
      tempDir,
    );
    await tempDir.delete(recursive: true);
  }

  /// Downloads and unpacks source files of [deps] into [targetDir], making use
  /// of caching when possible.
  static Future<void> downloadMavenSources(
      List<MavenDependency> deps, String targetDir) async {
    await MavenDependencyCachingTools.downloadWithCaching(
        targetDir, deps, MavenArtifactType.sources, _fetchMavenSources);
  }

  /// Downloads JAR files of all [deps] transitively into [targetDir], making
  /// use of caching when possible.
  static Future<void> downloadMavenJars(
      List<MavenDependency> deps, String targetDir) async {
    await MavenDependencyCachingTools.downloadWithCaching(
        targetDir, deps, MavenArtifactType.jar, _fetchMavenJars);
  }

  static String _getStubPom(List<MavenDependency> deps,
      {String javaVersion = '11'}) {
    final depDecls = <String>[];
    for (var dep in deps) {
      depDecls.add('''
      <dependency>
        <groupId>${dep.groupID}</groupId>
        <artifactId>${dep.artifactID}</artifactId>
        <version>${dep.version}</version>
      </dependency>''');
    }
    return '''
<project xmlns="http://maven.apache.org/POM/4.0.0"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://maven.apache.org/POM/4.0.0
  http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>
    <groupId>com.mycompany.app</groupId>
    <artifactId>jnigen_maven_stub</artifactId>
    <version>1.0-SNAPSHOT</version>
    <properties>
      <maven.compiler.source>$javaVersion</maven.compiler.source>
      <maven.compiler.target>$javaVersion</maven.compiler.target>
    </properties>
    <dependencies>
${depDecls.join("\n")}
    </dependencies>
    <build>
      <directory>\${project.basedir}/target</directory>
    </build>
</project>''';
  }
}

/// Maven dependency with group ID, artifact ID, and version.
class MavenDependency {
  MavenDependency(this.groupID, this.artifactID, this.version);
  factory MavenDependency.fromString(String fullName) {
    final components = fullName.split(':');
    if (components.length != 3) {
      throw ArgumentError('invalid name for maven dependency: $fullName');
    }
    return MavenDependency(components[0], components[1], components[2]);
  }

  @override
  String toString() {
    return '$groupID:$artifactID:$version';
  }

  final String groupID, artifactID, version;
}
