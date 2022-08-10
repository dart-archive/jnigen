import 'dart:io';
import 'package:jni_gen/jni_gen.dart';

void main(List<String> arguments) async {
  final javaPath = 'java/';
  await Process.run('javac', ['dev/dart/jni_gen_test/Example.java'],
      workingDirectory: javaPath);
  try {
    await runTask(JniGenTask(
        summarySource: SummarizerCommand(
          sourcePaths: [Uri.directory(javaPath)],
          classPaths: [Uri.directory(javaPath)],
          classes: ['dev.dart.jni_gen_test.Example'],
        ),
        outputWriter: FilesWriter(
            cWrapperDir: Uri.directory('src/'),
            dartWrappersRoot: Uri.directory('lib/'),
            libraryName: 'jni_gen_test')));
  } on Error catch (e) {
    stderr.writeln(e);
  } on Exception catch (e) {
    stderr.writeln(e);
  }
}
