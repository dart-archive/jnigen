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

/// Resolver for single-file mapping of input classes.
class SingleFileResolver implements SymbolResolver {
  static const predefined = {
    'java.lang.String': 'jni.JString',
  };
  static final predefinedClasses = {
    'java.lang.String': ClassDecl(
      superclass: TypeUsage.object,
      binaryName: 'java.lang.String',
      packageName: 'java.lang',
      simpleName: 'String',
    ),
  };
  Map<String, ClassDecl> inputClasses;
  SingleFileResolver(this.inputClasses);
  @override
  List<String> getImportStrings() {
    return [];
  }

  @override
  String? resolve(String binaryName) {
    if (predefined.containsKey(binaryName)) return predefined[binaryName];
    return inputClasses[binaryName]?.finalName;
  }

  @override
  ClassDecl? resolveClass(String binaryName) {
    if (predefinedClasses.containsKey(binaryName)) {
      return predefinedClasses[binaryName];
    }
    return inputClasses[binaryName];
  }
}

class SingleFileWriter extends BindingsWriter {
  SingleFileWriter(this.config);
  Config config;
  @override
  Future<void> writeBindings(Classes classes) async {
    final cBased = config.outputConfig.bindingsType == BindingsType.cBased;
    final preamble = config.preamble;
    final Map<String, List<ClassDecl>> packages = {};
    final Map<String, ClassDecl> classesByName = {};

    for (var c in classes.decls.values) {
      classesByName.putIfAbsent(c.binaryName, () => c);
      packages.putIfAbsent(c.packageName, () => <ClassDecl>[]);
      packages[c.packageName]!.add(c);
    }

    ApiPreprocessor.preprocessAll(classes, config);

    if (cBased) {
      await writeCBindings(config, classes.decls.values.toList());
    }
    log.info("Generating ${cBased ? "C + Dart" : "Pure Dart"} Bindings");
    final generator = cBased
        ? CBasedDartBindingsGenerator(config)
        : PureDartBindingsGenerator(config);
    final file = File.fromUri(config.outputConfig.dartConfig.path);
    await file.create(recursive: true);
    final fileStream = file.openWrite();
    final resolver = SingleFileResolver(classes.decls);

    // Have to generate bindings beforehand so that imports are all figured
    // out.
    final bindings = classes.accept(DartGenerator(config))[0].content;
    // final bindings = c.decls.values
    //     .map((decl) => generator.generateBindings(decl, resolver))
    //     .join("\n");

    log.info("Writing Dart bindings to file: ${file.path}");
    fileStream
      ..writeln(preamble ?? '')
      ..writeln(generator.getPreImportBoilerplate())
      ..writeln(resolver.getImportStrings().join('\n'))
      ..writeln(generator.getPostImportBoilerplate())
      ..writeln(bindings);

    await fileStream.close();
    await runDartFormat(file.path);
    log.info('Completed');
    return;
  }
}
