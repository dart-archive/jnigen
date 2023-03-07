// Copyright (c) 2023, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../config/config.dart';
import '../elements/elements.dart';
import 'visitor.dart';

const _jni = 'jni';

const _jType = '$_jni.JObjType';
const _jPointer = '$_jni.JObjectPtr';
const _jArray = '$_jni.JArray';
const _jObject = '$_jni.JObject';

const _typeParamPrefix = '\$';

const _typeClassPrefix = '\$';
const _typeClassSuffix = 'Type';

const _deleteInstruction =
    '  /// The returned object must be deleted after use, '
    'by calling the `delete` method.';

// **Naming Convention**
//
// Let's take the following code as an example:
//
// ```dart
// Method definition
// void f<T extends num, U>(JType<T> $T, JType<U> $U, T t, U u) {
//   // ...
// }
// f<int, String>($T, $U, t, u); // Calling the Method
// ```
//
// Here `f` will be replaced according to the place of usage.
//
// * `fArgsDef` refers to `T t, U u` – the arguments in the method
//   definition.
// * `fArgsCall` refer to `t, u` – the arguments passed to call the method.
// * `fTypeParamsDef` refers to `<T extends num, U>` – the type parameters
//   of the method at the point of definition.
// * `fTypeParamsCall` refers to `<int, String>` – the type parameters when
//   calling, or whenever we don't want to have the `extends` keyword.
// * `fTypeClassesDef` refers to `JType<T> $T, JType<U> $U`.
// * `fTypeClassesCall` refers to `$T, $U` when calling the method.

/// Encloses [inside] in the middle of [open] and [close]
/// if [inside] is not empty.
String _encloseIfNotEmpty(String open, String inside, String close) {
  if (inside == '') return '';
  return '$open$inside$close';
}

String _newLine({int depth = 0}) {
  return '\n${'  ' * depth}';
}

class DartGenerator extends Visitor<Classes, void> {
  @override
  void visit(Classes node) {}
}

class _ClassGenerator extends Visitor<ClassDecl, void> {
  _ClassGenerator(this.config, this.s);

  final Config config;
  final StringBuffer s;

  static const staticTypeGetter = 'type';
  static const instanceTypeGetter = '\$$staticTypeGetter';

  static const arrayExtensionPrefix = '\$';
  static const arrayExtensionSuffix = 'Array';

  @override
  void visit(ClassDecl node) {
    // Docs
    s.write('/// from: ${node.binaryName}\n');
    node.javadoc?.accept(_DocGenerator(s, depth: 0));

    // Class definition
    final name = node.finalName;
    final superName = node.superclass!.accept(const _TypeGenerator());
    final typeParamsDef = _encloseIfNotEmpty(
      '<',
      node.allTypeParams
          .accept(const _TypeParamGenerator(withExtends: true))
          .join(', '),
      '>',
    );
    final typeParams = node.allTypeParams
        .accept(const _TypeParamGenerator(withExtends: false));
    final typeParamsCall = _encloseIfNotEmpty('<', typeParams.join(', '), '>');
    final staticTypeGetterCallArgs = _encloseIfNotEmpty(
      '(',
      typeParams.map((typeParams) => '$_typeParamPrefix$typeParams').join(', '),
      ')',
    );
    final typeClassDefinitions = typeParams
        .map((typeParam) =>
            'final $_jType<$typeParam> $_typeParamPrefix$typeParam;')
        .join(_newLine(depth: 1));
    final ctorTypeClassesDef = typeParams
        .map((typeParam) => 'this.$_typeParamPrefix$typeParam,')
        .join(_newLine(depth: 2));
    final superTypeClassesCall = (node.superclass!.type as DeclaredType)
        .params
        .accept(const _TypeClassGenerator())
        .map((typeClass) => '$typeClass,')
        .join(_newLine(depth: 2));
    s.write('''
class $name$typeParamsDef extends $superName {
  late final $_jType? _$instanceTypeGetter;

  @override
  $_jType get $instanceTypeGetter => _$instanceTypeGetter ??= $staticTypeGetter$staticTypeGetterCallArgs;

  $typeClassDefinitions

  $name.fromRef(
    $ctorTypeClassesDef
    $_jPointer ref,
  ): super.fromRef(
    $superTypeClassesCall
    ref,
  );

''');

    // Static TypeClass getter
    s.write(
        '  /// The type which includes information such as the signature of this class.');
    final typeClassName = '$_typeClassPrefix$name$_typeClassSuffix';
    if (typeParams.isEmpty) {
      s.write('static const $staticTypeGetter = $typeClassName();\n');
    } else {
      final staticTypeGetterTypeClassesDef = typeParams
          .map(
              (typeParam) => '$_jType<$typeParam> $_typeParamPrefix$typeParam,')
          .join(_newLine(depth: 2));
      final typeClassesCall = typeParams
          .map((typeParam) => '$_typeParamPrefix$typeParam,')
          .join(_newLine(depth: 3));
      s.write('''
  static $typeClassName$typeParamsCall $staticTypeGetter$typeParamsDef(
    $staticTypeGetterTypeClassesDef
  ) {
    return $typeClassName(
      $typeClassesCall
    );
  }

''');
    }

    // Fields and Methods
    final fieldGenerator = _FieldGenerator(config, s);
    for (final field in node.fields) {
      field.accept(fieldGenerator);
    }
    final methodGenerator = _MethodGenerator(s);
    for (final method in node.methods) {
      method.accept(methodGenerator);
    }

    // End of Class definition
    s.write('}');

    // TypeClass definition
    final typeClassesCall = typeParams
        .map((typeParam) => '$_typeParamPrefix$typeParam,')
        .join(_newLine(depth: 2));
    final signature = node.signature;
    s.write('''
class $typeClassName$typeParamsDef extends $_jType<$name$typeParamsCall> {
  $typeClassDefinitions

  const $typeClassName(
    $ctorTypeClassesDef
  );

  @override
  String get signature => r"$signature";

  @override
  $name$typeParams fromRef($_jPointer ref) => $name.fromRef(
    $typeClassesCall
    ref
  );
}

''');

    // Array extension
    s.write('''
extension $arrayExtensionPrefix$name$arrayExtensionSuffix on $_jArray<$name$typeParamsCall> {
  $name$typeParamsCall operator [](int index) {
    return (elementType as $typeClassName$typeParamsCall);
  }

  void operator []=(int index, $name$typeParamsCall value) {
    (this as $_jArray<$_jObject>)[index] = value;
  }
}
''');
  }
}

class _DocGenerator extends Visitor<JavaDocComment, void> {
  final StringBuffer s;
  final int depth;

  _DocGenerator(this.s, {required this.depth});

  @override
  void visit(JavaDocComment node) {
    final link = RegExp('{@link ([^{}]+)}');
    final indent = '  ' * depth;
    final comments = node.comment
        .replaceAllMapped(link, (match) => match.group(1) ?? '')
        .replaceAll('#', '\\#')
        .replaceAll('<p>', '')
        .replaceAll('</p>', '\n')
        .replaceAll('<b>', '__')
        .replaceAll('</b>', '__')
        .replaceAll('<em>', '_')
        .replaceAll('</em>', '_')
        .split('\n')
        .join('\n$indent/// ');
    s.write('''
$indent///
$indent/// $comments
''');
  }
}

class _TypeGenerator extends TypeVisitor<String> {
  const _TypeGenerator();

  @override
  String visitArrayType(ArrayType node) {
    final innerType = node.type;
    if (innerType.kind == Kind.primitive) {
      return '$_jArray<${(innerType.type as PrimitiveType).jniType}>';
    }
    return '$_jArray<${innerType.accept(this)}>';
  }

  @override
  String visitDeclaredType(DeclaredType node) {
    // All type parameters of this type
    final allTypeParams = node.classDecl.allTypeParams
        .accept(const _TypeParamGenerator(withExtends: false))
        .toList();
    // The ones that are declared.
    final definedTypeParams = node.params.accept(this).toList();

    // Replacing the declared ones. They come at the end.
    // The rest will be JObject.
    if (allTypeParams.length >= node.params.length) {
      allTypeParams.replaceRange(
        0,
        allTypeParams.length - node.params.length,
        List.filled(
          allTypeParams.length - node.params.length,
          _jObject,
        ),
      );
      allTypeParams.replaceRange(
        allTypeParams.length - node.params.length,
        allTypeParams.length,
        definedTypeParams,
      );
    }

    final typeParams = _encloseIfNotEmpty('<', allTypeParams.join(', '), '>');
    return '${node.classDecl.finalName}$typeParams';
  }

  @override
  String visitPrimitiveType(PrimitiveType node) {
    return node.dartType;
  }

  @override
  String visitTypeVar(TypeVar node) {
    return node.name;
  }

  @override
  String visitWildcard(Wildcard node) {
    // TODO(#141): Support wildcards
    return _jObject;
  }
}

class _TypeClass {
  final String name;
  final bool canBeConst;

  _TypeClass(this.name, this.canBeConst);
}

class _TypeClassGenerator extends TypeVisitor<_TypeClass> {
  final bool isConst;

  const _TypeClassGenerator({this.isConst = true});

  @override
  _TypeClass visitArrayType(ArrayType node) {
    final innerTypeClass =
        node.type.accept(const _TypeClassGenerator(isConst: false));
    final ifConst = innerTypeClass.canBeConst && isConst ? 'const ' : '';
    return _TypeClass(
      '$ifConst$_jArray$_typeClassSuffix<${innerTypeClass.name}>',
      innerTypeClass.canBeConst,
    );
  }

  @override
  _TypeClass visitDeclaredType(DeclaredType node) {
    final allTypeParams = node.classDecl.allTypeParams
        .accept(const _TypeParamGenerator(withExtends: false))
        .map((typeParam) => '$_typeParamPrefix$typeParam')
        .toList();

    // The ones that are declared.
    final definedTypeClasses =
        node.params.accept(const _TypeClassGenerator(isConst: false));

    // Can be const if all the type parameters are defined and each of them are
    // also const.
    final canBeConst = allTypeParams.length == definedTypeClasses.length &&
        definedTypeClasses.every((e) => e.canBeConst);

    // Adding const to `JObjectType`s if the entire expression is not const.
    final constJObject = canBeConst ? '' : 'const ';

    // Replacing the declared ones. They come at the end.
    // The rest will be `JObjectType`.
    if (allTypeParams.length >= node.params.length) {
      allTypeParams.replaceRange(
        0,
        allTypeParams.length - node.params.length,
        List.filled(
          allTypeParams.length - node.params.length,
          '$constJObject$_jObject$_typeClassSuffix()',
        ),
      );
      allTypeParams.replaceRange(
        allTypeParams.length - node.params.length,
        allTypeParams.length,
        definedTypeClasses.map((param) => param.name),
      );
    }

    final args = allTypeParams.join(', ');
    final ifConst = isConst && canBeConst ? 'const ' : '';
    return _TypeClass(
      '$ifConst$_typeClassPrefix${node.classDecl.finalName}$_typeClassSuffix($args)',
      canBeConst,
    );
  }

  @override
  _TypeClass visitPrimitiveType(PrimitiveType node) {
    final ifConst = isConst ? 'const ' : '';
    return _TypeClass('$ifConst${node.jniType}$_typeClassSuffix', true);
  }

  @override
  _TypeClass visitTypeVar(TypeVar node) {
    return _TypeClass('$_typeParamPrefix${node.name}', false);
  }

  @override
  _TypeClass visitWildcard(Wildcard node) {
    // TODO(#141): Support wildcards
    return _TypeClass('$_jObject$_typeClassSuffix', true);
  }
}

class _TypeParamGenerator extends Visitor<TypeParam, String> {
  final bool withExtends;

  const _TypeParamGenerator({required this.withExtends});

  @override
  String visit(TypeParam node) {
    if (!withExtends) {
      return node.name;
    }
    // TODO(#144): resolve the actual type being extended, if any.
    return '${node.name} extends $_jObject';
  }
}

enum _SetOrGet { setter, getter }

class _FieldGenerator extends Visitor<Field, void> {
  _FieldGenerator(this.config, this.s);

  final Config config;
  final StringBuffer s;

  @override
  void visit(Field node) {
    final name = node.finalName;

    // Docs
    final originalDecl = '${node.type.shorthand} ${node.name}';
    s.write('  /// from: ${node.modifiers.join(' ')} $originalDecl');
    node.javadoc?.accept(_DocGenerator(s, depth: 1));

    // Check if it can be a `static const` getter.
    if (node.isFinal && node.isStatic && node.defaultValue != null) {
      final value = node.defaultValue!;
      // TODO(#31): Should we leave String as a normal getter instead?
      if (value is String || value is num || value is bool) {
        s.write('  static const $name = ');
        if (value is String) {
          s.write('r"$value"');
        } else {
          s.write(value);
        }
        s.write(';\n');
        return;
      }
    }

    if (node.type.kind != Kind.primitive) {
      s.writeln(_deleteInstruction);
    }
  }
}

class _MethodGenerator extends Visitor<Method, void> {
  final StringBuffer s;

  _MethodGenerator(this.s);

  @override
  void visit(Method node) {
    // TODO: implement visit
  }
}
