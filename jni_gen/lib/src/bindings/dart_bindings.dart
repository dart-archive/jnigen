import 'dart:io';

import 'package:jni_gen/src/elements/elements.dart';
import 'package:jni_gen/src/config/wrapper_options.dart';
import 'package:jni_gen/src/util/rename_conflict.dart';

import 'symbol_resolver.dart';
import 'common.dart';

final _indent = ' ' * 2;

class DartBindingsGenerator {
  // Name for reference in base class
  static const _self = 'reference';
  // symbol lookup function for generated code
  static const _jlookup = 'jlookup';

  // import prefixes
  static const ffi = 'ffi.';
  static const jni = 'jni.';

  // methods / properties already defined by dart JlObject base class
  static const Map<String, int> _definedSyms = {
    'equals': 1,
    'toString': 1,
    'hashCode': 1,
    'runtimeType': 1,
    'noSuchMethod': 1,
    'reference': 1,
    'delete': 1,
  };

  // ffi.Pointer<ffi.Void>
  late final String _voidPtr = '${ffi}Pointer<${ffi}Void>';

  late final String _void = '${ffi}Void';

  late final String _jlObject = '${jni}JlObject';

  DartBindingsGenerator(this.options, this.resolver);
  WrapperOptions options;
  SymbolResolver resolver;

  String generateBinding(ClassDecl decl) {
    if (options.classFilter?.included(decl) == false) {
      // print skipped
      return '';
    }
    try {
      return _class(decl);
    } on SkipException catch (s) {
      stderr.writeln('skip class ${decl.binaryName}');
      stderr.writeln(s);
      return '';
    }
  }

  String _class(ClassDecl decl) {
    final s = StringBuffer();

    // class <SimpleName> [extends super] { .. }
    s.write('/// from: ${decl.binaryName}\n');
    s.write(_breakDocComment(decl.javadoc, depth: ''));
    final name = _getSimpleName(decl.binaryName);

    var superName = _jlObject;
    if (decl.superclass != null) {
      superName = resolver
              .resolve((decl.superclass!.type as DeclaredType).binaryName) ??
          _jlObject;
    }

    final Map<String, int> nameCounts = {};
    nameCounts.addAll(_definedSyms);

    s.write('class $name extends $superName {\n');
    // fromRef constructor
    s.write('$_indent$name.fromRef($_voidPtr ref) : '
        'super.fromRef(ref);\n');

    s.writeln();

    void printSkipped(SkipException e, String member) {
      stderr.writeln('skip ${decl.binaryName}#$member ($e)');
    }

    for (var field in decl.fields) {
      if (options.fieldFilter?.included(decl, field) == false) {
        stderr.writeln('exclude: ${field.name}');
        continue;
      }
      try {
        s.write(_field(decl, field, nameCounts));
        s.writeln();
      } on SkipException catch (e) {
        printSkipped(e, field.name);
      }
    }

    for (var method in decl.methods) {
      if (options.methodFilter?.included(decl, method) == false) {
        continue;
      }
      try {
        s.write(_method(decl, method, nameCounts));
        s.writeln();
      } on SkipException catch (e) {
        printSkipped(e, method.name);
      }
    }
    s.write("}\n");
    return s.toString();
  }

  static final _deleteInstruction =
      '$_indent/// The returned object must be deleted after use, '
      'by calling the `delete` method.\n';

  String _method(ClassDecl c, Method m, Map<String, int> nameCounts) {
    final validCName = isCtor(m) ? 'new' : m.name;
    final validDartName = isCtor(m) ? 'ctor' : resolver.kwPkgRename(m.name);
    final name = renameConflict(nameCounts, validDartName);
    final cName = memberNameInC(
        c, isCtor(m) ? renameConflict(nameCounts, validCName) : name);
    final s = StringBuffer();
    final sym = '_$name';
    final ffiSig = dartSigForMethod(m, isFfiSig: true);
    final dartSig = dartSigForMethod(m, isFfiSig: false);
    s.write('${_indent}static final $sym = $_jlookup'
        '<${ffi}NativeFunction<$ffiSig>>("$cName")\n'
        '.asFunction<$dartSig>();\n');
    // diferent logic for constructor and method
    final returnType = dartOuterType(m.returnType);
    s.write('$_indent/// from: ${_originalMethodHeader(m)}\n');
    if (!isPrimitive(m.returnType)) {
      s.write(_deleteInstruction);
    }
    s.write(_breakDocComment(m.javadoc));
    s.write(_indent);

    if (isStaticMethod(m)) {
      s.write('static ');
    }

    if (isCtor(m)) {
      final wrapperExpr = '$sym(${_actualArgs(m)})';
      final className = _getSimpleName(c.binaryName);
      final ctorFnName = name == 'ctor' ? className : '$className.$name';
      s.write('$ctorFnName(${_formalArgs(m)}) : '
          'super.fromRef($wrapperExpr);\n');
      return s.toString();
    }

    var wrapperExpr = '$sym(${_actualArgs(m)})';
    wrapperExpr = _toDartResult(wrapperExpr, m.returnType, returnType);
    s.write('$returnType $name(${_formalArgs(m)}) '
        '=> $wrapperExpr;\n');

    return s.toString();
  }

  String _formalArgs(Method m) {
    final List<String> args = [];
    for (var param in m.params) {
      args.add(
          '${dartOuterType(param.type)} ${resolver.kwPkgRename(param.name, outer: {
            m.name
          })}');
    }
    return args.join(', ');
  }

  String _actualArgs(Method m) {
    final List<String> args = [if (hasSelfParam(m)) _self];
    for (var param in m.params) {
      final paramName = resolver.kwPkgRename(param.name, outer: {m.name});
      args.add(_toCArg(paramName, param.type));
    }
    return args.join(', ');
  }

  String _field(ClassDecl c, Field f, Map<String, int> nameCounts) {
    final name = renameConflict(nameCounts, f.name);
    final s = StringBuffer();

    void _writeDocs({bool writeDeleteInstruction = true}) {
      s.write('$_indent/// from: ${_originalFieldDecl(f)}\n');
      if (!isPrimitive(f.type) && writeDeleteInstruction) {
        s.write(_deleteInstruction);
      }
      s.write(_breakDocComment(f.javadoc));
    }

    if (isStaticField(f) && isFinalField(f) && f.defaultValue != null) {
      _writeDocs(writeDeleteInstruction: false);
      s.write('${_indent}static const $name = ${_literal(f.defaultValue)};\n');
      return s.toString();
    }
    final cName = memberNameInC(c, name);

    void writeAccessor({bool isSetter = false}) {
      final symPrefix = isSetter ? 'set' : 'get';
      final sym = '_$symPrefix$name';
      final ffiSig = dartSigForField(f, isSetter: isSetter, isFfiSig: true);
      final dartSig = dartSigForField(f, isSetter: isSetter, isFfiSig: false);
      s.write('${_indent}static final $sym = $_jlookup'
          '<${ffi}NativeFunction<$ffiSig>>("${symPrefix}_$cName")\n'
          '.asFunction<$dartSig>();\n');
      // write original type
      _writeDocs();
      s.write(_indent);
      if (isStaticField(f)) s.write('static ');
      if (isSetter) {
        s.write('set $name(${dartOuterType(f.type)} value) => $sym(');
        if (!isStaticField(f)) {
          s.write('$_self, ');
        }
        s.write(_toCArg('value', f.type));
        s.write(');\n');
      } else {
        // getter
        final self = isStaticField(f) ? '' : _self;
        final outer = dartOuterType(f.type);
        final callExpr = '$sym($self)';
        final resultExpr = _toDartResult(callExpr, f.type, outer);
        s.write('$outer get $name => $resultExpr;\n');
      }
    }

    writeAccessor(isSetter: false);
    if (!isFinalField(f)) writeAccessor(isSetter: true);
    return s.toString();
  }

  String _getSimpleName(String binaryName) {
    final components = binaryName.split(".");
    return components.last.replaceAll("\$", "_");
  }

  String dartSigForField(Field f,
      {bool isSetter = false, required bool isFfiSig}) {
    final conv = isFfiSig ? dartFfiType : dartInnerType;
    final voidType = isFfiSig ? _void : 'void';
    final ref = f.modifiers.contains('static') ? '' : '$_voidPtr, ';
    if (isSetter) {
      return '$voidType Function($ref${conv(f.type)})';
    }
    return '${conv(f.type)} Function($ref)';
  }

  String dartSigForMethod(Method m, {required bool isFfiSig}) {
    final conv = isFfiSig ? dartFfiType : dartInnerType;
    final argTypes = [if (hasSelfParam(m)) _voidPtr];
    for (var param in m.params) {
      argTypes.add(conv(param.type));
    }
    final retType = isCtor(m) ? _voidPtr : conv(m.returnType);
    return '$retType Function (${argTypes.join(", ")})';
  }

  // Type for FFI Function signature
  String dartFfiType(TypeUsage t) {
    const primitives = {
      'byte': 'Int8',
      'short': 'Int16',
      'char': 'Int16',
      'int': 'Int32',
      'long': 'Int64',
      'float': 'Float',
      'double': 'Double',
      'void': 'Void',
      'boolean': 'Uint8',
    };
    switch (t.kind) {
      case Kind.primitive:
        return ffi + primitives[(t.type as PrimitiveType).name]!;
      case Kind.typeVariable:
      case Kind.wildcard:
        throw SkipException(
            'Generic type parameters are not supported', t.toJson());
      case Kind.array:
      case Kind.declared:
        return _voidPtr;
    }
  }

  String _dartType(TypeUsage t, {SymbolResolver? resolver}) {
    // if resolver == null, looking for inner fn type, type of fn reference
    // else looking for outer fn type, that's what user of the library sees.
    const primitives = {
      'byte': 'int',
      'short': 'int',
      'char': 'int',
      'int': 'int',
      'long': 'int',
      'float': 'double',
      'double': 'double',
      'void': 'void',
      'boolean': 'bool',
    };
    switch (t.kind) {
      case Kind.primitive:
        if (t.name == 'boolean' && resolver == null) return 'int';
        return primitives[(t.type as PrimitiveType).name]!;
      case Kind.typeVariable:
      case Kind.wildcard:
        throw SkipException('Not supported: generics');
      case Kind.array:
        if (resolver != null) {
          return _jlObject;
        }
        return _voidPtr;
      case Kind.declared:
        if (resolver != null) {
          return resolver.resolve((t.type as DeclaredType).binaryName) ??
              _jlObject;
        }
        return _voidPtr;
    }
  }

  String dartInnerType(TypeUsage t) => _dartType(t);
  String dartOuterType(TypeUsage t) => _dartType(t, resolver: resolver);

  String _literal(dynamic value) {
    if (value is String) {
      return '"$value"';
    }
    if (value is int || value is double || value is bool) {
      return value.toString();
    }
    throw SkipException('Not a constant of a known type.');
  }

  String _originalFieldDecl(Field f) {
    final declStmt = '${f.type.shorthand} ${f.name}';
    return [...f.modifiers, declStmt].join(' ');
  }

  String _originalMethodHeader(Method m) {
    final args = <String>[];
    for (var p in m.params) {
      args.add('${p.type.shorthand} ${p.name}');
    }
    final declStmt = '${m.returnType.shorthand} ${m.name}'
        '(${args.join(', ')})';
    return [...m.modifiers, declStmt].join(' ');
  }

  String _toCArg(String name, TypeUsage type) {
    if (isPrimitive(type)) {
      return type.name == 'boolean' ? '$name ? 1 : 0' : name;
    }
    return '$name.$_self';
  }

  String _toDartResult(String expr, TypeUsage type, String dartType) {
    if (isPrimitive(type)) {
      return type.name == 'boolean' ? '$expr != 0' : expr;
    }
    return '$dartType.fromRef($expr)';
  }

  static String _breakDocComment(JavaDocComment? javadoc,
      {String depth = '    '}) {
    final link = RegExp('{@link ([^{}]+)}');
    if (javadoc == null) return '';
    final comment = javadoc.comment
        .replaceAllMapped(link, (match) => match.group(1) ?? '')
        .replaceAll('#', '\\#')
        .replaceAll('<p>', '')
        .replaceAll('</p>', '\n')
        .replaceAll('<b>', '__')
        .replaceAll('</b>', '__')
        .replaceAll('<em>', '_')
        .replaceAll('</em>', '_');
    return '$depth///\n'
        '$depth/// ${comment.replaceAll('\n', '\n$depth///')}\n';
  }
}

class DartPreludes {
  static String initFile(String libraryName) => 'import "dart:ffi";\n'
      'import "package:jni/jni.dart";\n'
      '\n'
      'final Pointer<T> Function<T extends NativeType>(String sym) '
      'jlookup = Jni.getInstance().initGeneratedLibrary("$libraryName");\n'
      '\n';
  static const autoGeneratedNotice = '// Autogenerated by jni_gen. '
      'DO NOT EDIT!\n\n';
  static const defaultImports = 'import "dart:ffi" as ffi;\n\n'
      'import "package:jni/jni.dart" as jni;\n\n';
  static const defaultLintSuppressions =
      '// ignore_for_file: camel_case_types\n'
      '// ignore_for_file: non_constant_identifier_names\n'
      '// ignore_for_file: constant_identifier_names\n'
      '// ignore_for_file: annotate_overrides\n'
      '// ignore_for_file: no_leading_underscores_for_local_identifiers\n'
      '// ignore_for_file: unused_element\n'
      '\n';
  static const bindingFileHeaders =
      autoGeneratedNotice + defaultLintSuppressions + defaultImports;
}
