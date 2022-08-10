// this script takes a vendored ApiSummarizer and builds with maven.

import 'dart:io';

import 'package:path/path.dart';

import 'package:jni_gen/src/util/find_package.dart';

final toolPath = join('.', '.dart_tool', 'jni_gen');
final mvnTargetDir = join(toolPath, 'target');
final jarFile = join(toolPath, 'ApiSummarizer.jar');
final targetJarFile = join(mvnTargetDir, 'ApiSummarizer.jar');

// check if there's a ApiSummarizer.jar under ./dart_tool/jni_gen/
Future<bool> isApiSummarizerBuilt() => File(jarFile).exists();

// This script gets the vendored sources for ApiSummarizer from pub cache
// clones them to jarPath/mvn_build, and runs mvn build, then moves the target
// jar back to jarPath, and deletes mvn_build.

Future<void> buildApiSummarizer() async {
  final pkg = await findPackage('jni_gen');
  if (pkg == null) {
    stderr.writeln('package jni_gen not found!');
    exitCode = 2;
    return;
  }
  final pom = pkg.resolve('third_party/ApiSummarizer/pom.xml');
  await Directory(toolPath).create(recursive: true);
  final mvnProc = await Process.start(
      'mvn',
      [
        '--batch-mode',
        '--update-snapshots',
        '-f',
        pom.toFilePath(),
        'assembly:assembly'
      ],
      workingDirectory: toolPath,
      mode: ProcessStartMode.inheritStdio);
  await mvnProc.exitCode;
  // move ApiSummarizer.jar from target to current directory
  File(targetJarFile).renameSync(jarFile);
  Directory(mvnTargetDir).deleteSync(recursive: true);
}

void main() async {
  if (!await isApiSummarizerBuilt()) {
    await buildApiSummarizer();
  } else {
    stderr.writeln('ApiSummarizer.jar exists. Skipping build..');
  }
}
