// Copyright (c) 2023, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'lang/jstring.dart';
import 'jarray.dart';
import 'jobject.dart';

class MethodInvocation {
  final JString uuid;
  final JString methodDescriptor;
  final JArray<JObject> args;

  MethodInvocation._(this.uuid, this.methodDescriptor, this.args);

  factory MethodInvocation.fromMessage(List<dynamic> message) {
    final uuid = JString.fromRef(message[0]);
    final methodDescriptor = JString.fromRef(message[1]);
    final args = JArray.fromRef(const JObjectType(), message[2]);
    return MethodInvocation._(uuid, methodDescriptor, args);
  }
}
