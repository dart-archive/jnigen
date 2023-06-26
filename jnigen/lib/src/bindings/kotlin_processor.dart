// Copyright (c) 2023, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../elements/elements.dart';
import 'visitor.dart';

class KotlinProcessor extends Visitor<Classes, void> {
  @override
  void visit(Classes node) {
    final classProcessor = _KotlinClassProcessor();
    for (final classDecl in node.decls.values) {
      classDecl.accept(classProcessor);
    }
  }
}

class _KotlinClassProcessor extends Visitor<ClassDecl, void> {
  @override
  void visit(ClassDecl node) {
    if (node.kotlinClass == null) {
      return;
    }
    // This [ClassDecl] is actually a Kotlin class.
    // Matching methods and functions from the metadata.
    final functions = <String, KotlinFunction>{};
    for (final function in node.kotlinClass!.functions) {
      functions[function.descriptor] = function;
    }
    for (final method in node.methods) {
      if (functions.containsKey(method.descriptor!)) {
        method.accept(_KotlinMethodProcessor(functions[method.descriptor!]!));
      }
    }
  }
}

class _KotlinMethodProcessor extends Visitor<Method, void> {
  final KotlinFunction function;

  _KotlinMethodProcessor(this.function);

  @override
  void visit(Method node) {
    if (function.isSuspend) {
      const kotlinContinutationType = 'kotlin.coroutines.Continuation';
      assert(node.params.isNotEmpty &&
          node.params.last.type.kind == Kind.declared &&
          node.params.last.type.name == kotlinContinutationType);
      final continuationType = node.params.last.type.type as DeclaredType;
      node.asyncReturnType = continuationType.params.isEmpty
          ? TypeUsage.object
          : continuationType.params.first;
    }
  }
}
