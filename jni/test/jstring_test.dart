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

void testStringBackAndForth(String str) {
  final utf8String = str.toJString();
  final dartString = utf8String.toDartString(deleteOriginal: true);
  expect(dartString, str);
}

void run({required TestRunnerCallback testRunner}) {
  testRunner('Long string back-and-forth', () {
    testStringBackAndForth('1' * 8096);
  });

  testRunner('#278 UTF-8 bug', () {
    testStringBackAndForth('🐬');
  });

  testRunner('String containing null character', () {
    final str = 'A${String.fromCharCode(0)}B';
    testStringBackAndForth(str);
  });

  testRunner('Zero length string', () {
    testStringBackAndForth('');
  });
}
