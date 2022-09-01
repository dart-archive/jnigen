// Copyright (c) 2022, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:jni_gen/jni_gen.dart';
import 'package:jni_gen/tools.dart';

/// Downloads maven dependencies downloaded by equivalent jni_gen invocation.
///
/// Useful for running standalone examples on already generated sources.
void main(List<String> args) async {
  final config = Config.parseArgs(args);
  final mvnDl = config.mavenDownloads;
  if (mvnDl != null) {
    await MavenTools.downloadMavenJars(
        MavenTools.deps(mvnDl.jarOnlyDeps + mvnDl.sourceDeps), mvnDl.jarDir);
    await Directory(mvnDl.jarDir)
        .list()
        .map((entry) => entry.path)
        .where((path) => path.endsWith('.jar'))
        .forEach(stdout.writeln);
  } else {
    stderr.writeln('No maven dependencies found in config.');
    exitCode = 2;
  }
}
