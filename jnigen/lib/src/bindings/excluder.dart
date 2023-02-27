// Copyright (c) 2023, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../bindings/element_visitor.dart';
import '../elements/elements.dart';
import '../config/config.dart';

class Excluder extends ElementVisitor<void> {
  const Excluder(this.config);

  final Config config;

  static bool _isPrivate(Set<String> modifiers) =>
      !modifiers.contains("public") && !modifiers.contains("protected");

  @override
  void visitAnnotation(Annotation annotation) {
    throw UnsupportedError('Does not need excluding.');
  }

  @override
  void visitArrayType(ArrayType type) {
    throw UnsupportedError('Does not need excluding.');
  }

  @override
  void visitClasses(Classes classes) {
    classes.decls.removeWhere((_, classDecl) {
      return _isPrivate(classDecl.modifiers) ||
          (config.exclude?.classes?.included(classDecl) ?? false);
    });
    for (final classDecl in classes.decls.values) {
      classDecl.accept(this);
    }
  }

  @override
  void visitClassDecl(ClassDecl classDecl) {
    classDecl.methods = classDecl.methods.where((method) {
      return !_isPrivate(method.modifiers) &&
          !method.name.startsWith('_') &&
          (config.exclude?.methods?.included(classDecl, method) ?? true);
    }).toList();
    classDecl.fields = classDecl.fields.where((field) {
      return !_isPrivate(field.modifiers) &&
          !field.name.startsWith('_') &&
          (config.exclude?.fields?.included(classDecl, field) ?? true);
    }).toList();
  }

  @override
  void visitDeclaredType(DeclaredType type) {
    throw UnsupportedError('Does not need excluding.');
  }

  @override
  void visitField(Field field) {
    throw UnsupportedError('Does not need excluding.');
  }

  @override
  void visitJavaDocComment(JavaDocComment comment) {
    throw UnsupportedError('Does not need excluding.');
  }

  @override
  void visitMethod(Method method) {
    throw UnsupportedError('Does not need excluding.');
  }

  @override
  void visitParam(Param param) {
    throw UnsupportedError('Does not need excluding.');
  }

  @override
  void visitPrimitiveType(PrimitiveType type) {
    throw UnsupportedError('Does not need excluding.');
  }

  @override
  void visitTypeParam(TypeParam typeParam) {
    throw UnsupportedError('Does not need excluding.');
  }

  @override
  void visitTypeUsage(TypeUsage typeUsage) {
    throw UnsupportedError('Does not need excluding.');
  }

  @override
  void visitTypeVar(TypeVar type) {
    throw UnsupportedError('Does not need excluding.');
  }

  @override
  void visitWildcard(Wildcard wildcard) {
    throw UnsupportedError('Does not need excluding.');
  }
}
