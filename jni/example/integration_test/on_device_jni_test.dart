// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// This file contains mostly the same tests from package:jni's
// test/jni_object_test.dart. This file can be run on android device using
// flutter test integration_test/ and therefore useful for checking the
// working of JNI on an Android device (or emulator).

import 'dart:ffi';
import 'dart:io';
import 'dart:isolate';

import 'package:flutter_test/flutter_test.dart';

import 'package:jni/jni.dart';
import 'package:jni/src/jvalues.dart';

const maxLongInJava = 9223372036854775807;

void test<T>(String description, T Function() callback) {
  testWidgets(description, (widgetTester) async => callback);
}

void main() {
  if (!Platform.isAndroid) {
    try {
      Jni.spawn(dylibDir: "build/jni_libs");
    } on JvmExistsException {
      // TODO(#51): Support destroying and restarting JVM.
    }
  }
  final env = Jni.env;

  test('initDLApi', () {
    Jni.initDLApi();
  });

  test('get JNI Version', () {
    expect(Jni.env.GetVersion(), isNot(equals(0)));
  });

  test(
      'Manually lookup & call Integer.toHexString',
      () => using((arena) {
            // Method names on JniEnv* from C JNI API are capitalized
            // like in original, while other extension methods
            // follow Dart naming conventions.
            final integerClass =
                env.FindClass("java/lang/Integer".toNativeChars(arena));
            // Refer JNI spec on how to construct method signatures
            // Passing wrong signature leads to a segfault
            final hexMethod = env.GetStaticMethodID(
                integerClass,
                "toHexString".toNativeChars(arena),
                "(I)Ljava/lang/String;".toNativeChars(arena));

            for (var i in [1, 80, 13, 76, 11344]) {
              // if your argument is int, bool, or JObject (`Pointer<Void>`)
              // it can be directly placed in the list. To convert into different primitive
              // types, use JValue<Type> wrappers.
              final jres = env.CallStaticObjectMethodA(integerClass, hexMethod,
                  Jni.jvalues([JValueInt(i)], allocator: arena));

              // use asDartString extension method on Pointer<JniEnv>
              // to convert a String jobject result to string
              final res = env.asDartString(jres);
              expect(res, equals(i.toRadixString(16)));

              // Any object or class result from java is a local reference
              // and needs to be deleted explicitly.
              // Note that method and field IDs aren't local references.
              // But they are valid only until a reference to corresponding
              // java class exists.
              env.DeleteGlobalRef(jres);
            }
            env.DeleteGlobalRef(integerClass);
          }));

  test("asJString extension method", () {
    const str = "QWERTY QWERTY";
    // convenience method that wraps
    // converting dart string to native string,
    // instantiating java string, and freeing the native string
    final jstr = env.asJString(str);
    expect(str, equals(env.asDartString(jstr)));
    env.DeleteGlobalRef(jstr);
  });

  test(
      'GlobalJniEnv should catch exceptions',
      () => using((arena) {
            final integerClass =
                env.FindClass("java/lang/Integer".toNativeChars(arena));
            final parseIntMethod = env.GetStaticMethodID(
                integerClass,
                "parseInt".toNativeChars(arena),
                "(Ljava/lang/String;)I".toNativeChars(arena));
            final args = JValueArgs(["hello"], arena);
            expect(
                () => env.CallStaticIntMethodA(
                    integerClass, parseIntMethod, args.values),
                throwsA(isA<JniException>()));
          }));

  test(
      "Convert back & forth between Dart & Java strings",
      () => using((arena) {
            const str = "ABCD EFGH";
            // This is what asJString and asDartString do internally
            final jstr = env.NewStringUTF(str.toNativeChars(arena));
            final jchars = env.GetStringUTFChars(jstr, nullptr);
            final dstr = jchars.toDartString();
            env.ReleaseStringUTFChars(jstr, jchars);
            expect(str, equals(dstr));
            env.DeleteGlobalRef(jstr);
          }));

  test(
      "Print something from Java",
      () => using((arena) {
            final system =
                env.FindClass("java/lang/System".toNativeChars(arena));
            final field = env.GetStaticFieldID(
                system,
                "out".toNativeChars(arena),
                "Ljava/io/PrintStream;".toNativeChars(arena));
            final out = env.GetStaticObjectField(system, field);
            final printStream = env.GetObjectClass(out);
            final println = env.GetMethodID(
                printStream,
                "println".toNativeChars(arena),
                "(Ljava/lang/String;)V".toNativeChars(arena));
            const str = "\nHello World from JNI!";
            final jstr = env.asJString(str);
            env.CallVoidMethodA(out, println, Jni.jvalues([jstr]));
            env.deleteAllRefs([system, printStream, jstr]);
          }));
  test('Env create reference methods should retain their default behavior', () {
    final systemOut = Jni.retrieveStaticField<JObjectPtr>(
        "java/lang/System", "out", "Ljava/io/PrintStream;");
    var refType = env.GetObjectRefType(systemOut);
    expect(refType, equals(JObjectRefType.JNIGlobalRefType));
    final localRef = env.NewLocalRef(systemOut);
    refType = env.GetObjectRefType(localRef);
    expect(refType, equals(JObjectRefType.JNILocalRefType));
    final weakRef = env.NewWeakGlobalRef(systemOut);
    refType = env.GetObjectRefType(weakRef);
    expect(refType, equals(JObjectRefType.JNIWeakGlobalRefType));
    final globalRef = env.NewGlobalRef(localRef);
    refType = env.GetObjectRefType(globalRef);
    expect(refType, equals(JObjectRefType.JNIGlobalRefType));
    env.DeleteGlobalRef(globalRef);
    env.DeleteWeakGlobalRef(weakRef);
    env.DeleteLocalRef(localRef);
    env.DeleteGlobalRef(systemOut);
  });
  test('long methods return long int without loss of precision', () {
    using((arena) {
      final longClass = env.FindClass("java/lang/Long".toNativeChars(arena));
      final maxField = env.GetStaticFieldID(
        longClass,
        'MAX_VALUE'.toNativeChars(arena),
        'J'.toNativeChars(arena),
      );
      final maxValue = env.GetStaticLongField(longClass, maxField);
      expect(maxValue, equals(maxLongInJava));
      env.DeleteGlobalRef(longClass);
    });
  });

  test('class <-> object methods', () {
    using((arena) {
      final systemOut = Jni.retrieveStaticField<JObjectPtr>(
          "java/lang/System", "out", "Ljava/io/PrintStream;");
      final systemErr = Jni.retrieveStaticField<JObjectPtr>(
          "java/lang/System", "err", "Ljava/io/PrintStream;");
      final outClass = env.GetObjectClass(systemOut);
      expect(env.IsInstanceOf(systemOut, outClass), isTrue);
      expect(env.IsInstanceOf(systemErr, outClass), isTrue);
      final errClass = env.GetObjectClass(systemErr);
      expect(env.IsSameObject(outClass, errClass), isTrue);
      env.deleteAllRefs([systemOut, systemErr, outClass, errClass]);
    });
  });
  test("Long.intValue() using JObject", () {
    // JniClass wraps a local class reference, and
    // provides convenience functions.
    final longClass = Jni.findJClass("java/lang/Long");

    // looks for a constructor with given signature.
    // equivalently you can lookup a method with name <init>
    final longCtor = longClass.getCtorID("(J)V");

    // note that the arguments are just passed as a list.
    // allowed argument types are primitive types, JObject and its subclasses,
    // and raw JNI references (JObject). Strings will be automatically converted
    // to JNI strings.
    final long = longClass.newInstance(longCtor, [176]);

    final intValue = long.callMethodByName<int>("intValue", "()I", []);
    expect(intValue, equals(176));

    // delete any JObject and JniClass instances using .delete() after use.
    // Deletion is not strictly required since JNI objects / classes have
    // a NativeFinalizer. But deleting them after use is a good practice.
    long.delete();
    longClass.delete();
  });

  test("call a static method using JniClass APIs", () {
    final integerClass = Jni.findJClass("java/lang/Integer");
    final result = integerClass.callStaticMethodByName<JString>(
        "toHexString", "(I)Ljava/lang/String;", [JValueInt(31)]);

    // if the object is supposed to be a Java string
    // you can call toDartString on it.
    final resultString = result.toDartString();

    // Dart string is a copy, original object can be deleted.
    result.delete();
    expect(resultString, equals("1f"));

    // Also don't forget to delete the class
    integerClass.delete();
  });

  test("Call method with null argument, expect exception", () {
    final integerClass = Jni.findJClass("java/lang/Integer");
    expect(
        () => integerClass.callStaticMethodByName<int>(
            "parseInt", "(Ljava/lang/String;)I", [nullptr]),
        throwsException);
    integerClass.delete();
  });

  test("Try to find a non-exisiting class, expect exception", () {
    expect(() => Jni.findJClass("java/lang/NotExists"), throwsException);
  });

  /// callMethodByName will be expensive if making same call many times
  /// Use getMethodID to get a method ID and use it in subsequent calls
  test("Example for using getMethodID", () {
    final longClass = Jni.findJClass("java/lang/Long");
    final bitCountMethod = longClass.getStaticMethodID("bitCount", "(J)I");

    // Use newInstance if you want only one instance.
    // It finds the class, gets constructor ID and constructs an instance.
    final random = Jni.newInstance("java/util/Random", "()V", []);

    // You don't need a JniClass reference to get instance method IDs
    final nextIntMethod = random.getMethodID("nextInt", "(I)I");

    for (int i = 0; i < 100; i++) {
      int r = random.callMethod<int>(nextIntMethod, [JValueInt(256 * 256)]);
      int bits = 0;
      final jbc = longClass.callStaticMethod<int>(bitCountMethod, [r]);
      while (r != 0) {
        bits += r % 2;
        r = (r / 2).floor();
      }
      expect(jbc, equals(bits));
    }
    Jni.deleteAll([random, longClass]);
  });

  // One-off invocation of static method in single call.
  test("invoke_", () {
    final m = Jni.invokeStaticMethod<int>("java/lang/Short", "compare", "(SS)I",
        [JValueShort(1234), JValueShort(1324)]);
    expect(m, equals(1234 - 1324));
  });

  test("Java char from string", () {
    final m = Jni.invokeStaticMethod<bool>("java/lang/Character", "isLowerCase",
        "(C)Z", [JValueChar.fromString('X')]);
    expect(m, isFalse);
  });

  // One-off access of static field in single call.
  test("Get static field directly", () {
    final maxLong = Jni.retrieveStaticField<int>(
        "java/lang/Short", "MAX_VALUE", "S", JniCallType.shortType);
    expect(maxLong, equals(32767));
  });

  // Use callStringMethod if all you care about is a string result
  test("callStaticStringMethod", () {
    final longClass = Jni.findJClass("java/lang/Long");
    const n = 1223334444;
    final strFromJava = longClass.callStaticMethodByName<String>(
        "toOctalString", "(J)Ljava/lang/String;", [n]);
    expect(strFromJava, equals(n.toRadixString(8)));
    longClass.delete();
  });

  // In JObject, JniClass, and retrieve_/invoke_ methods
  // you can also pass Dart strings, apart from range of types
  // allowed by Jni.jvalues
  // They will be converted automatically.
  test(
    "Passing strings in arguments",
    () {
      final out = Jni.retrieveStaticField<JObject>(
          "java/lang/System", "out", "Ljava/io/PrintStream;");
      // uncomment next line to see output
      // (\n because test runner prints first char at end of the line)
      //out.callMethodByName<Null>(
      //    "println", "(Ljava/lang/Object;)V", ["\nWorks (Apparently)"]);
      out.delete();
    },
  );

  test("Passing strings in arguments 2", () {
    final twelve = Jni.invokeStaticMethod<int>("java/lang/Byte", "parseByte",
        "(Ljava/lang/String;)B", ["12"], JniCallType.byteType);
    expect(twelve, equals(12));
  });

  // You can use() method on JObject for using once and deleting.
  test("use() method", () {
    final randomInt = Jni.newInstance("java/util/Random", "()V", []).use(
        (random) =>
            random.callMethodByName<int>("nextInt", "(I)I", [JValueInt(15)]));
    expect(randomInt, lessThan(15));
  });

  // The JObject and JniClass have NativeFinalizer. However, it's possible to
  // explicitly use `Arena`.
  test('Using arena', () {
    final objects = <JObject>[];
    using((arena) {
      final r = Jni.findJClass('java/util/Random')..deletedIn(arena);
      final ctor = r.getCtorID("()V");
      for (int i = 0; i < 10; i++) {
        objects.add(r.newInstance(ctor, [])..deletedIn(arena));
      }
    });
    for (var object in objects) {
      expect(object.isDeleted, isTrue);
    }
  });

  test("enums", () {
    // Don't forget to escape $ in nested type names
    final ordinal = Jni.retrieveStaticField<JObject>(
            "java/net/Proxy\$Type", "HTTP", "Ljava/net/Proxy\$Type;")
        .use((f) => f.callMethodByName<int>("ordinal", "()I", []));
    expect(ordinal, equals(1));
  });

  test("casting", () {
    using((arena) {
      final str = "hello".toJString()..deletedIn(arena);
      final obj = str.castTo(JObject.type)..deletedIn(arena);
      final backToStr = obj.castTo(JString.type);
      expect(backToStr.toDartString(), str.toDartString());
      final _ = backToStr.castTo(JObject.type, deleteOriginal: true)
        ..deletedIn(arena);
      expect(backToStr.toDartString, throwsA(isA<UseAfterFreeException>()));
      expect(backToStr.delete, throwsA(isA<DoubleFreeException>()));
    });
  });

  test("Isolate", () {
    Isolate.spawn(doSomeWorkInIsolate, null);
  });

  test("Jni.findJClass should throw exceptions if class is not found", () {
    expect(
      () => Jni.findJClass("java/lang/Sting"),
      throwsA(isA<JniException>()),
    );
  });

  test("Methods rethrow exceptions in Java as JniException", () {
    expect(
      () => Jni.invokeStaticMethod<int>(
          "java/lang/Integer", "parseInt", "(Ljava/lang/String;)I", ["X"]),
      throwsA(isA<JniException>()),
    );
  });

  test("Passing long integer values to JNI", () {
    final maxLongStr = Jni.invokeStaticMethod<String>(
      "java/lang/Long",
      "toString",
      "(J)Ljava/lang/String;",
      [maxLongInJava],
    );
    expect(maxLongStr, equals('$maxLongInJava'));
  });

  test('Returning long integers from JNI', () {
    final maxLong = Jni.retrieveStaticField<int>(
      "java/lang/Long",
      "MAX_VALUE",
      "J",
      JniCallType.longType,
    );
    expect(maxLong, equals(maxLongInJava));
  });

  test("double free throws exception", () {
    final r = Jni.newInstance("java/util/Random", "()V", []);
    r.delete();
    expect(r.delete, throwsA(isA<DoubleFreeException>()));
  });

  test("Use after free throws exception", () {
    final r = Jni.newInstance("java/util/Random", "()V", []);
    r.delete();
    expect(() => r.callMethodByName<int>("nextInt", "(I)I", [JValueInt(256)]),
        throwsA(isA<UseAfterFreeException>()));
  });

  test("void fieldType throws exception", () {
    final r = Jni.newInstance("java/util/Random", "()V", []);
    expect(() => r.getField<void>(nullptr, JniCallType.voidType),
        throwsArgumentError);
    expect(() => r.getStaticField<void>(nullptr, JniCallType.voidType),
        throwsArgumentError);
  });

  test("Wrong callType throws exception", () {
    final r = Jni.newInstance("java/util/Random", "()V", []);
    expect(
        () => r.callMethodByName<int>(
            "nextInt", "(I)I", [JValueInt(256)], JniCallType.doubleType),
        throwsA(isA<InvalidCallTypeException>()));
  });

  test("An exception in JNI throws JniException in Dart", () {
    final r = Jni.newInstance("java/util/Random", "()V", []);
    expect(() => r.callMethodByName<int>("nextInt", "(I)I", [JValueInt(-1)]),
        throwsA(isA<JniException>()));
  });
}

void doSomeWorkInIsolate(Void? _) {
  // On standalone target, make sure to call [setDylibDir] before accessing
  // any JNI function in a new isolate.
  //
  // otherwise subsequent JNI calls will throw a "library not found" exception.
  Jni.setDylibDir(dylibDir: "build/jni_libs");
  final random = Jni.newInstance("java/util/Random", "()V", []);
  // final r = random.callMethodByName<int>("nextInt", "(I)I", [256]);
  // expect(r, lessThan(256));
  // Expect throws an [OutsideTestException]
  // but you can uncomment below print and see it works
  // print("\n$r");
  random.delete();
}
