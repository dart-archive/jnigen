import 'dart:io';
import 'package:jni_gen/src/util/command_output.dart';

abstract class SummarySource {
  Future<Stream<List<int>>> getInputStream();
}

/// A command based summary source.
class SummarizerCommand extends SummarySource {
  SummarizerCommand({
    this.command = "java -jar .dart_tool/jni_gen/ApiSummarizer.jar",
    this.sourcePathsOption = '-s',
    this.classPathsOption = '-c',
    required this.sourcePaths,
    this.classPaths = const [],
    this.extraArgs = const [],
    required this.classes,
    this.workingDirectory,
  });

  String command;
  String sourcePathsOption, classPathsOption;
  List<Uri> sourcePaths, classPaths;
  List<String> extraArgs;
  List<String> classes;

  Uri? workingDirectory;

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

  @override
  Future<Stream<List<int>>> getInputStream() async {
    final commandSplit = command.split(" ");
    final exec = commandSplit[0];
    final List<String> args = commandSplit.sublist(1);

    _addPathParam(args, sourcePathsOption, sourcePaths);
    _addPathParam(args, classPathsOption, classPaths);
    args.addAll(extraArgs);
    args.addAll(classes);

    final proc = await Process.start(exec, args,
        workingDirectory: workingDirectory?.toFilePath() ?? '.');
    prefixedCommandOutputStream('[ApiSummarizer]', proc.stderr)
        .forEach(stderr.writeln);
    return proc.stdout;
  }
}

/// A JSON file based summary source.
// (Did not test it yet)
class SummaryFile extends SummarySource {
  Uri path;
  SummaryFile(this.path);
  SummaryFile.fromPath(String path) : path = Uri.file(path);

  @override
  Future<Stream<List<int>>> getInputStream() async =>
      File.fromUri(path).openRead();
}
