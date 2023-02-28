// Copyright (c) 2023, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../bindings/element_visitor.dart';
import '../config/config.dart';
import '../elements/elements.dart';

/// Adds references from child elements back to their parent elements.
class Linker extends ElementVisitor<void> {
  Linker(this.config);

  final Config config;
  late final Map<String, ClassDecl> _classes;
  final _linked = <ClassDecl>{};

  ClassDecl _resolve(String? name) {
    return _classes[name] ?? ClassDecl.object;
  }

  @override
  void visitAnnotation(Annotation annotation) {
    throw UnsupportedError('Does not need linking.');
  }

  @override
  void visitArrayType(ArrayType type) {
    type.type.accept(this);
  }

  @override
  void visitClasses(Classes classes) {
    _classes = classes.decls;
    for (final classDecl in classes.decls.values) {
      classDecl.accept(this);
    }
  }

  @override
  void visitClassDecl(ClassDecl classDecl) {
    if (_linked.contains(classDecl)) return;
    _linked.add(classDecl);

    classDecl.parent = _resolve(classDecl.parentName);
    classDecl.parent!.accept(this);
    // Adding type params of outer classes to the nested classes
    final allTypeParams = <TypeParam>[];
    if (!classDecl.modifiers.contains('static')) {
      for (final typeParam in classDecl.parent!.allTypeParams) {
        if (!classDecl.allTypeParams.contains(typeParam)) {
          // Add only if it's not shadowing another type param.
          allTypeParams.add(typeParam);
        }
      }
    }
    allTypeParams.addAll(classDecl.typeParams);
    classDecl.allTypeParams = allTypeParams;

    classDecl.superclass ??= TypeUsage.object;
    classDecl.superclass!.type.accept(this);
    final superclass = (classDecl.superclass!.type as DeclaredType).classDecl;
    superclass.accept(this);

    for (final field in classDecl.fields) {
      field.classDecl = classDecl;
      field.accept(this);
    }
    for (final method in classDecl.methods) {
      method.classDecl = classDecl;
      method.accept(this);
    }
  }

  @override
  void visitDeclaredType(DeclaredType type) {
    type.classDecl = _resolve(type.binaryName);
  }

  @override
  void visitField(Field field) {
    field.type.accept(this);
  }

  @override
  void visitJavaDocComment(JavaDocComment comment) {
    throw UnsupportedError('Does not need linking.');
  }

  @override
  void visitMethod(Method method) {
    method.returnType.accept(this);
    for (final typeParam in method.typeParams) {
      typeParam.accept(this);
    }
    for (final param in method.params) {
      param.accept(this);
    }
    // Kotlin specific
    const kotlinContinutationType = 'kotlin.coroutines.Continuation';
    if (config.suspendFunToAsync &&
        method.params.isNotEmpty &&
        method.params.last.type.kind == Kind.declared &&
        method.params.last.type.shorthand == kotlinContinutationType) {
      final continuationType = method.params.last.type.type as DeclaredType;
      method.asyncReturnType = continuationType.params.isEmpty
          ? TypeUsage.object
          : continuationType.params.first;
    } else {
      method.asyncReturnType = null;
    }
    method.asyncReturnType?.accept(this);
  }

  @override
  void visitParam(Param param) {
    param.type.accept(this);
  }

  @override
  void visitPrimitiveType(PrimitiveType type) {
    // Do nothing.
  }

  @override
  void visitTypeParam(TypeParam typeParam) {
    for (final bound in typeParam.bounds) {
      bound.accept(this);
    }
  }

  @override
  void visitTypeUsage(TypeUsage typeUsage) {
    typeUsage.type.accept(this);
  }

  @override
  void visitTypeVar(TypeVar type) {
    // Do nothing.
  }

  @override
  void visitWildcard(Wildcard wildcard) {
    wildcard.superBound?.accept(this);
    wildcard.extendsBound?.accept(this);
  }
}
