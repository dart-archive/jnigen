// Copyright (c) 2022, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:jnigen/jnigen.dart';
import 'package:jnigen/src/bindings/bindings.dart';
import 'package:jnigen/src/bindings/pure_dart_bindings.dart';
import 'package:jnigen/src/writers/bindings_writer.dart';

/// Resolver for single-file mapping of input classes.
class SingleFileResolver implements SymbolResolver {
  Map<String, ClassDecl> inputClasses;
  SingleFileResolver(this.inputClasses);
  @override
  List<String> getImportStrings() {
    return [];
  }

  @override
  String? resolve(String binaryName) {
    if (binaryName == 'java.lang.String') return 'jni.JniString';
    return inputClasses[binaryName]?.finalName;
  }
}

class SingleFileWriter extends BindingsWriter {
  SingleFileWriter(this.config);
  Config config;
  @override
  Future<void> writeBindings(Iterable<ClassDecl> classes) async {
    final preamble = config.preamble;
    final Map<String, List<ClassDecl>> packages = {};
    final Map<String, ClassDecl> classesByName = {};
    for (var c in classes) {
      classesByName.putIfAbsent(c.binaryName, () => c);
      packages.putIfAbsent(c.packageName!, () => <ClassDecl>[]);
      packages[c.packageName!]!.add(c);
    }

    final file = File.fromUri(config.outputPath!);
    await file.create(recursive: true);
    final fileStream = file.openWrite();
    fileStream.writeln(preamble);
    fileStream.writeln(PureDartBindingsGenerator.bindingFileBoilerplate);
    final generator =
        PureDartBindingsGenerator(config, SingleFileResolver(classesByName));
    ApiPreprocessor.preprocessAll(classesByName, config, renameClasses: true);
    final bindings =
        classesByName.values.map(generator.generateBinding).join("\n");
    fileStream.write(bindings);
    await fileStream.close();
    await BindingsWriter.runDartFormat(config.outputPath!.toFilePath());
    return;
  }
}
