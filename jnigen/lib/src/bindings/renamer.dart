// Copyright (c) 2023, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../config/config.dart';
import '../elements/elements.dart';

import 'element_visitor.dart';

class Renamer extends ElementVisitor<void> {
  Renamer(this.config);

  final Config config;

  final _renamed = <ClassDecl>{};
  final _classNameCounts = <String, int>{};
  final _nameCounts = <ClassDecl, Map<String, int>>{};

  /// Contains number with which certain overload of a method is renamed to,
  /// so the overriding method in subclass can be renamed to same final name.
  final _methodNumsAfterRenaming = <ClassDecl, Map<String, int>>{};

  /// Returns class name as useful in dart.
  ///
  /// Eg -> a.b.X.Y -> X_Y
  static String _getSimplifiedClassName(String binaryName) =>
      binaryName.split('.').last.replaceAll('\$', '_');

  static String _renameConflict(Map<String, int> counts, String name) {
    if (counts.containsKey(name)) {
      final count = counts[name]!;
      final renamed = '$name$count';
      counts[name] = count + 1;
      return renamed;
    }
    counts[name] = 1;
    return _keywordRename(name);
  }

  /// Appends 0 to [name] if [name] is a keyword.
  ///
  /// Examples:
  /// * `int` -> `int0`
  /// * `i` -> `i`
  static String _keywordRename(String name) =>
      _keywords.contains(name) ? '${name}0' : name;

  static bool _isCtor(Method m) => m.name == '<init>';

  static const Set<String> _keywords = {
    'abstract',
    'as',
    'assert',
    'async',
    'await',
    'break',
    'case',
    'catch',
    'class',
    'const',
    'continue',
    'covariant',
    'default',
    'deferred',
    'do',
    'dynamic',
    'else',
    'enum',
    'export',
    'extends',
    'extension',
    'external',
    'factory',
    'false',
    'final',
    'finally',
    'for',
    'Function',
    'get',
    'hide',
    'if',
    'implements',
    'import',
    'in',
    'interface',
    'is',
    'late',
    'library',
    'mixin',
    'new',
    'null',
    'on',
    'operator',
    'part',
    'required',
    'rethrow',
    'return',
    'set',
    'show',
    'static',
    'super',
    'switch',
    'sync',
    'this',
    'throw',
    'true',
    'try',
    'typedef',
    'var',
    'void',
    'while',
    'with',
    'yield',
  };

  /// Methods & properties already defined by dart JObject base class.
  static const Map<String, int> _definedSyms = {
    'equals': 1,
    'toString': 1,
    'hashCode': 1,
    'runtimeType': 1,
    'noSuchMethod': 1,
    'reference': 1,
    'isDeleted': 1,
    'isNull': 1,
    'use': 1,
    'delete': 1,
    'getFieldID': 1,
    'getStaticFieldID': 1,
    'getMethodID': 1,
    'getStaticMethodID': 1,
    'getField': 1,
    'getFieldByName': 1,
    'getStaticField': 1,
    'getStaticFieldByName': 1,
    'callMethod': 1,
    'callMethodByName': 1,
    'callStaticMethod': 1,
    'callStaticMethodByName': 1,
  };

  @override
  void visitAnnotation(Annotation annotation) {
    throw UnsupportedError('Does not need renaming.');
  }

  @override
  void visitArrayType(ArrayType type) {
    throw UnsupportedError('Does not need renaming.');
  }

  @override
  void visitClasses(Classes classes) {
    for (final classDecl in classes.decls.values) {
      classDecl.accept(this);
    }
  }

  @override
  void visitClassDecl(ClassDecl classDecl) {
    if (_renamed.contains(classDecl)) return;
    _renamed.add(classDecl);

    _nameCounts[classDecl] = {..._definedSyms};
    _methodNumsAfterRenaming[classDecl] = {};

    final className = _getSimplifiedClassName(classDecl.binaryName);
    classDecl.uniqueName = _renameConflict(_classNameCounts, className);

    // When generating all the classes in a single file
    // the names need to be unique.
    final uniquifyName =
        config.outputConfig.dartConfig.structure == OutputStructure.singleFile;
    classDecl.finalName = uniquifyName ? classDecl.uniqueName : className;

    final superClass = (classDecl.superclass!.type as DeclaredType).classDecl;
    superClass.accept(this);
    _nameCounts[classDecl]!.addAll(_nameCounts[superClass]!);

    for (final method in classDecl.methods) {
      method.accept(this);
    }

    for (final field in classDecl.fields) {
      field.accept(this);
    }
  }

  @override
  void visitDeclaredType(DeclaredType type) {
    throw UnsupportedError('Does not need renaming.');
  }

  @override
  void visitField(Field field) {
    field.finalName = _renameConflict(
      _nameCounts[field.classDecl]!,
      field.name,
    );
  }

  @override
  void visitJavaDocComment(JavaDocComment comment) {
    throw UnsupportedError('Does not need renaming.');
  }

  @override
  void visitMethod(Method method) {
    final name = _isCtor(method) ? 'ctor' : method.name;
    final sig = method.javaSig;
    // If method is in super class, assign its number, overriding it.
    final superClass =
        (method.classDecl.superclass!.type as DeclaredType).classDecl;
    final superNum = _methodNumsAfterRenaming[superClass]?[sig];
    if (superNum != null) {
      // Don't rename if superNum == 0
      // Unless the method name is a keyword.
      final superNumText = superNum == 0 ? '' : '$superNum';
      final methodName = superNum == 0 ? _keywordRename(name) : name;
      method.finalName = '$methodName$superNumText';
      _methodNumsAfterRenaming[method.classDecl]?[sig] = superNum;
    } else {
      method.finalName = _renameConflict(_nameCounts[method.classDecl]!, name);
      _methodNumsAfterRenaming[method.classDecl]?[sig] =
          _nameCounts[method.classDecl]![name]! - 1;
    }
    for (final param in method.params) {
      param.accept(this);
    }
  }

  @override
  void visitParam(Param param) {
    param.finalName = _keywordRename(param.name);
  }

  @override
  void visitPrimitiveType(PrimitiveType type) {
    throw UnsupportedError('Does not need renaming.');
  }

  @override
  void visitTypeParam(TypeParam typeParam) {
    throw UnsupportedError('Does not need renaming.');
  }

  @override
  void visitTypeUsage(TypeUsage typeUsage) {
    throw UnsupportedError('Does not need renaming.');
  }

  @override
  void visitTypeVar(TypeVar type) {
    throw UnsupportedError('Does not need renaming.');
  }

  @override
  void visitWildcard(Wildcard wildcard) {
    throw UnsupportedError('Does not need renaming.');
  }
}
