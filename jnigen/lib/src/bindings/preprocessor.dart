// Copyright (c) 2022, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:jnigen/src/bindings/excluder.dart';
import 'package:jnigen/src/bindings/linker.dart';
import 'package:jnigen/src/bindings/renamer.dart';

import '../elements/elements.dart';
import '../config/config.dart';

/// Preprocessor which fills information needed by both Dart and C generators.
abstract class ApiPreprocessor {
  static void preprocessAll(Classes classes, Config config) {
    classes
      ..accept(Excluder(config))
      ..accept(Linker(config))
      ..accept(Renamer(config));
  }
}
