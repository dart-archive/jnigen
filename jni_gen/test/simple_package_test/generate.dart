import 'dart:io';

import 'package:path/path.dart';
import 'package:jni_gen/jni_gen.dart';

import '../test_util/test_util.dart';

const testName = 'simple_package_test';
final testRoot = join('test', testName);
final javaPath = join(testRoot, 'java');

var javaFiles = ['dev/dart/$testName/Example.java', 'dev/dart/pkg2/C2.java'];

Future<void> compileJavaSources(String workingDir, List<String> files) async {
  await runCmd('javac', files, workingDirectory: workingDir);
}

Future<void> generateSources(String lib, String src) async {
  await runCmd('dart', ['run', 'jni_gen:setup']);
  await compileJavaSources(javaPath, javaFiles);
  final cWrapperDir = Uri.directory(join(testRoot, src));
  final dartWrappersRoot = Uri.directory(join(testRoot, lib));
  final cDir = Directory.fromUri(cWrapperDir);
  final dartDir = Directory.fromUri(dartWrappersRoot);
  for (var dir in [cDir, dartDir]) {
    if (await dir.exists()) {
      await dir.delete(recursive: true);
    }
  }
  await runTask(
    JniGenTask(
      summarySource: SummarizerCommand(
        sourcePaths: [Uri.directory(javaPath)],
        classPaths: [Uri.directory(javaPath)],
        classes: ['dev.dart.simple_package', 'dev.dart.pkg2'],
      ),
      outputWriter: FilesWriter(
          cWrapperDir: cWrapperDir,
          dartWrappersRoot: dartWrappersRoot,
          libraryName: 'simple_package'),
    ),
  );
}

void main() async => await generateSources('lib', 'src');
