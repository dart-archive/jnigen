// Copyright (c) 2023, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../config/config.dart';
import '../elements/elements.dart';

import 'visitor.dart';

const Set<String> _keywords = {
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
const Map<String, int> _definedSyms = {
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

/// Appends 0 to [name] if [name] is a keyword.
///
/// Examples:
/// * `int` -> `int0`
/// * `i` -> `i`
String _keywordRename(String name) =>
    _keywords.contains(name) ? '${name}0' : name;

String _renameConflict(Map<String, int> counts, String name) {
  if (counts.containsKey(name)) {
    final count = counts[name]!;
    final renamed = '$name$count';
    counts[name] = count + 1;
    return renamed;
  }
  counts[name] = 1;
  return _keywordRename(name);
}

class Renamer implements Visitor<Classes, void> {
  Renamer(this.config);
  final Config config;

  @override
  void visit(Classes node) {
    final classRenamer = _ClassRenamer(config);

    for (final classDecl in node.decls.values) {
      classDecl.accept(classRenamer);
    }
  }
}

class _ClassRenamer implements Visitor<ClassDecl, void> {
  _ClassRenamer(
    this.config,
  );

  final Config config;
  final Map<String, int> classNameCounts = {};
  final Set<ClassDecl> renamed = {...ClassDecl.predefined.values};
  final Map<ClassDecl, Map<String, int>> nameCounts = {
    for (final predefined in ClassDecl.predefined.values) ...{
      predefined: {..._definedSyms},
    }
  };
  final Map<ClassDecl, Map<String, int>> methodNumsAfterRenaming = {};

  /// Returns class name as useful in dart.
  ///
  /// Eg -> a.b.X.Y -> X_Y
  static String _getSimplifiedClassName(String binaryName) =>
      binaryName.split('.').last.replaceAll('\$', '_');

  @override
  void visit(ClassDecl node) {
    if (renamed.contains(node)) return;
    renamed.add(node);

    nameCounts[node] = {..._definedSyms};
    methodNumsAfterRenaming[node] = {};

    final className = _getSimplifiedClassName(node.binaryName);
    node.uniqueName = _renameConflict(classNameCounts, className);

    // When generating all the classes in a single file
    // the names need to be unique.
    final uniquifyName =
        config.outputConfig.dartConfig.structure == OutputStructure.singleFile;
    node.finalName = uniquifyName ? node.uniqueName : className;
    // TODO
    node.importPrefix = '';

    final superClass = (node.superclass!.type as DeclaredType).classDecl;
    superClass.accept(this);
    nameCounts[node]!.addAll(nameCounts[superClass]!);
    final methodRenamer = _MethodRenamer(
      config,
      nameCounts[node]!,
      methodNumsAfterRenaming,
    );
    for (final method in node.methods) {
      method.accept(methodRenamer);
    }

    final fieldRenamer = _FieldRenamer(config, nameCounts[node]!);
    for (final field in node.fields) {
      field.accept(fieldRenamer);
    }
  }
}

class _MethodRenamer implements Visitor<Method, void> {
  _MethodRenamer(this.config, this.nameCounts, this.methodNumsAfterRenaming);

  final Config config;
  final Map<String, int> nameCounts;
  final Map<ClassDecl, Map<String, int>> methodNumsAfterRenaming;

  @override
  void visit(Method node) {
    final name = node.name == '<init>' ? 'ctor' : node.name;
    final sig = node.javaSig;
    // If node is in super class, assign its number, overriding it.
    final superClass =
        (node.classDecl.superclass!.type as DeclaredType).classDecl;
    final superNum = methodNumsAfterRenaming[superClass]?[sig];
    if (superNum != null) {
      // Don't rename if superNum == 0
      // Unless the node name is a keyword.
      final superNumText = superNum == 0 ? '' : '$superNum';
      final methodName = superNum == 0 ? _keywordRename(name) : name;
      node.finalName = '$methodName$superNumText';
      methodNumsAfterRenaming[node.classDecl]?[sig] = superNum;
    } else {
      node.finalName = _renameConflict(nameCounts, name);
      methodNumsAfterRenaming[node.classDecl]?[sig] = nameCounts[name]! - 1;
    }

    final paramRenamer = _ParamRenamer(config);
    for (final param in node.params) {
      param.accept(paramRenamer);
    }
  }
}

class _FieldRenamer implements Visitor<Field, void> {
  _FieldRenamer(this.config, this.nameCounts);

  final Config config;
  final Map<String, int> nameCounts;

  @override
  void visit(Field node) {
    node.finalName = _renameConflict(
      nameCounts,
      node.name,
    );
  }
}

class _ParamRenamer implements Visitor<Param, void> {
  _ParamRenamer(this.config);

  final Config config;

  @override
  void visit(Param node) {
    node.finalName = _keywordRename(node.name);
  }
}
