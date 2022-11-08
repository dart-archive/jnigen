// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of 'jni_object.dart';

abstract class JniTypeClass<T> {
  const JniTypeClass();

  int get _type => JniCallType.objectType;

  String get signature;

  JniClass _getClass() => Jni.findJniClass(signature);
}

class JniBooleanTypeClass extends JniTypeClass<JBoolean> {
  const JniBooleanTypeClass();

  @override
  int get _type => JniCallType.booleanType;

  @override
  String get signature => "Z";
}

class JniByteTypeClass extends JniTypeClass<JByte> {
  const JniByteTypeClass();

  @override
  int get _type => JniCallType.byteType;

  @override
  String get signature => "B";
}

class JniCharTypeClass extends JniTypeClass<JChar> {
  const JniCharTypeClass();

  @override
  int get _type => JniCallType.charType;

  @override
  String get signature => "C";
}

class JniShortTypeClass extends JniTypeClass<JShort> {
  const JniShortTypeClass();

  @override
  int get _type => JniCallType.shortType;

  @override
  String get signature => "S";
}

class JniIntTypeClass extends JniTypeClass<JInt> {
  const JniIntTypeClass();

  @override
  int get _type => JniCallType.intType;

  @override
  String get signature => "I";
}

class JniLongTypeClass extends JniTypeClass<JLong> {
  const JniLongTypeClass();

  @override
  int get _type => JniCallType.longType;

  @override
  String get signature => "J";
}

class JniFloatTypeClass extends JniTypeClass<JFloat> {
  const JniFloatTypeClass();

  @override
  int get _type => JniCallType.floatType;

  @override
  String get signature => "F";
}

class JniDoubleTypeClass extends JniTypeClass<JDouble> {
  const JniDoubleTypeClass();

  @override
  int get _type => JniCallType.doubleType;

  @override
  String get signature => "D";
}

class JniObjectTypeClass extends JniTypeClass<JniObject> {
  const JniObjectTypeClass();

  @override
  String get signature => "Ljava/lang/Object;";
}

class JniStringTypeClass extends JniTypeClass<JniString> {
  const JniStringTypeClass();

  @override
  String get signature => "Ljava/lang/String;";
}

class JniArrayTypeClass<T> extends JniTypeClass<JniArray<T>> {
  final JniTypeClass<T> elementType;

  const JniArrayTypeClass(this.elementType);

  @override
  String get signature => '[${elementType.signature}';
}
