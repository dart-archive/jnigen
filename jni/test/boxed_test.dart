// Copyright (c) 2023, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:jni/jni.dart';
import 'package:test/test.dart';

import 'test_util/test_util.dart';

void main() {
  // Don't forget to initialize JNI.
  if (!Platform.isAndroid) {
    checkDylibIsUpToDate();
    Jni.spawnIfNotExists(dylibDir: "build/jni_libs", jvmOptions: ["-Xmx128m"]);
  }
  run(testRunner: test);
}

void run({required TestRunnerCallback testRunner}) {
  testRunner('JByte', () {
    const val = 1 << 5;
    using((arena) {
      expect(JByte(val).byteValue(deleteOriginal: true), val);
      expect((-val).toJByte().byteValue(deleteOriginal: true), -val);
    });
  });
  testRunner('JShort', () {
    const val = 1 << 10;
    using((arena) {
      expect(JShort(val).shortValue(deleteOriginal: true), val);
      expect((-val).toJShort().shortValue(deleteOriginal: true), -val);
    });
  });
  testRunner('JInteger', () {
    const val = 1 << 20;
    using((arena) {
      expect(JInteger(val).intValue(deleteOriginal: true), val);
      expect((-val).toJInteger().intValue(deleteOriginal: true), -val);
    });
  });
  testRunner('JLong', () {
    const val = 1 << 40;
    using((arena) {
      expect(JLong(val).longValue(deleteOriginal: true), val);
      expect((-val).toJLong().longValue(deleteOriginal: true), -val);
    });
  });
  testRunner('JFloat', () {
    const val = 3.14;
    const eps = 1e-6;
    using((arena) {
      expect(JFloat(val).floatValue(deleteOriginal: true), closeTo(val, eps));
      expect((-val).toJFloat().floatValue(deleteOriginal: true),
          closeTo(-val, eps));
    });
  });
  testRunner('JDouble', () {
    const val = 3.14;
    const eps = 1e-9;
    using((arena) {
      expect(JDouble(val).doubleValue(deleteOriginal: true), closeTo(val, eps));
      expect((-val).toJDouble().doubleValue(deleteOriginal: true),
          closeTo(-val, eps));
    });
  });
  testRunner('JBoolean', () {
    using((arena) {
      expect(JBoolean(false).booleanValue(deleteOriginal: true), false);
      expect(JBoolean(true).booleanValue(deleteOriginal: true), true);
    });
  });
}
