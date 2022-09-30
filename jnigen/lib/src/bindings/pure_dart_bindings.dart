// Copyright (c) 2022, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:jnigen/src/elements/elements.dart';
import 'package:jnigen/src/config/config.dart';
import 'package:jnigen/src/logging/logging.dart';
import 'package:jnigen/src/util/name_utils.dart';

import 'symbol_resolver.dart';
import 'common.dart';

class PureDartBindingsGenerator extends BindingsGenerator {
  static final indent = BindingsGenerator.indent;

  // Name for reference in base class.
  static const selfPointer = BindingsGenerator.selfPointer;

  // import prefixes
  static const ffi = BindingsGenerator.ffi;
  static const jni = BindingsGenerator.jni;

  static const voidPointer = BindingsGenerator.voidPointer;
  static const ffiVoidType = BindingsGenerator.ffiVoidType;
  static const jniObjectType = BindingsGenerator.jniObjectType;

  static final _deleteInstruction = BindingsGenerator.deleteInstruction;

  PureDartBindingsGenerator(this.config, SymbolResolver resolver)
      : super(resolver);
  Config config;

  String generateBinding(ClassDecl decl) {
    if (!decl.isPreprocessed) {
      throw StateError(
          'Java class declaration ${decl.binaryName} must be preprocessed before'
          'being passed to bindings generator');
    }
    if (!decl.isIncluded) {
      return '';
    }
    final bindings = _class(decl);
    log.fine('generated bindings for class ${decl.binaryName}');
    return bindings;
  }

  String _class(ClassDecl decl) {
    final s = StringBuffer();

    s.write('/// from: ${decl.binaryName}\n');
    s.write(breakDocComment(decl.javadoc, depth: ''));
    final name = getSimplifiedClassName(decl.binaryName);

    var superName = jniObjectType;
    if (decl.superclass != null) {
      superName = resolver
              .resolve((decl.superclass!.type as DeclaredType).binaryName) ??
          jniObjectType;
    }

    s.write('class $name extends $superName {\n');
    s.write('static final _classRef = '
        '_accessors.getClassOf("${decl.internalName}");\n');
    s.write('$indent$name.fromRef(jni.JObject ref) : super.fromRef(ref);\n');

    for (var field in decl.fields) {
      if (!field.isIncluded) continue;
      try {
        s.write(_field(decl, field));
        s.writeln();
      } on SkipException catch (e) {
        log.fine('skip field ${decl.binaryName}#${field.name}: '
            '${e.message}');
      }
    }

    for (var method in decl.methods) {
      if (!method.isIncluded) {
        continue;
      }
      try {
        s.write(_method(decl, method));
        s.writeln();
      } on SkipException catch (e) {
        log.fine('skip field ${decl.binaryName}#${method.name}: '
            '${e.message}');
      }
    }
    s.write("}\n");
    return s.toString();
  }

  @override
  String toDartResult(String expr, TypeUsage type, String dartType) {
    if (isPrimitive(type)) {
      return expr;
    }
    return '$dartType.fromRef($expr)';
  }

  String _method(ClassDecl c, Method m) {
    final name = m.finalName;
    final isStatic = isStaticMethod(m);
    final ifStatic = isStatic ? 'Static' : '';
    final s = StringBuffer();
    final mID = '_id_$name';
    final jniSignature = getJniSignature(m);
    s.write('static final $mID = _accessors.get${ifStatic}MethodIDOf('
        '_classRef, "${m.name}", "$jniSignature");\n');
    // Different logic for constructor and method;
    // For constructor, we want return type to be new object.

    final returnType = dartOuterType(m.returnType);
    s.write('$indent/// from: ${originalMethodHeader(m)}\n');
    if (!isPrimitive(m.returnType) || isCtor(m)) {
      s.write(_deleteInstruction);
    }
    s.write(breakDocComment(m.javadoc));
    if (isCtor(m)) {
      final wrapperExpr =
          '_accessors.newObjectWithArgs(_classRef, $mID, [${actualArgs(m)}]).object';
      final className = getSimplifiedClassName(c.binaryName);
      final ctorFnName = name == 'ctor' ? className : '$className.$name';
      s.write('$ctorFnName(${formalArgs(m)}) : '
          'super.fromRef($wrapperExpr);\n');
      return s.toString();
    }

    s.write(indent);
    if (isStatic) {
      s.write('static ');
    }
    final selfArgument = isStatic ? '_classRef' : selfPointer;
    final callType = getCallType(m.returnType);
    final resultGetter = getResultGetterName(m.returnType);
    var wrapperExpr = '_accessors.call${ifStatic}MethodWithArgs'
        '($selfArgument, $mID, $callType, [${actualArgs(m)}])'
        '.$resultGetter';
    wrapperExpr = toDartResult(wrapperExpr, m.returnType, returnType);
    s.write('$returnType $name(${formalArgs(m)}) => $wrapperExpr;\n');
    return s.toString();
  }

  String _field(ClassDecl c, Field f) {
    final name = f.finalName;
    final isStatic = isStaticField(f);
    final ifStatic = isStatic ? 'Static' : '';
    final isFinal = isFinalField(f);
    final s = StringBuffer();
    final selfArgument = isStatic ? '_classRef' : selfPointer;
    final callType = getCallType(f.type);
    final resultGetter = getResultGetterName(f.type);
    final outerType = dartOuterType(f.type);

    void writeDocs({bool writeDeleteInstruction = true}) {
      s.write('$indent/// from: ${originalFieldDecl(f)}\n');
      if (!isPrimitive(f.type) && writeDeleteInstruction) {
        s.write(_deleteInstruction);
      }
      s.write(breakDocComment(f.javadoc));
    }

    if (isStatic && isFinal && f.defaultValue != null) {
      writeDocs(writeDeleteInstruction: false);
      s.write('${indent}static const $name = ${literal(f.defaultValue)};\n');
      return s.toString();
    }
    final jniSignature = getJniSignatureForField(f);
    final fID = '_id_$name';
    s.write('static final $fID = '
        '_accessors.get${ifStatic}FieldIDOf(_classRef, '
        '"${f.name}","$jniSignature");\n');
    void writeAccessor({bool setter = false}) {
      writeDocs();
      s.write(indent);
      if (isStatic) s.write('static ');
      if (setter) {
        final fieldType = getTypeNameAtCallSite(f.type);
        s.write('set $name($outerType value) => _env.Set$ifStatic'
            '${fieldType}Field($selfArgument, $fID, '
            '${toNativeArg("value", f.type)});\n');
      } else {
        final outer = dartOuterType(f.type);
        final callExpr = '_accessors.getField($selfArgument, $fID, $callType)'
            '.$resultGetter';
        final resultExpr = toDartResult(callExpr, f.type, outer);
        s.write('$outer get $name => $resultExpr;\n');
      }
    }

    writeAccessor(setter: false);
    if (!isFinalField(f)) writeAccessor(setter: true);
    return s.toString();
  }

  static const autoGeneratedNotice = '// Autogenerated by jnigen. '
      'DO NOT EDIT!\n\n';
  static const defaultLintSuppressions =
      '// ignore_for_file: camel_case_types\n'
      '// ignore_for_file: non_constant_identifier_names\n'
      '// ignore_for_file: constant_identifier_names\n'
      '// ignore_for_file: annotate_overrides\n'
      '// ignore_for_file: no_leading_underscores_for_local_identifiers\n'
      '// ignore_for_file: unused_element\n'
      '// ignore_for_file: unused_field\n'
      '\n';

  static const defaultImports = 'import "package:jni/jni.dart" as jni;\n'
      'import "package:jni/internal_helpers_for_jnigen.dart" as jnix;\n\n';

  static const initialization = 'final _env = jni.Jni.env;\n'
      'final _accessors = jni.Jni.accessors;\n\n';

  static const bindingFileBoilerplate = autoGeneratedNotice +
      defaultLintSuppressions +
      defaultImports +
      initialization;
}
