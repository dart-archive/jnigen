// Copyright (c) 2023, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// ignore_for_file: overridden_fields

import '../accessors.dart';
import '../jni.dart';
import '../jobject.dart';
import '../third_party/generated_bindings.dart';
import '../types.dart';

class JNumberType extends JObjType<JNumber> {
  const JNumberType();

  @override
  String get signature => r"Ljava/lang/Number;";

  @override
  JNumber fromRef(JObjectPtr ref) => JNumber.fromRef(ref);

  @override
  JObjType get superType => const JObjectType();

  @override
  final superCount = 1;

  @override
  int get hashCode => (JNumberType).hashCode;

  @override
  bool operator ==(Object other) {
    return other.runtimeType == JNumberType && other is JNumberType;
  }
}

class JNumber extends JObject {
  @override
  late final JObjType<JNumber> $type = type;

  JNumber.fromRef(
    JObjectPtr ref,
  ) : super.fromRef(ref);

  static final _classRef = Jni.findJClass(r"java/lang/Number");

  /// The type which includes information such as the signature of this class.
  static const type = JNumberType();
  static final _ctorId =
      Jni.accessors.getMethodIDOf(_classRef.reference, r"<init>", r"()V");

  JNumber()
      : super.fromRef(Jni.accessors
            .newObjectWithArgs(_classRef.reference, _ctorId, []).object);

  static final _intValueId =
      Jni.accessors.getMethodIDOf(_classRef.reference, r"intValue", r"()I");

  int intValue() {
    return Jni.accessors.callMethodWithArgs(
        reference, _intValueId, JniCallType.intType, []).integer;
  }

  static final _longValueId =
      Jni.accessors.getMethodIDOf(_classRef.reference, r"longValue", r"()J");

  int longValue() {
    return Jni.accessors.callMethodWithArgs(
        reference, _longValueId, JniCallType.longType, []).long;
  }

  static final _floatValueId =
      Jni.accessors.getMethodIDOf(_classRef.reference, r"floatValue", r"()F");

  double floatValue() {
    return Jni.accessors.callMethodWithArgs(
        reference, _floatValueId, JniCallType.floatType, []).float;
  }

  static final _doubleValueId =
      Jni.accessors.getMethodIDOf(_classRef.reference, r"doubleValue", r"()D");

  double doubleValue() {
    return Jni.accessors.callMethodWithArgs(
        reference, _doubleValueId, JniCallType.doubleType, []).doubleFloat;
  }

  static final _byteValueId =
      Jni.accessors.getMethodIDOf(_classRef.reference, r"byteValue", r"()B");

  int byteValue() {
    return Jni.accessors.callMethodWithArgs(
        reference, _byteValueId, JniCallType.byteType, []).byte;
  }

  static final _shortValueId =
      Jni.accessors.getMethodIDOf(_classRef.reference, r"shortValue", r"()S");

  int shortValue() {
    return Jni.accessors.callMethodWithArgs(
        reference, _shortValueId, JniCallType.shortType, []).short;
  }
}
