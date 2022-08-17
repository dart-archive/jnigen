import 'dart:io';

import 'package:path/path.dart';
import 'package:jni_gen/jni_gen.dart';

final simplePackagePath = join('test', 'simple_package');
final javaPath = join(simplePackagePath, 'java');

Future<int> runCmd(String exec, List<String> args,
    {String? workingDirectory}) async {
  final proc = await Process.start(exec, args,
      workingDirectory: workingDirectory,
      runInShell: true,
      mode: ProcessStartMode.inheritStdio);
  return proc.exitCode;
}

Future<void> generateSources(String lib, String src) async {
  await runCmd('dart', ['run', 'jni_gen:setup']);
  await runCmd('javac',
      ['dev/dart/simple_package/Example.java', 'dev/dart/pkg2/C2.java'],
      workingDirectory: javaPath);

  try {
    final cWrapperDir = Uri.directory(join(simplePackagePath, src));
    final dartWrappersRoot = Uri.directory(join(simplePackagePath, lib));
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
          classes: ['dev.dart.simple_package', 'dev.dart.pkg2'],
        ),
        outputWriter: FilesWriter(
            cWrapperDir: cWrapperDir,
            dartWrappersRoot: dartWrappersRoot,
            libraryName: 'simple_package'),
      ),
    );
  } on JniGenException catch (e) {
    stderr.writeln(e);
  }
}

void main() async => await generateSources('lib', 'src');
