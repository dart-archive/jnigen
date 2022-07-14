import 'dart:io';

import 'package:args/args.dart';

const _buildDir = "build-dir";
const _srcDir = "source-dir";
const _verbose = "verbose";
const _cmakeArgs = "cmake-args";
const _clean = "clean";

// Sets up input output channels and maintains state.
class CommandRunner {
  CommandRunner({this.printCmds = false});
  bool printCmds = false;
  int? time;
  // TODO: time commands
  // TODO: Run all commands in single shell instance
  // IssueRef: https://github.com/dart-lang/jni_gen/issues/14
  Future<CommandRunner> run(
      String exec, List<String> args, String workingDir) async {
    if (printCmds) {
      final cmd = "$exec ${args.join(" ")}";
      stderr.writeln("\n+ [$workingDir] $cmd");
    }
    final process = await Process.start(exec, args,
        workingDirectory: workingDir,
        runInShell: Platform.isWindows,
        mode: ProcessStartMode.inheritStdio);
    final exitCode = await process.exitCode;
    if (exitCode != 0) {
      stderr.writeln("command exited with $exitCode");
    }
    return this;
  }
}

class Options {
  Options(ArgResults arg)
      : buildDir = arg[_buildDir],
        srcDir = arg[_srcDir],
        cmakeArgs = arg[_cmakeArgs],
        verbose = arg[_verbose] ?? false,
        clean = arg[_clean] ?? false;

  String? buildDir, srcDir, cmakeArgs;
  bool verbose, clean;
}

late Options options;
void log(String msg) {
  if (options.verbose) {
    stderr.writeln(msg);
  }
}

void main(List<String> arguments) async {
  final parser = ArgParser()
    ..addOption(_buildDir,
        abbr: 'B', help: 'Directory to place built artifacts')
    ..addOption(_srcDir,
        abbr: 'S', help: 'alternative path to package:jni sources')
    ..addFlag(_verbose, abbr: 'v', help: 'Enable verbose output')
    ..addFlag(_clean,
        negatable: false,
        abbr: 'C',
        help: 'Clear built artifacts instead of running a build')
    ..addOption(_cmakeArgs,
        abbr: 'm',
        help: 'additional space separated arguments to pass to CMake');
  final cli = parser.parse(arguments);
  options = Options(cli);
  final rest = cli.rest;

  if (rest.isNotEmpty) {
    stderr.writeln("one or more unrecognized arguments: $rest");
    stderr.writeln("usage: dart run jni:setup <options>");
    stderr.writeln(parser.usage);
    exitCode = 1;
    return;
  }

  final scriptUri = Platform.script;
  log("scriptUri: $scriptUri");
  final srcPath = options.srcDir ?? scriptUri.resolve("../src").toFilePath();
  final srcDir = Directory(srcPath);
  if (!await srcDir.exists()) {
    throw 'Directory $srcPath does not exist';
  }
  log("srcPath: $srcPath");

  final currentDirUri = Uri.file(".");
  final buildPath =
      options.buildDir ?? currentDirUri.resolve("src/build").toFilePath();
  final buildDir = Directory(buildPath);
  await buildDir.create(recursive: true);
  log("buildPath: $buildPath");

  if (buildDir.absolute.uri == srcDir.absolute.uri) {
    stderr.writeln("Please build in a directory different than source.");
    exit(2);
  }

  if (options.clean) {
    await cleanup(options, srcDir.absolute.path, buildDir.absolute.path);
  } else {
    await build(options, srcDir.absolute.path, buildDir.absolute.path);
  }
}

Future<void> build(Options options, String srcPath, String buildPath) async {
  final runner = CommandRunner(printCmds: true);
  final cmakeArgs = [srcPath];
  if (options.cmakeArgs != null) {
    cmakeArgs.addAll(options.cmakeArgs!.split(" "));
  }
  await runner.run("cmake", cmakeArgs, buildPath);
  await runner.run("cmake", ["--build", "."], buildPath);
  if (Platform.isWindows) {
    await runner.run("move", ["Debug\\dartjni.dll", "."], buildPath);
  }
}

Future<FileSystemEntity> cleanup(
    Options options, String srcPath, String buildPath) async {
  stderr.writeln("deleting $buildPath");
  return Directory(buildPath).delete(recursive: true);
}
