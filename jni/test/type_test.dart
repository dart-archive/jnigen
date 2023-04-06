// Copyright (c) 2023, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:jni/jni.dart';
import 'package:test/test.dart';

void main() {
  if (!Platform.isAndroid) {
    try {
      Jni.spawn(dylibDir: "build/jni_libs", jvmOptions: ["-Xmx128m"]);
    } on JvmExistsException catch (_) {
      // TODO(#51): Support destroying and reinstantiating JVM.
    }
  }

  test('commonType', () {
    expect(commonType([JObject.type, JObject.type]), JObject.type);
    expect(commonType([JString.type, JString.type]), JString.type);
    expect(commonType([JString.type, JArray.type(JLong.type)]), JObject.type);
  });
}
