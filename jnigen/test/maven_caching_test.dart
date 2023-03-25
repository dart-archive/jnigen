// Copyright (c) 2022, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// End-to-end test confirming yaml config works as expected.

import 'dart:io';

import 'package:jnigen/src/tools/maven_tools.dart';
import 'package:path/path.dart' hide equals;
import 'package:test/test.dart';

const jacksonCoordinates = 'com.fasterxml.jackson.core:jackson-core:2.13.4';
const pdfBoxCoordinates = 'org.apache.pdfbox:pdfbox:2.0.26';

const jarDir = 'mvn_jar';
const srcDir = 'mvn_src';
const testFileJar1 = 'TestFile1.jar';
const testFileJar2 = 'TestFile2.jar';
const testFileJava1 = 'TestFile1.java';
const testFileJava2 = 'TestFile2.java';

typedef CachingTools = MavenDependencyCachingTools;

typedef FileAction = void Function(String path);

final currentDir = Directory(".");

void writeDummyJars(String targetDir) {
  File(join(targetDir, testFileJar1)).writeAsStringSync("test file 1");
  File(join(targetDir, testFileJar2)).writeAsStringSync("test file 2");
}

void main() {
  // Most tests in this file do not actually invoke maven. They actually just
  // write some random files to test directory. The implementation should not
  // care about the type of files.

  final jacksonDependency = MavenDependency.fromString(jacksonCoordinates);
  final pdfBoxDependency = MavenDependency.fromString(pdfBoxCoordinates);

  test("Test cache record format", () {
    final computedRecord = CachingTools.computeCacheRecord(
      MavenArtifactType.sources,
      [jacksonDependency, pdfBoxDependency],
    );
    expect(computedRecord, contains(pdfBoxCoordinates));
    expect(computedRecord, contains(jacksonCoordinates));
    expect(computedRecord, contains(MavenArtifactType.sources.name));
  });

  group('Test maven jar caching', () {
    final deps = [jacksonDependency];
    const artifactType = MavenArtifactType.jar;
    final cacheRecord = CachingTools.computeCacheRecord(artifactType, deps);
    final tempDir = currentDir.createTempSync("mvn_cache_test");

    String createTargetDir() {
      final target = tempDir.createTempSync("mvn_jar_");
      return target.path;
    }

    Future<void> downloadWithCaching(String targetDir) async {
      await Directory(targetDir).create();
      await CachingTools.downloadWithCaching(
        targetDir,
        [jacksonDependency],
        MavenArtifactType.jar,
        (deps, targetDir) async => writeDummyJars(targetDir),
      );
    }

    test('Check invalidation with different set of deps', () async {
      final targetDir = createTargetDir();
      await downloadWithCaching(targetDir);
      final validation1 =
          CachingTools.validateCache(targetDir, artifactType, cacheRecord);
      expect(validation1, isTrue, reason: 'Freshly written cache is invalid');

      final differentCacheRecord = CachingTools.computeCacheRecord(
        artifactType,
        [jacksonDependency, pdfBoxDependency],
      );
      final validation2 = CachingTools.validateCache(
          targetDir, artifactType, differentCacheRecord);
      expect(validation2, isFalse,
          reason: 'Cache considered valid with different dependency set');
    });

    Future<void> checkInvalidationAfterFileAction(FileAction action) async {
      final targetDir = createTargetDir();
      await downloadWithCaching(targetDir);
      final validation1 =
          CachingTools.validateCache(targetDir, artifactType, cacheRecord);
      expect(validation1, isTrue, reason: 'Freshly written cache is invalid');
      // Depending on resoultion of the last modified timestamp,
      // we may need to pass some time to see the effect.
      sleep(const Duration(seconds: 1, milliseconds: 100));
      action(join(targetDir, testFileJar1));
      final validation2 =
          CachingTools.validateCache(targetDir, artifactType, cacheRecord);
      expect(validation2, isFalse, reason: 'Stale cache is considered valid');
    }

    test('Check cache invalidation after file modification', () async {
      await checkInvalidationAfterFileAction(
        (path) => File(path).writeAsStringSync("Invalid"),
      );
    });

    test('Check invalidation after file deletion', () async {
      await checkInvalidationAfterFileAction((path) => File(path).deleteSync());
    });

    tearDownAll(() => tempDir.deleteSync(recursive: true));
  });
}
