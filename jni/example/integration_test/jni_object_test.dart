// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import 'package:jni/jni.dart';

void main() {
  if (!Platform.isAndroid) {
    try {
      Jni.spawn(dylibDir: "build/jni_libs");
    } on JvmExistsException {
      // TODO(#51): Support destroying and restarting JVM.
    }
  }

  testWidgets("Long.intValue() using JlObject", (t) async {
    final longClass = Jni.findJlClass("java/lang/Long");

    final longCtor = longClass.getCtorID("(J)V");

    final long = longClass.newObject(longCtor, [176]);

    final intValue = long.callMethodByName<int>("intValue", "()I", []);
    expect(intValue, equals(176));

    long.delete();
    longClass.delete();
  });

  testWidgets("call a static method using JniClass APIs", (t) async {
    final integerClass = JlClass.fromRef(Jni.findClass("java/lang/Integer"));
    final result = integerClass.callStaticMethodByName<JlString>(
        "toHexString", "(I)Ljava/lang/String;", [31]);

    final resultString = result.toDartString();

    result.delete();
    expect(resultString, equals("1f"));

    integerClass.delete();
  });

  testWidgets("Example for using getMethodID", (t) async {
    final longClass = Jni.findJlClass("java/lang/Long");
    final bitCountMethod = longClass.getStaticMethodID("bitCount", "(J)I");

    final random = Jni.newInstance("java/util/Random", "()V", []);

    final nextIntMethod = random.getMethodID("nextInt", "(I)I");

    for (int i = 0; i < 100; i++) {
      int r = random.callMethod<int>(nextIntMethod, [256 * 256]);
      int bits = 0;
      final jbc =
          longClass.callStaticMethod<int>(bitCountMethod, [JValueLong(r)]);
      while (r != 0) {
        bits += r % 2;
        r = (r / 2).floor();
      }
      expect(jbc, equals(bits));
    }
    random.delete();
    longClass.delete();
  });

  // Actually it's not even required to get a reference to class
  testWidgets("invoke_", (t) async {
    final m = Jni.invokeStaticMethod<int>("java/lang/Long", "min", "(JJ)J",
        [JValueLong(1234), JValueLong(1324)], JniType.longType);
    expect(m, equals(1234));
  });

  testWidgets("retrieve_", (t) async {
    final maxLong = Jni.retrieveStaticField<int>(
        "java/lang/Short", "MAX_VALUE", "S", JniType.shortType);
    expect(maxLong, equals(32767));
  });

  testWidgets("callStaticStringMethod", (t) async {
    final longClass = Jni.findJlClass("java/lang/Long");
    const n = 1223334444;
    final strFromJava = longClass.callStaticMethodByName<String>(
        "toOctalString", "(J)Ljava/lang/String;", [JValueLong(n)]);
    expect(strFromJava, equals(n.toRadixString(8)));
    longClass.delete();
  });

  testWidgets("Passing strings in arguments", (t) async {
    final twelve = Jni.invokeStaticMethod<int>("java/lang/Byte", "parseByte",
        "(Ljava/lang/String;)B", ["12"], JniType.byteType);
    expect(twelve, equals(12));
  });

  testWidgets("use() method", (t) async {
    final randomInt = Jni.newInstance("java/util/Random", "()V", [])
        .use((random) => random.callMethodByName<int>("nextInt", "(I)I", [15]));
    expect(randomInt, lessThan(15));
  });

  testWidgets("enums", (t) async {
    final ordinal = Jni.retrieveStaticField<JlObject>(
            "java/net/Proxy\$Type", "HTTP", "Ljava/net/Proxy\$Type;")
        .use((f) => f.callMethodByName<int>("ordinal", "()I", []));
    expect(ordinal, equals(1));
  });
}
