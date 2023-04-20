// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:jnigen/jnigen.dart';
import 'package:jnigen/src/util/find_package.dart';
import 'package:path/path.dart' hide equals;
import 'package:test/test.dart';
import 'package:logging/logging.dart' show Level;

import 'package:jnigen/src/logging/logging.dart';

final _currentDirectory = Directory(".");

Directory getTempDir(String prefix) {
  return _currentDirectory.createTempSync(prefix);
}

Future<bool> isEmptyOrNotExistDir(String path) async {
  final dir = Directory(path);
  return (!await dir.exists()) || (await dir.list().length == 0);
}

/// Runs command, and prints output only if the exit status is non-zero.
Future<int> runCommand(String exec, List<String> args,
    {String? workingDirectory, bool runInShell = false}) async {
  final proc = await Process.run(exec, args,
      workingDirectory: workingDirectory, runInShell: runInShell);
  if (proc.exitCode != 0) {
    printError('command exited with exit status ${proc.exitCode}:\n'
        '$exec ${args.join(" ")}\n');
    printError(proc.stdout);
    printError(proc.stderr);
  }
  return proc.exitCode;
}

/// List all JAR files in [testRoot]/jar
Future<List<String>> getJarPaths(String testRoot) async {
  final jarPath = join(testRoot, 'jar');
  if (!await Directory(jarPath).exists()) {
    return [];
  }
  return Directory(jarPath)
      .list()
      .map((entry) => entry.path)
      .where((path) => path.endsWith('.jar'))
      .toList();
}

/// Read file normalizing CRLF to LF.
String readFile(File file) => file.readAsStringSync().replaceAll('\r\n', '\n');

/// Compares 2 hierarchies using `git diff --no-index`.
void comparePaths(String path1, String path2) {
  final diffCommand = [
    "diff",
    "--no-index",
    if (stderr.supportsAnsiEscapes) "--color=always",
  ];
  final diffProc = Process.runSync("git", [...diffCommand, path1, path2]);
  if (diffProc.exitCode != 0) {
    final originalDiff = diffProc.stdout;
    log.warning(
        "Paths $path1 and $path2 differ, comparing by ignoring space change");
    final fallbackDiffProc = Process.runSync(
        "git", [...diffCommand, '--ignore-space-change', path1, path2]);
    if (fallbackDiffProc.exitCode != 0) {
      stderr.writeln(originalDiff);
      throw Exception("Paths $path1 and $path2 differ");
    }
  }
}

Future<void> _generateTempBindings(Config config, Directory tempDir) async {
  final tempSrc = tempDir.uri.resolve("src/");
  final singleFile =
      config.outputConfig.dartConfig.structure == OutputStructure.singleFile;
  final tempLib = singleFile
      ? tempDir.uri.resolve("generated.dart")
      : tempDir.uri.resolve("lib/");
  if (config.outputConfig.bindingsType == BindingsType.cBased) {
    config.outputConfig.cConfig!.path = tempSrc;
  }
  config.outputConfig.dartConfig.path = tempLib;
  config.logLevel = Level.WARNING;
  await generateJniBindings(config);
}

/// Generates and compares bindings with reference bindings.
///
/// [dartReferenceBindings] can be directory or file depending on output
/// configuration.
///
/// If the config generates C code, [cReferenceBindings] must be a non-null
/// directory path.
Future<void> generateAndCompareBindings(Config config,
    String dartReferenceBindings, String? cReferenceBindings) async {
  final currentDir = Directory.current;
  final tempDir = currentDir.createTempSync("jnigen_test_temp");
  final tempSrc = tempDir.uri.resolve("src/");
  final singleFile =
      config.outputConfig.dartConfig.structure == OutputStructure.singleFile;
  final tempLib = singleFile
      ? tempDir.uri.resolve("generated.dart")
      : tempDir.uri.resolve("lib/");
  try {
    await _generateTempBindings(config, tempDir);
    comparePaths(dartReferenceBindings, tempLib.toFilePath());
    if (config.outputConfig.bindingsType == BindingsType.cBased) {
      comparePaths(cReferenceBindings!, tempSrc.toFilePath());
    }
  } finally {
    tempDir.deleteSync(recursive: true);
  }
}

Future<void> generateAndAnalyzeBindings(Config config) async {
  final tempDir = Directory.current.createTempSync("jnigen_test_temp");
  try {
    await _generateTempBindings(config, tempDir);
    final analyzeResult = Process.runSync("dart", ["analyze", tempDir.path]);
    expect(analyzeResult.exitCode, equals(0),
        reason: "Analyzer exited with non-zero status");
  } finally {
    tempDir.deleteSync(recursive: true);
  }
}

final summarizerJar = join('.', '.dart_tool', 'jnigen', 'ApiSummarizer.jar');

Future<void> failIfSummarizerNotBuilt() async {
  final jarExists = await File(summarizerJar).exists();
  if (!jarExists) {
    stderr.writeln();
    log.fatal('Please build summarizer by running '
        '`dart run jnigen:setup` and try again');
  }
  final isJarStale = jarExists &&
      await isPackageModifiedAfter(
          'jnigen', await File(summarizerJar).lastModified(), 'java/');
  if (isJarStale) {
    stderr.writeln();
    log.fatal('Summarizer is not rebuilt after recent changes. '
        'Please run `dart run jnigen:setup` and try again.');
  }
}

/// Verifies if locally built dependencies (currently `ApiSummarizer`)
/// are up-to-date.
Future<void> checkLocallyBuiltDependencies() async {
  await failIfSummarizerNotBuilt();
}
