// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of 'jni_object.dart';

abstract class JniTypeClass<T> {
  int get _type => JniType.objectType;

  String get signature;

  JniClass _getClass() => Jni.findJniClass(signature);
}

class JniBooleanTypeClass extends JniTypeClass<JBoolean> {
  @override
  int get _type => JniType.booleanType;

  @override
  String get signature => "Z";
}

class JniByteTypeClass extends JniTypeClass<JByte> {
  @override
  int get _type => JniType.byteType;

  @override
  String get signature => "B";
}

class JniCharTypeClass extends JniTypeClass<JChar> {
  @override
  int get _type => JniType.charType;

  @override
  String get signature => "C";
}

class JniShortTypeClass extends JniTypeClass<JShort> {
  @override
  int get _type => JniType.shortType;

  @override
  String get signature => "S";
}

class JniIntTypeClass extends JniTypeClass<JInt> {
  @override
  int get _type => JniType.intType;

  @override
  String get signature => "I";
}

class JniLongTypeClass extends JniTypeClass<JLong> {
  @override
  int get _type => JniType.longType;

  @override
  String get signature => "J";
}

class JniFloatTypeClass extends JniTypeClass<JFloat> {
  @override
  int get _type => JniType.floatType;

  @override
  String get signature => "F";
}

class JniDoubleTypeClass extends JniTypeClass<JDouble> {
  @override
  int get _type => JniType.doubleType;

  @override
  String get signature => "D";
}

class JniObjectTypeClass extends JniTypeClass<JniObject> {
  @override
  String get signature => "Ljava/lang/Object;";
}

class JniStringTypeClass extends JniTypeClass<JniString> {
  @override
  String get signature => "Ljava/lang/String;";
}

class JniArrayTypeClass<T> extends JniTypeClass<JniArray<T>> {
  final JniTypeClass<T> elementType;
  JniArrayTypeClass(this.elementType);

  @override
  String get signature => '[${elementType.signature}';
}
