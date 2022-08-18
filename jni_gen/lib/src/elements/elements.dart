// Types to describe java API elements

import 'package:json_annotation/json_annotation.dart';

part 'elements.g.dart';

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

// Note: We give default values in constructor, if the field is nullable in
// JSON. this allows us to reduce JSON size by providing Include.NON_NULL
// option in java.

@JsonSerializable(explicitToJson: true)
class ClassDecl {
  ClassDecl({
    this.annotations = const [],
    this.javadoc,
    this.modifiers = const {},
    required this.simpleName,
    required this.binaryName,
    this.parentName,
    this.packageName,
    this.typeParams = const [],
    this.methods = const [],
    this.fields = const [],
    this.superclass,
    this.interfaces = const [],
    this.hasStaticInit = false,
    this.hasInstanceInit = false,
    this.values,
  });

  List<Annotation> annotations;
  JavaDocComment? javadoc;

  Set<String> modifiers;
  String simpleName, binaryName;
  String? parentName, packageName;
  List<TypeParam> typeParams;
  List<Method> methods;
  List<Field> fields;
  TypeUsage? superclass;
  List<TypeUsage> interfaces;
  bool hasStaticInit, hasInstanceInit;

  // if the declaration is an ENUM
  List<String>? values;

  factory ClassDecl.fromJson(Map<String, dynamic> json) =>
      _$ClassDeclFromJson(json);
  Map<String, dynamic> toJson() => _$ClassDeclToJson(this);

  @override
  String toString() {
    return "class: $binaryName";
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

@JsonSerializable(explicitToJson: true)
class TypeUsage {
  TypeUsage({
    required this.shorthand,
    required this.kind,
    required this.typeJson,
  });

  String shorthand;
  Kind kind;
  @JsonKey(ignore: true)
  late ReferredType type;
  @JsonKey(name: "type")
  Map<String, dynamic> typeJson;

  String get name => type.name;

  // because json_serializable doesn't directly support union types.
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
  Map<String, dynamic> toJson() => _$TypeUsageToJson(this);
}

abstract class ReferredType {
  String get name;
}

@JsonSerializable(explicitToJson: true)
class PrimitiveType implements ReferredType {
  PrimitiveType({required this.name});

  @override
  String name;

  factory PrimitiveType.fromJson(Map<String, dynamic> json) =>
      _$PrimitiveTypeFromJson(json);
  Map<String, dynamic> toJson() => _$PrimitiveTypeToJson(this);
}

@JsonSerializable(explicitToJson: true)
class DeclaredType implements ReferredType {
  DeclaredType({
    required this.binaryName,
    required this.simpleName,
    this.params = const [],
  });
  String binaryName, simpleName;
  List<TypeUsage> params;

  @override
  String get name => binaryName;

  factory DeclaredType.fromJson(Map<String, dynamic> json) =>
      _$DeclaredTypeFromJson(json);
  Map<String, dynamic> toJson() => _$DeclaredTypeToJson(this);
}

@JsonSerializable(explicitToJson: true)
class TypeVar implements ReferredType {
  TypeVar({required this.name});
  @override
  String name;

  factory TypeVar.fromJson(Map<String, dynamic> json) =>
      _$TypeVarFromJson(json);
  Map<String, dynamic> toJson() => _$TypeVarToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Wildcard implements ReferredType {
  Wildcard({this.extendsBound, this.superBound});
  TypeUsage? extendsBound, superBound;

  @override
  String get name => "?";

  factory Wildcard.fromJson(Map<String, dynamic> json) =>
      _$WildcardFromJson(json);
  Map<String, dynamic> toJson() => _$WildcardToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ArrayType implements ReferredType {
  ArrayType({required this.type});
  TypeUsage type;

  @override
  String get name => "[";

  factory ArrayType.fromJson(Map<String, dynamic> json) =>
      _$ArrayTypeFromJson(json);
  Map<String, dynamic> toJson() => _$ArrayTypeToJson(this);
}

abstract class ClassMember {
  String get name;
}

@JsonSerializable(explicitToJson: true)
class Method implements ClassMember {
  Method(
      {this.annotations = const [],
      this.javadoc,
      this.modifiers = const {},
      required this.name,
      this.typeParams = const [],
      this.params = const [],
      required this.returnType});
  List<Annotation> annotations;
  JavaDocComment? javadoc;
  Set<String> modifiers;

  @override
  String name;

  List<TypeParam> typeParams;
  List<Param> params;
  TypeUsage returnType;

  factory Method.fromJson(Map<String, dynamic> json) => _$MethodFromJson(json);
  Map<String, dynamic> toJson() => _$MethodToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Param {
  Param(
      {this.annotations = const [],
      this.javadoc,
      required this.name,
      required this.type});
  List<Annotation> annotations;
  JavaDocComment? javadoc;

  String name;
  TypeUsage type;

  factory Param.fromJson(Map<String, dynamic> json) => _$ParamFromJson(json);
  Map<String, dynamic> toJson() => _$ParamToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Field implements ClassMember {
  Field(
      {this.annotations = const [],
      this.javadoc,
      this.modifiers = const {},
      required this.name,
      required this.type,
      this.defaultValue});

  List<Annotation> annotations;
  JavaDocComment? javadoc;

  Set<String> modifiers;

  @override
  String name;

  TypeUsage type;
  Object? defaultValue;

  factory Field.fromJson(Map<String, dynamic> json) => _$FieldFromJson(json);
  Map<String, dynamic> toJson() => _$FieldToJson(this);
}

@JsonSerializable(explicitToJson: true)
class TypeParam {
  TypeParam({required this.name, this.bounds = const []});
  String name;
  List<TypeUsage> bounds;

  factory TypeParam.fromJson(Map<String, dynamic> json) =>
      _$TypeParamFromJson(json);
  Map<String, dynamic> toJson() => _$TypeParamToJson(this);
}

@JsonSerializable(explicitToJson: true)
class JavaDocComment {
  JavaDocComment({required this.comment});
  String comment;

  factory JavaDocComment.fromJson(Map<String, dynamic> json) =>
      _$JavaDocCommentFromJson(json);
  Map<String, dynamic> toJson() => _$JavaDocCommentToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Annotation {
  Annotation(
      {required this.simpleName,
      required this.binaryName,
      this.properties = const {}});
  String simpleName;
  String binaryName;
  Map<String, Object> properties;

  factory Annotation.fromJson(Map<String, dynamic> json) =>
      _$AnnotationFromJson(json);
  Map<String, dynamic> toJson() => _$AnnotationToJson(this);
}
