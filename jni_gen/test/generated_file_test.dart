import 'dart:io';
import 'package:jni_gen/jni_gen.dart';
import 'package:path/path.dart' hide equals;
import 'package:test/test.dart';

final samplePath = join('test', 'sample');
final javaPath = join(samplePath, 'java');

Future<void> generateSources() async {
  await Process.run('dart', ['run', 'jni_gen:setup']);
  await Process.run('javac', ['dev/dart/sample/Example.java'],
      workingDirectory: javaPath);
  try {
    final cWrapperDir = Uri.directory(join(samplePath, 'test_src'));
    final dartWrappersRoot = Uri.directory(join(samplePath, 'test_lib'));
    final cDir = Directory.fromUri(cWrapperDir);
    final dartDir = Directory.fromUri(dartWrappersRoot);
    if (await cDir.exists()) {
      await Directory.fromUri(cWrapperDir).delete(recursive: true);
    }
    if (await dartDir.exists()) {
      await Directory.fromUri(dartWrappersRoot).delete(recursive: true);
    }
    await runTask(
      JniGenTask(
        summarySource: SummarizerCommand(
          sourcePaths: [Uri.directory(javaPath)],
          classPaths: [Uri.directory(javaPath)],
          classes: ['dev.dart.sample.Example'],
        ),
        outputWriter: FilesWriter(
            cWrapperDir: cWrapperDir,
            dartWrappersRoot: dartWrappersRoot,
            libraryName: 'jni_gen_sample'),
      ),
    );
  } on JniGenException catch (e) {
    stderr.writeln(e);
  }
}

void compareFiles(String path) {
  expect(File(join(samplePath, path)).readAsStringSync(),
      equals(File(join(samplePath, 'test_$path')).readAsStringSync()));
}

void main() async {
  await generateSources();
  // test if generated file == expected file
  test('compare generated files', () {
    compareFiles(join('lib', 'init.dart'));
    compareFiles(join('lib', 'dev', 'dart', 'sample.dart'));
    compareFiles(join('src', 'CMakeLists.txt'));
    compareFiles(join('src', 'jni_gen_sample.c'));
    compareFiles(join('src', 'dartjni.h'));
  });
}
