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
    final array = Jni.newBooleanArray(3);
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
      array[-1] = false;
    }, throwsRangeError);
    expect(() {
      array[3] = false;
    }, throwsRangeError);
    array.delete();
  });
  test("Java char array", () {
    final array = Jni.newCharArray(3);
    expect(array.length, 3);
    array[0] = '1';
    array[1] = '2';
    array[2] = '3';
    expect(array[0], '1');
    expect(array[1], '2');
    expect(array[2], '3');
    array.setRange(0, 3, ['4', '5', '6', '7'], 1);
    expect(array[0], '5');
    expect(array[1], '6');
    expect(array[2], '7');
    expect(() {
      array[-1] = '4';
    }, throwsRangeError);
    expect(() {
      array[3] = '4';
    }, throwsRangeError);
    array.delete();
  });
  test("Java byte array", () {
    final array = Jni.newByteArray(3);
    expect(array.length, 3);
    array[0] = 1;
    array[1] = 2;
    array[2] = 3;
    expect(array[0], 1);
    expect(array[1], 2);
    expect(array[2], 3);
    array.setRange(0, 3, [4, 5, 6, 7], 1);
    expect(array[0], 5);
    expect(array[1], 6);
    expect(array[2], 7);
    expect(() {
      array[-1] = 4;
    }, throwsRangeError);
    expect(() {
      array[3] = 4;
    }, throwsRangeError);
    array.delete();
  });
  test("Java short array", () {
    final array = Jni.newShortArray(3);
    expect(array.length, 3);
    array[0] = 1;
    array[1] = 2;
    array[2] = 3;
    expect(array[0], 1);
    expect(array[1], 2);
    expect(array[2], 3);
    array.setRange(0, 3, [4, 5, 6, 7], 1);
    expect(array[0], 5);
    expect(array[1], 6);
    expect(array[2], 7);
    expect(() {
      array[-1] = 4;
    }, throwsRangeError);
    expect(() {
      array[3] = 4;
    }, throwsRangeError);
    array.delete();
  });
  test("Java int array", () {
    final array = Jni.newIntArray(3);
    expect(array.length, 3);
    array[0] = 1;
    array[1] = 2;
    array[2] = 3;
    expect(array[0], 1);
    expect(array[1], 2);
    expect(array[2], 3);
    array.setRange(0, 3, [4, 5, 6, 7], 1);
    expect(array[0], 5);
    expect(array[1], 6);
    expect(array[2], 7);
    expect(() {
      array[-1] = 4;
    }, throwsRangeError);
    expect(() {
      array[3] = 4;
    }, throwsRangeError);
    array.delete();
  });
  test("Java float array", () {
    final array = Jni.newFloatArray(3);
    expect(array.length, 3);
    array[0] = 0.5;
    array[1] = 2;
    array[2] = 3;
    expect(array[0], 0.5);
    expect(array[1], 2);
    expect(array[2], 3);
    array.setRange(0, 3, [4, 5, 6, 7], 1);
    expect(array[0], 5);
    expect(array[1], 6);
    expect(array[2], 7);
    expect(() {
      array[-1] = 4;
    }, throwsRangeError);
    expect(() {
      array[3] = 4;
    }, throwsRangeError);
    array.delete();
  });
  test("Java double array", () {
    final array = Jni.newDoubleArray(3);
    expect(array.length, 3);
    array[0] = 0.5;
    array[1] = 2;
    array[2] = 3;
    expect(array[0], 0.5);
    expect(array[1], 2);
    expect(array[2], 3);
    array.setRange(0, 3, [4, 5, 6, 7], 1);
    expect(array[0], 5);
    expect(array[1], 6);
    expect(array[2], 7);
    expect(() {
      array[-1] = 4;
    }, throwsRangeError);
    expect(() {
      array[3] = 4;
    }, throwsRangeError);
    array.delete();
  });
  test("Java string array", () {
    final array = Jni.newArray<JniString>(
      3,
      Jni.findClass("java/lang/String"),
    );
    expect(array.length, 3);
    array[0] = "11".jniString();
    array[1] = "22".jniString();
    array[2] = "33".jniString();
    expect(array[0].toDartString(), "11");
    expect(array[1].toDartString(), "22");
    expect(array[2].toDartString(), "33");
    array.setRange(
      0,
      3,
      ["44".jniString(), "55".jniString(), "66".jniString(), "77".jniString()],
      1,
    );
    expect(array[0].toDartString(), "55");
    expect(array[1].toDartString(), "66");
    expect(array[2].toDartString(), "77");
    expect(() {
      array[-1] = "44".jniString();
    }, throwsRangeError);
    expect(() {
      array[3] = "44".jniString();
    }, throwsRangeError);
    array.delete();
  });
  test("Java 2d array", () {
    final array = Jni.newIntArray(3);
    array[0] = 1;
    array[1] = 2;
    array[2] = 3;
    final twoDimArray = Jni.newArray<JniArray<JInt>>(
      3,
      Jni.findClass("[I"),
      array.reference,
    );
    expect(twoDimArray.length, 3);
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
