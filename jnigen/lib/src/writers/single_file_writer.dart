// Copyright (c) 2022, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:jnigen/src/bindings/dart_generator.dart';

import '../bindings/bindings.dart';
import '../config/config.dart';
import '../elements/elements.dart';
import '../logging/logging.dart';
import '../writers/bindings_writer.dart';

class SingleFileWriter extends BindingsWriter {
  SingleFileWriter(this.config);
  Config config;
  @override
  Future<void> writeBindings(Classes classes) async {
    final cBased = config.outputConfig.bindingsType == BindingsType.cBased;

    ApiPreprocessor.preprocessAll(classes, config);

    if (cBased) {
      await writeCBindings(config, classes.decls.values.toList());
    }
    log.info("Generating ${cBased ? "C + Dart" : "Pure Dart"} Bindings");
    final binding = classes.accept(DartGenerator(config)).first;
    final file = await binding.file.create(recursive: true);
    final fileStream = file.openWrite();

    log.info("Writing Dart bindings to file: ${file.path}");
    fileStream.writeln(binding.content);

    await fileStream.close();
    await runDartFormat(file.path);
    log.info('Completed');
    return;
  }
}
