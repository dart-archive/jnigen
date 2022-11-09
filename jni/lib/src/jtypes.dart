// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:ffi';

import 'package:collection/collection.dart';
import 'package:ffi/ffi.dart';

import 'accessors.dart';
import 'jni.dart';
import 'jni_exceptions.dart';
import 'jvalues.dart';
import 'third_party/jni_bindings_generated.dart';

part 'jprimitives.dart';
part 'jni_object.dart';
part 'jarray.dart';
part 'jni_type_class.dart';

final Pointer<JniAccessors> _accessors = Jni.accessors;
final Pointer<GlobalJniEnv> _env = Jni.env;
// This typedef is needed because void is a keyword and cannot be used in
// type switch like a regular type.
typedef _VoidType = void;
