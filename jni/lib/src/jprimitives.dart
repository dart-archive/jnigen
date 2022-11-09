// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of 'jtypes.dart';

abstract class JPrimitive {}

abstract class JByte extends JPrimitive {
  static const type = _JniByteTypeClass();
}

abstract class JBoolean extends JPrimitive {
  static const type = _JniBooleanType();
}

abstract class JChar extends JPrimitive {
  static const type = _JniCharType();
}

abstract class JShort extends JPrimitive {
  static const type = _JniShortType();
}

abstract class JInt extends JPrimitive {
  static const type = _JniIntType();
}

abstract class JLong extends JPrimitive {
  static const type = _JniLongType();
}

abstract class JFloat extends JPrimitive {
  static const type = _JniFloatType();
}

abstract class JDouble extends JPrimitive {
  static const type = _JniDoubleType();
}
