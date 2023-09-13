// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:jni/src/jreference.dart';

import '../jni.dart';
import '../jobject.dart';
import '../third_party/generated_bindings.dart';
import '../types.dart';

final class JStringType extends JObjType<JString> {
  const JStringType();

  @override
  String get signature => "Ljava/lang/String;";

  @override
  JString fromRef(Pointer<Void> ref) => JString.fromRef(ref);

  @override
  JObjType get superType => const JObjectType();

  @override
  final int superCount = 1;

  @override
  int get hashCode => (JStringType).hashCode;

  @override
  bool operator ==(Object other) {
    return other.runtimeType == JStringType && other is JStringType;
  }
}

class JString extends JObject {
  @override
  // ignore: overridden_fields
  late final JObjType<JString> $type = type;

  /// The type which includes information such as the signature of this class.
  static const JObjType<JString> type = JStringType();

  /// Construct a new [JString] with [reference] as its underlying reference.
  JString.fromRef(JStringPtr reference) : super.fromRef(reference);

  /// The number of Unicode characters in this Java string.
  int get length => Jni.env.GetStringLength(reference);

  /// Construct a [JString] from the contents of Dart string [s].
  JString.fromString(String s) : super.fromRef(Jni.env.toJStringPtr(s));

  /// Returns the contents as a Dart String.
  ///
  /// If [releaseOriginal] is true, the underlying reference is deleted
  /// after conversion and this object will be marked as released.
  String toDartString({bool releaseOriginal = false}) {
    ensureNotNull();
    final length = Jni.env.GetStringLength(reference);
    final chars = Jni.env.GetStringChars(reference, nullptr);
    final result = chars.cast<Utf16>().toDartString(length: length);
    Jni.env.ReleaseStringChars(reference, chars);
    if (releaseOriginal) {
      release();
    }
    return result;
  }
}

extension ToJStringMethod on String {
  /// Returns a [JString] with the contents of this String.
  JString toJString() {
    return JString.fromString(this);
  }
}
