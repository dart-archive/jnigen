// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// This script generates all FFIGEN-based bindings we require to use JNI, which
// includes some C wrappers over `JNIEnv` type and some Dart extension methods.

import 'dart:io';

import 'wrapper_generators/logging.dart';
import 'wrapper_generators/generate_c_extensions.dart';
import 'wrapper_generators/generate_dart_extensions.dart';

import 'package:ffigen/ffigen.dart' as ffigen;

void main() {
  logger.info("Generating C wrappers");

  final minimalConfig = ffigen.Config.fromFile(File('ffigen_exts.yaml'));
  final minimalLibrary = ffigen.parse(minimalConfig);
  generateCWrappers(minimalLibrary);

  logger.info("Generating FFI bindings for package:jni");

  final config = ffigen.Config.fromFile(File('ffigen.yaml'));
  final library = ffigen.parse(config);
  final outputFile = File(config.output);
  library.generateFile(outputFile);

  logger.info("Generating Dart extensions");
  generateDartExtensions(library);
}
