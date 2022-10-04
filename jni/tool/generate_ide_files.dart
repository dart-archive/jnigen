// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:args/args.dart';

void runCommand(String exec, List<String> args, String workingDirectory) {
  stderr.writeln('+ $exec ${args.join(" ")}');
  final process =
      Process.runSync(exec, args, workingDirectory: workingDirectory);
  if (process.exitCode != 0) {
    stdout.writeln(process.stdout);
    stderr.writeln(process.stderr);
    throw "command failed with exit code ${process.exitCode}";
  }
}

void main(List<String> arguments) {
  final argParser = ArgParser()
    ..addOption(
      "generator",
      abbr: 'G',
      help: 'Generator to pass to CMake',
      allowed: ['Ninja', 'Unix Makefiles'],
      defaultsTo: Platform.isWindows ? 'Ninja' : 'Unix Makefiles',
    );
  final argResults = argParser.parse(arguments);
  if (argResults.rest.isNotEmpty) {
    stderr.writeln(argParser.usage);
    exitCode = 1;
    return;
  }
  final generator = argResults['generator'];
  final tempDir = Directory.current.createTempSync("clangd_setup_temp_");
  final src = Directory.current.uri.resolve("src/");
  try {
    runCommand(
        "cmake",
        [
          "-DCMAKE_EXPORT_COMPILE_COMMANDS=1",
          src.toFilePath(),
          "-G",
          generator,
        ],
        tempDir.path);
    final createdFile = tempDir.uri.resolve("compile_commands.json");
    final target = src.resolve("compile_commands.json");
    File.fromUri(createdFile).renameSync(target.toFilePath());
  } finally {
    tempDir.deleteSync(recursive: true);
  }
}
