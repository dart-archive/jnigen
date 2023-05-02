// Copyright (c) 2023, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// ignore_for_file: overridden_fields

import '../third_party/generated_bindings.dart';
import '../types.dart';
import 'jnumber.dart';

class $ByteType extends JObjType<JByte> {
  const $ByteType();

  @override
  String get signature => r"Ljava/lang/Byte;";

  @override
  JByte fromRef(JObjectPtr ref) => JByte.fromRef(ref);

  @override
  JObjType get superType => const JNumberType();

  @override
  final superCount = 2;

  @override
  int get hashCode => ($ByteType).hashCode;

  @override
  bool operator ==(Object other) {
    return other.runtimeType == $ByteType && other is $ByteType;
  }
}

class JByte extends JNumber {
  @override
  late final JObjType<JByte> $type = type;

  JByte.fromRef(
    JObjectPtr ref,
  ) : super.fromRef(ref);

  /// The type which includes information such as the signature of this class.
  static const type = $ByteType();

  static const bytes = 1;
  static const maxValue = 127;
  static const minValue = -128;
  static const size = 8;
}
