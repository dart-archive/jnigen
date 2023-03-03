// Copyright (c) 2023, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'visitor.dart';
import '../elements/elements.dart';
import '../config/config.dart';

bool _isPrivate(Set<String> modifiers) =>
    !modifiers.contains("public") && !modifiers.contains("protected");

class Excluder extends Visitor<Classes> {
  const Excluder(this.config);

  final Config config;

  @override
  void visit(Classes node) {
    node.decls.removeWhere((_, classDecl) {
      return _isPrivate(classDecl.modifiers) ||
          (config.exclude?.classes?.included(classDecl) ?? false);
    });
    final classExcluder = _ClassExcluder(config);
    for (final classDecl in node.decls.values) {
      classDecl.accept(classExcluder);
    }
  }
}

class _ClassExcluder extends Visitor<ClassDecl> {
  _ClassExcluder(this.config);

  final Config config;

  @override
  void visit(ClassDecl node) {
    node.methods = node.methods.where((method) {
      return !_isPrivate(method.modifiers) &&
          !method.name.startsWith('_') &&
          (config.exclude?.methods?.included(node, method) ?? true);
    }).toList();
    node.fields = node.fields.where((field) {
      return !_isPrivate(field.modifiers) &&
          !field.name.startsWith('_') &&
          (config.exclude?.fields?.included(node, field) ?? true);
    }).toList();
  }
}
