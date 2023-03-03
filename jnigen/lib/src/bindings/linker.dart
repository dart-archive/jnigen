// Copyright (c) 2023, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'visitor.dart';
import '../config/config.dart';
import '../elements/elements.dart';

typedef _Resolver = ClassDecl Function(String? binaryName);

/// Adds references from child elements back to their parent elements.
class Linker extends Visitor<Classes> {
  Linker(this.config);

  final Config config;

  @override
  void visit(Classes node) {
    final classLinker = _ClassLinker(config, (binaryName) {
      return node.decls[binaryName] ?? ClassDecl.object;
    });
    for (final classDecl in node.decls.values) {
      classDecl.accept(classLinker);
    }
  }
}

class _ClassLinker extends Visitor<ClassDecl> {
  _ClassLinker(this.config, this.resolve);

  final Config config;
  final _Resolver resolve;
  final Set<ClassDecl> _linked = {};

  @override
  void visit(ClassDecl node) {
    if (_linked.contains(node)) return;
    _linked.add(node);

    node.parent = resolve(node.parentName);
    node.parent!.accept(this);
    // Adding type params of outer classes to the nested classes
    final allTypeParams = <TypeParam>[];
    if (!node.modifiers.contains('static')) {
      for (final typeParam in node.parent!.allTypeParams) {
        if (!node.allTypeParams.contains(typeParam)) {
          // Add only if it's not shadowing another type param.
          allTypeParams.add(typeParam);
        }
      }
    }
    allTypeParams.addAll(node.typeParams);
    node.allTypeParams = allTypeParams;

    final typeLinker = _TypeLinker(resolve);

    node.superclass ??= TypeUsage.object;
    node.superclass!.type.accept(typeLinker);
    final superclass = (node.superclass!.type as DeclaredType).classDecl;
    superclass.accept(this);

    final fieldLinker = _FieldLinker(typeLinker);
    for (final field in node.fields) {
      field.classDecl = node;
      field.accept(fieldLinker);
    }
    final methodLinker = _MethodLinker(config, typeLinker);
    for (final method in node.methods) {
      method.classDecl = node;
      method.accept(methodLinker);
    }
  }
}

class _MethodLinker extends Visitor<Method> {
  _MethodLinker(this.config, this.typeVisitor);

  final Config config;
  final TypeVisitor typeVisitor;

  @override
  void visit(Method node) {
    node.returnType.accept(typeVisitor);
    final typeParamLinker = _TypeParamLinker(typeVisitor);
    for (final typeParam in node.typeParams) {
      typeParam.accept(typeParamLinker);
    }
    final paramLinker = _ParamLinker(typeVisitor);
    for (final param in node.params) {
      param.accept(paramLinker);
    }
    // Kotlin specific
    const kotlinContinutationType = 'kotlin.coroutines.Continuation';
    if (config.suspendFunToAsync &&
        node.params.isNotEmpty &&
        node.params.last.type.kind == Kind.declared &&
        node.params.last.type.shorthand == kotlinContinutationType) {
      final continuationType = node.params.last.type.type as DeclaredType;
      node.asyncReturnType = continuationType.params.isEmpty
          ? TypeUsage.object
          : continuationType.params.first;
    } else {
      node.asyncReturnType = null;
    }
    node.asyncReturnType?.accept(typeVisitor);
  }
}

class _TypeLinker extends TypeVisitor {
  _TypeLinker(this.resolve);

  final _Resolver resolve;

  @override
  void visitDeclaredType(DeclaredType node) {
    node.classDecl = resolve(node.binaryName);
  }

  @override
  void visitWildcard(Wildcard node) {
    node.superBound?.type.accept(this);
    node.extendsBound?.type.accept(this);
  }

  @override
  void visitArrayType(ArrayType node) {
    node.type.accept(this);
  }

  @override
  void visitPrimitiveType(PrimitiveType node) {
    // Do nothing
  }

  @override
  void visitTypeVar(TypeVar node) {
    // Do nothing
  }
}

class _FieldLinker extends Visitor<Field> {
  _FieldLinker(this.typeVisitor);

  final TypeVisitor typeVisitor;

  @override
  void visit(Field node) {
    node.type.accept(typeVisitor);
  }
}

class _TypeParamLinker extends Visitor<TypeParam> {
  _TypeParamLinker(this.typeVisitor);

  final TypeVisitor typeVisitor;

  @override
  void visit(TypeParam node) {
    for (final bound in node.bounds) {
      bound.accept(typeVisitor);
    }
  }
}

class _ParamLinker extends Visitor<Param> {
  _ParamLinker(this.typeVisitor);

  final TypeVisitor typeVisitor;

  @override
  void visit(Param node) {
    node.type.accept(typeVisitor);
  }
}