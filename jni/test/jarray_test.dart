// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:jni/jni.dart';
import 'package:test/test.dart';

void main() {
  // Don't forget to initialize JNI.
  if (!Platform.isAndroid) {
    try {
      Jni.spawn(dylibDir: "build/jni_libs", jvmOptions: ["-Xmx128m"]);
    } on JvmExistsException catch (_) {
      // TODO(#51): Support destroying and reinstantiating JVM.
    }
  }
  test("Java boolean array", () {
    final array = JArray(JBoolean.type, 3);
    expect(array.length, 3);
    array[0] = true;
    array[1] = false;
    array[2] = false;
    expect(array[0], true);
    expect(array[1], false);
    expect(array[2], false);
    array.setRange(0, 3, [false, true, true, true], 1);
    expect(array[0], true);
    expect(array[1], true);
    expect(array[2], true);
    expect(() {
      final _ = array[-1];
    }, throwsRangeError);
    expect(() {
      array[-1] = false;
    }, throwsRangeError);
    expect(() {
      array[3] = false;
    }, throwsRangeError);
    array.delete();
  });
  test("Java char array", () {
    final array = JArray(JChar.type, 3);
    expect(array.length, 3);
    array[0] = 'ح';
    array[1] = '2';
    array[2] = '3';
    expect(array[0], 'ح');
    expect(array[1], '2');
    expect(array[2], '3');
    array.setRange(0, 3, ['4', '5', '6', '7'], 1);
    expect(array[0], '5');
    expect(array[1], '6');
    expect(array[2], '7');
    expect(() {
      final _ = array[-1];
    }, throwsRangeError);
    expect(() {
      array[-1] = '4';
    }, throwsRangeError);
    expect(() {
      array[3] = '4';
    }, throwsRangeError);
    array.delete();
  });
  test("Java byte array", () {
    final array = JArray(JByte.type, 3);
    expect(array.length, 3);
    array[0] = 1;
    array[1] = 2;
    array[2] = 3 + 256 * 5; // truncates the input;
    expect(array[0], 1);
    expect(array[1], 2);
    expect(array[2], 3);
    array.setRange(0, 3, [4, 5, 6, 7], 1);
    expect(array[0], 5);
    expect(array[1], 6);
    expect(array[2], 7);
    expect(() {
      final _ = array[-1];
    }, throwsRangeError);
    expect(() {
      array[-1] = 4;
    }, throwsRangeError);
    expect(() {
      array[3] = 4;
    }, throwsRangeError);
    array.delete();
  });
  test("Java short array", () {
    final array = JArray(JShort.type, 3);
    expect(array.length, 3);
    array[0] = 1;
    array[1] = 2;
    array[2] = 3 + 256 * 256 * 5; // truncates the input
    expect(array[0], 1);
    expect(array[1], 2);
    expect(array[2], 3);
    array.setRange(0, 3, [4, 5, 6, 7], 1);
    expect(array[0], 5);
    expect(array[1], 6);
    expect(array[2], 7);
    expect(() {
      final _ = array[-1];
    }, throwsRangeError);
    expect(() {
      array[-1] = 4;
    }, throwsRangeError);
    expect(() {
      array[3] = 4;
    }, throwsRangeError);
    array.delete();
  });
  test("Java int array", () {
    final array = JArray(JInt.type, 3);
    expect(array.length, 3);
    array[0] = 1;
    array[1] = 2;
    array[2] = 3 + 256 * 256 * 256 * 256 * 5; // truncates the input
    expect(array[0], 1);
    expect(array[1], 2);
    expect(array[2], 3);
    array.setRange(0, 3, [4, 5, 6, 7], 1);
    expect(array[0], 5);
    expect(array[1], 6);
    expect(array[2], 7);
    expect(() {
      final _ = array[-1];
    }, throwsRangeError);
    expect(() {
      array[-1] = 4;
    }, throwsRangeError);
    expect(() {
      array[3] = 4;
    }, throwsRangeError);
    array.delete();
  });
  const epsilon = 1e-6;
  test("Java float array", () {
    final array = JArray(JFloat.type, 3);
    expect(array.length, 3);
    array[0] = 0.5;
    array[1] = 2;
    array[2] = 3;
    expect(array[0], closeTo(0.5, epsilon));
    expect(array[1], closeTo(2, epsilon));
    expect(array[2], closeTo(3, epsilon));
    array.setRange(0, 3, [4, 5, 6, 7], 1);
    expect(array[0], closeTo(5, epsilon));
    expect(array[1], closeTo(6, epsilon));
    expect(array[2], closeTo(7, epsilon));
    expect(() {
      final _ = array[-1];
    }, throwsRangeError);
    expect(() {
      array[-1] = 4;
    }, throwsRangeError);
    expect(() {
      array[3] = 4;
    }, throwsRangeError);
    array.delete();
  });
  test("Java double array", () {
    final array = JArray(JDouble.type, 3);
    expect(array.length, 3);
    array[0] = 0.5;
    array[1] = 2;
    array[2] = 3;
    expect(array[0], closeTo(0.5, epsilon));
    expect(array[1], closeTo(2, epsilon));
    expect(array[2], closeTo(3, epsilon));
    array.setRange(0, 3, [4, 5, 6, 7], 1);
    expect(array[0], closeTo(5, epsilon));
    expect(array[1], closeTo(6, epsilon));
    expect(array[2], closeTo(7, epsilon));
    expect(() {
      final _ = array[-1];
    }, throwsRangeError);
    expect(() {
      array[-1] = 4;
    }, throwsRangeError);
    expect(() {
      array[3] = 4;
    }, throwsRangeError);
    array.delete();
  });
  test("Java string array", () {
    final array = JArray(JString.type, 3);
    expect(array.length, 3);
    array[0] = "حس".toJString();
    array[1] = "\$".toJString();
    array[2] = "33".toJString();
    expect(array[0].toDartString(), "حس");
    expect(array[1].toDartString(), "\$");
    expect(array[2].toDartString(), "33");
    array.setRange(
      0,
      3,
      ["44".toJString(), "55".toJString(), "66".toJString(), "77".toJString()],
      1,
    );
    expect(array[0].toDartString(), "55");
    expect(array[1].toDartString(), "66");
    expect(array[2].toDartString(), "77");
    expect(() {
      final _ = array[-1];
    }, throwsRangeError);
    expect(() {
      array[-1] = "44".toJString();
    }, throwsRangeError);
    expect(() {
      array[3] = "44".toJString();
    }, throwsRangeError);
    array.delete();
  });
  test("Java 2d array", () {
    final array = JArray(JInt.type, 3);
    array[0] = 1;
    array[1] = 2;
    array[2] = 3;
    final twoDimArray = JArray(JArray.type(JInt.type), 3);
    expect(twoDimArray.length, 3);
    twoDimArray[0] = array;
    twoDimArray[1] = array;
    twoDimArray[2] = array;
    for (var i = 0; i < 3; ++i) {
      expect(twoDimArray[i][0], 1);
      expect(twoDimArray[i][1], 2);
      expect(twoDimArray[i][2], 3);
    }
    twoDimArray[2][2] = 4;
    expect(twoDimArray[2][2], 4);
    twoDimArray.delete();
    array.delete();
  });
}
