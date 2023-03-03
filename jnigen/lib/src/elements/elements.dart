// Copyright (c) 2022, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Types to describe java API elements

import 'package:jnigen/src/bindings/visitor.dart';
import 'package:json_annotation/json_annotation.dart';

part 'elements.g.dart';

abstract class Element<T extends Element<T>> {
  const Element();

  void accept(Visitor<T> v);
}

@JsonEnum()

/// A kind describes the type of a declaration.
enum DeclKind {
  @JsonValue('CLASS')
  classKind,
  @JsonValue('INTERFACE')
  interfaceKind,
  @JsonValue('ENUM')
  enumKind,
}

class Classes implements Element<Classes> {
  const Classes(this.decls);

  final Map<String, ClassDecl> decls;

  factory Classes.fromJson(List<dynamic> json) {
    final decls = <String, ClassDecl>{};
    for (final declJson in json) {
      final classDecl = ClassDecl.fromJson(declJson);
      decls[classDecl.binaryName] = classDecl;
    }
    return Classes(decls);
  }

  @override
  void accept(Visitor<Classes> v) {
    v.visit(this);
  }
}

// Note: We give default values in constructor, if the field is nullable in
// JSON. this allows us to reduce JSON size by providing Include.NON_NULL
// option in java.

@JsonSerializable(createToJson: false)
class ClassDecl implements Element<ClassDecl> {
  ClassDecl({
    this.annotations = const [],
    this.javadoc,
    this.modifiers = const {},
    required this.simpleName,
    required this.binaryName,
    this.packageName = '',
    this.parentName,
    this.typeParams = const [],
    this.methods = const [],
    this.fields = const [],
    this.superclass,
    this.interfaces = const [],
    this.hasStaticInit = false,
    this.hasInstanceInit = false,
    this.values,
  });

  final List<Annotation> annotations;
  final JavaDocComment? javadoc;
  final Set<String> modifiers;
  final String simpleName;
  final String binaryName;
  final String? parentName;
  final String packageName;
  List<TypeParam> typeParams;
  List<Method> methods;
  List<Field> fields;
  final List<TypeUsage> interfaces;
  final bool hasStaticInit;
  final bool hasInstanceInit;

  /// Will default to java.lang.Object if null by [Linker].
  TypeUsage? superclass;

  /// Contains enum constant names if class is an enum,
  /// as obtained by `.values()` method in Java.
  final List<String>? values;

  String get internalName => binaryName.replaceAll(".", "/");

  /// Parent's [ClassDecl] obtained from [parentName].
  ///
  /// Will be populated by [Linker].
  @JsonKey(includeFromJson: false)
  late final ClassDecl? parent;

  /// Final name of this class.
  ///
  /// Will be populated by [Renamer].
  @JsonKey(includeFromJson: false)
  late final String finalName;

  /// Unique name obtained by renaming conflicting names with a number.
  ///
  /// This is used by C bindings instead of fully qualified name to reduce
  /// the verbosity of generated bindings.
  ///
  /// Will be populated by [Renamer].
  @JsonKey(includeFromJson: false)
  late final String uniqueName;

  /// Type parameters including the ones from its ancestors
  ///
  /// Will be populated by [Linker].
  @JsonKey(includeFromJson: false)
  List<TypeParam> allTypeParams = const [];

  @override
  String toString() {
    return 'Java class declaration for $binaryName';
  }

  static final object = ClassDecl(
    binaryName: 'java.lang.Object',
    packageName: 'java.lang',
    simpleName: 'Object',
  );

  factory ClassDecl.fromJson(Map<String, dynamic> json) =>
      _$ClassDeclFromJson(json);

  @override
  void accept(Visitor<ClassDecl> v) {
    v.visit(this);
  }
}

@JsonEnum()
enum Kind {
  @JsonValue('PRIMITIVE')
  primitive,
  @JsonValue('TYPE_VARIABLE')
  typeVariable,
  @JsonValue('WILDCARD')
  wildcard,
  @JsonValue('DECLARED')
  declared,
  @JsonValue('ARRAY')
  array,
}

@JsonSerializable(createToJson: false)
class TypeUsage {
  TypeUsage({
    required this.shorthand,
    required this.kind,
    required this.typeJson,
  });

  static TypeUsage object = () {
    final typeUsage = TypeUsage.fromJson({
      "shorthand": "java.lang.Object",
      "kind": "DECLARED",
      "type": {"binaryName": "java.lang.Object", "simpleName": "Object"}
    });
    (typeUsage.type as DeclaredType).classDecl = ClassDecl.object;
    return typeUsage;
  }();

  final String shorthand;
  final Kind kind;

  @JsonKey(name: "type")
  final Map<String, dynamic> typeJson;

  /// Will be populated in [TypeUsage.fromJson].
  @JsonKey(includeFromJson: false)
  late final ReferredType type;

  String get name => type.name;

  // Since json_serializable doesn't directly support union types,
  // we have to temporarily store `type` in a JSON map, and switch on the
  // enum value received.
  factory TypeUsage.fromJson(Map<String, dynamic> json) {
    final t = _$TypeUsageFromJson(json);
    switch (t.kind) {
      case Kind.primitive:
        t.type = PrimitiveType.fromJson(t.typeJson);
        break;
      case Kind.typeVariable:
        t.type = TypeVar.fromJson(t.typeJson);
        break;
      case Kind.wildcard:
        t.type = Wildcard.fromJson(t.typeJson);
        break;
      case Kind.declared:
        t.type = DeclaredType.fromJson(t.typeJson);
        break;
      case Kind.array:
        t.type = ArrayType.fromJson(t.typeJson);
        break;
    }
    return t;
  }

  void accept(TypeVisitor v) {
    type.accept(v);
  }
}

abstract class ReferredType<T extends ReferredType<T>> {
  const ReferredType();
  String get name;

  void accept(TypeVisitor v);
}

@JsonSerializable(createToJson: false)
class PrimitiveType extends ReferredType<PrimitiveType> {
  const PrimitiveType({required this.name});

  @override
  final String name;

  factory PrimitiveType.fromJson(Map<String, dynamic> json) =>
      _$PrimitiveTypeFromJson(json);

  @override
  void accept(TypeVisitor v) {
    v.visitPrimitiveType(this);
  }
}

@JsonSerializable(createToJson: false)
class DeclaredType extends ReferredType<DeclaredType> {
  DeclaredType({
    required this.binaryName,
    required this.simpleName,
    this.params = const [],
  });

  final String binaryName;
  final String simpleName;
  final List<TypeUsage> params;

  @JsonKey(includeFromJson: false)
  late ClassDecl classDecl;

  @override
  String get name => binaryName;

  factory DeclaredType.fromJson(Map<String, dynamic> json) =>
      _$DeclaredTypeFromJson(json);

  @override
  void accept(TypeVisitor v) {
    v.visitDeclaredType(this);
  }
}

@JsonSerializable(createToJson: false)
class TypeVar extends ReferredType<TypeVar> {
  TypeVar({required this.name});

  @override
  String name;

  factory TypeVar.fromJson(Map<String, dynamic> json) =>
      _$TypeVarFromJson(json);

  @override
  void accept(TypeVisitor v) {
    v.visitTypeVar(this);
  }
}

@JsonSerializable(createToJson: false)
class Wildcard extends ReferredType<Wildcard> {
  Wildcard({this.extendsBound, this.superBound});
  TypeUsage? extendsBound, superBound;

  @override
  String get name => "?";

  factory Wildcard.fromJson(Map<String, dynamic> json) =>
      _$WildcardFromJson(json);

  @override
  void accept(TypeVisitor v) {
    v.visitWildcard(this);
  }
}

@JsonSerializable(createToJson: false)
class ArrayType extends ReferredType<ArrayType> {
  ArrayType({required this.type});
  TypeUsage type;

  @override
  String get name => "[${type.name}";

  factory ArrayType.fromJson(Map<String, dynamic> json) =>
      _$ArrayTypeFromJson(json);

  @override
  void accept(TypeVisitor v) {
    v.visitArrayType(this);
  }
}

abstract class ClassMember {
  String get name;
  ClassDecl get classDecl;
}

@JsonSerializable(createToJson: false)
class Method extends ClassMember implements Element<Method> {
  Method({
    this.annotations = const [],
    this.javadoc,
    this.modifiers = const {},
    required this.name,
    this.typeParams = const [],
    this.params = const [],
    required this.returnType,
  });

  @override
  final String name;
  final List<Annotation> annotations;
  final JavaDocComment? javadoc;
  final Set<String> modifiers;
  final List<TypeParam> typeParams;
  final List<Param> params;
  final TypeUsage returnType;

  /// The [ClassDecl] where this method is defined.
  ///
  /// Will be populated by [Linker].
  @JsonKey(includeFromJson: false)
  @override
  late ClassDecl classDecl;

  /// Will be populated by [Renamer].
  @JsonKey(includeFromJson: false)
  late String finalName;

  @JsonKey(includeFromJson: false)
  late bool isOverridden;

  /// This gets populated in the preprocessing stage.
  ///
  /// It will contain a type only when the suspendFunToAsync flag is on
  /// and the method has a `kotlin.coroutines.Continuation` final argument.
  @JsonKey(includeFromJson: false)
  late TypeUsage? asyncReturnType;

  @JsonKey(includeFromJson: false)
  late String javaSig = _javaSig();

  String _javaSig() {
    final paramNames = params.map((p) => p.type.name).join(', ');
    return '${returnType.name} $name($paramNames)';
  }

  factory Method.fromJson(Map<String, dynamic> json) => _$MethodFromJson(json);

  @override
  void accept(Visitor<Method> v) {
    v.visit(this);
  }
}

@JsonSerializable(createToJson: false)
class Param implements Element<Param> {
  Param({
    this.annotations = const [],
    this.javadoc,
    required this.name,
    required this.type,
  });

  final List<Annotation> annotations;
  final JavaDocComment? javadoc;
  final String name;
  final TypeUsage type;

  /// Will be populated by [Renamer].
  @JsonKey(includeFromJson: false)
  late final String finalName;

  factory Param.fromJson(Map<String, dynamic> json) => _$ParamFromJson(json);

  @override
  void accept(Visitor<Param> v) {
    v.visit(this);
  }
}

@JsonSerializable(createToJson: false)
class Field extends ClassMember implements Element<Field> {
  Field({
    this.annotations = const [],
    this.javadoc,
    this.modifiers = const {},
    required this.name,
    required this.type,
    this.defaultValue,
  });

  @override
  final String name;
  final List<Annotation> annotations;
  final JavaDocComment? javadoc;
  final Set<String> modifiers;
  final TypeUsage type;
  final Object? defaultValue;

  /// The [ClassDecl] where this field is defined.
  ///
  /// Will be populated by [Linker].
  @JsonKey(includeFromJson: false)
  @override
  late final ClassDecl classDecl;

  /// Will be populated by [Renamer].
  @JsonKey(includeFromJson: false)
  late final String finalName;

  factory Field.fromJson(Map<String, dynamic> json) => _$FieldFromJson(json);

  @override
  void accept(Visitor<Field> v) {
    v.visit(this);
  }
}

@JsonSerializable(createToJson: false)
class TypeParam implements Element<TypeParam> {
  TypeParam({required this.name, this.bounds = const []});

  final String name;
  final List<TypeUsage> bounds;

  @JsonKey(includeFromJson: false)
  late final String erasure;

  factory TypeParam.fromJson(Map<String, dynamic> json) =>
      _$TypeParamFromJson(json);

  @override
  void accept(Visitor<TypeParam> v) {
    v.visit(this);
  }
}

@JsonSerializable(createToJson: false)
class JavaDocComment implements Element<JavaDocComment> {
  JavaDocComment({this.comment = ''});

  final String comment;

  @JsonKey(includeFromJson: false)
  late final String dartDoc;

  factory JavaDocComment.fromJson(Map<String, dynamic> json) =>
      _$JavaDocCommentFromJson(json);

  @override
  void accept(Visitor<JavaDocComment> v) {
    v.visit(this);
  }
}

@JsonSerializable(createToJson: false)
class Annotation implements Element<Annotation> {
  Annotation({
    required this.simpleName,
    required this.binaryName,
    this.properties = const {},
  });

  final String simpleName;
  final String binaryName;
  final Map<String, Object> properties;

  factory Annotation.fromJson(Map<String, dynamic> json) =>
      _$AnnotationFromJson(json);

  @override
  void accept(Visitor<Annotation> v) {
    v.visit(this);
  }
}
