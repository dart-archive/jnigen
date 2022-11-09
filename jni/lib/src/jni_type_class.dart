// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of 'jtypes.dart';

abstract class JniType<T> {
  const JniType();

  int get _type => JniCallType.objectType;

  String get signature;

  JniClass _getClass() => Jni.findJniClass(signature);
}

class _JniBooleanType extends JniType<JBoolean> {
  const _JniBooleanType();

  @override
  int get _type => JniCallType.booleanType;

  @override
  String get signature => "Z";
}

class _JniByteTypeClass extends JniType<JByte> {
  const _JniByteTypeClass();

  @override
  int get _type => JniCallType.byteType;

  @override
  String get signature => "B";
}

class _JniCharType extends JniType<JChar> {
  const _JniCharType();

  @override
  int get _type => JniCallType.charType;

  @override
  String get signature => "C";
}

class _JniShortType extends JniType<JShort> {
  const _JniShortType();

  @override
  int get _type => JniCallType.shortType;

  @override
  String get signature => "S";
}

class _JniIntType extends JniType<JInt> {
  const _JniIntType();

  @override
  int get _type => JniCallType.intType;

  @override
  String get signature => "I";
}

class _JniLongType extends JniType<JLong> {
  const _JniLongType();

  @override
  int get _type => JniCallType.longType;

  @override
  String get signature => "J";
}

class _JniFloatType extends JniType<JFloat> {
  const _JniFloatType();

  @override
  int get _type => JniCallType.floatType;

  @override
  String get signature => "F";
}

class _JniDoubleType extends JniType<JDouble> {
  const _JniDoubleType();

  @override
  int get _type => JniCallType.doubleType;

  @override
  String get signature => "D";
}

class _JniObjectType extends JniType<JniObject> {
  const _JniObjectType();

  @override
  String get signature => "Ljava/lang/Object;";
}

class _JniStringType extends JniType<JniString> {
  const _JniStringType();

  @override
  String get signature => "Ljava/lang/String;";
}

class _JniArrayType<T> extends JniType<JniArray<T>> {
  final JniType<T> elementType;

  const _JniArrayType(this.elementType);

  @override
  String get signature => '[${elementType.signature}';
}
