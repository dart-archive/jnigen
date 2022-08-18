import 'dart:io';

import 'package:path/path.dart' hide equals;
import 'package:jni_gen/jni_gen.dart';
import 'package:jni_gen/tools.dart';
import 'package:test/test.dart';

const packageTestsDir = 'test';

Future<bool> isEmptyDir(String path) async {
  final dir = Directory(path);
  return (!await dir.exists()) || (await dir.list().length == 0);
}

Future<int> runCmd(String exec, List<String> args,
    {String? workingDirectory}) async {
  stderr.writeln('[exec] $exec ${args.join(" ")}');
  final proc = await Process.start(exec, args,
      workingDirectory: workingDirectory,
      runInShell: true,
      mode: ProcessStartMode.inheritStdio);
  return proc.exitCode;
}

Future<void> buildNativeLibs(String testName) async {
  final testRoot = join(packageTestsDir, testName);
  await runCmd('dart', ['run', 'jni:setup']);
  await runCmd('dart', ['run', 'jni:setup', '-S', join(testRoot, 'src')]);
}

Future<List<String>> getJarPaths(String testName) {
  final jarPath = join(packageTestsDir, testName, 'jar');
  return Directory(jarPath)
      .list()
      .map((entry) => entry.path)
      .where((path) => path.endsWith('jar'))
      .toList();
}

/// Download dependencies using maven and generate bindings.
Future<void> generateBindings({
  required String testName,
  required List<String> sourceDepNames,
  required List<String> jarDepNames,
  required List<String> classes,
  required WrapperOptions options,
  required bool isGeneratedFileTest,
  bool useAsmBackend = false,
}) async {
  final testRoot = join(packageTestsDir, testName);
  final jarPath = join(testRoot, 'jar');
  final javaPath = join(testRoot, 'java');
  final src = join(testRoot, isGeneratedFileTest ? 'test_src' : 'src');
  final lib = join(testRoot, isGeneratedFileTest ? 'test_lib' : 'lib');

  final sourceDeps = MvnTools.makeDependencyList(sourceDepNames);
  final jarDeps = MvnTools.makeDependencyList(jarDepNames);

  await runCmd('dart', ['run', 'jni_gen:setup']);

  MvnTools.setVerbose(true);
  if (await isEmptyDir(jarPath)) {
    await Directory(jarPath).create(recursive: true);
    await MvnTools.downloadMavenJars(jarDeps, jarPath);
  }
  if (await isEmptyDir(javaPath)) {
    await Directory(javaPath).create(recursive: true);
    await MvnTools.downloadMavenSources(sourceDeps, javaPath);
  }
  final jars = await getJarPaths(testName);
  stderr.writeln('using classpath: $jars');
  await runTask(JniGenTask(
      summarySource: SummarizerCommand(
        sourcePaths: [Uri.directory(javaPath)],
        classPaths: jars.map(Uri.file).toList(),
        classes: classes,
        extraArgs: useAsmBackend ? ['--backend', 'asm'] : [],
      ),
      options: options,
      outputWriter: FilesWriter(
          cWrapperDir: Uri.directory(src),
          dartWrappersRoot: Uri.directory(lib),
          libraryName: testName)));
}

// compare 2 hierarchies, with and without prefix 'test_'
void compareFiles(String testName, String path) {
  final testRoot = join(packageTestsDir, testName);
  final realPath = join(testRoot, path);
  final dir = Directory(realPath);
  for (var f in dir.listSync(recursive: true)) {
    if (f.statSync().type != FileSystemEntityType.file) {
      continue;
    }
    final relativePath = f.path.replaceFirst('$testRoot/', '');
    final origFile = File(join(testRoot, relativePath));
    final genFile = File(join(testRoot, 'test_$relativePath'));
    expect(genFile.readAsStringSync(), equals(origFile.readAsStringSync()));
  }
}
