import 'dart:ffi';
import 'dart:io';

import 'package:jni/jni.dart';
import 'package:test/test.dart';

void main() {
  // Running on Android through flutter, this plugin
  // will bind to Android runtime's JVM.
  // On other platforms eg Flutter desktop or Dart standalone
  // You need to manually create a JVM at beginning.
  //
  // On flutter desktop, the C wrappers are bundled, and helperPath param
  // is not required.
  //
  // On dart standalone, however, there's no way to bundle the wrappers.
  // You have to manually pass the path to the `dartjni` dynamic library.

  if (!Platform.isAndroid) {
    try {
      Jni.spawn(dylibDir: "build/jni_libs", jvmOptions: ["-Xmx128m"]);
    } on JvmExistsException catch (_) {
      // TODO(#51): Support destroying and reinstantiating JVM.
    }
  }

  // Tests in this file demonstrate how to use `Indir`, a thin abstraction over
  // JNIEnv in JNI C API. Indir can be used from multiple threads, and converts
  // all returned object references to global references, so that you don't
  // need to worry about whether your Dart code will be scheduled on another
  // thread.
  //
  // Indir wraps all methods of JNIEnv (UpperCamelCase, reflecting original name
  // of the method) and provides few more extension methods (lowerCamelCase).
  //
  // For examples of a higher level API, see `jl_object_tests.dart`.
  final indir = Jni.indir;

  test('get JNI Version', () {
    final indir = Jni.indir;
    expect(indir.GetVersion(), isNot(equals(0)));
  });

  test('Manually lookup & call Long.toHexString static method', () {
    // create an arena for allocating anything native
    // it's convenient way to release all natively allocated strings
    // and values at once.
    final arena = Arena();

    // Method names on JniEnv* from C JNI API are capitalized
    // like in original, while other extension methods
    // follow Dart naming conventions.
    final longClass = indir.FindClass("java/lang/Long".toNativeChars(arena));
    // Refer JNI spec on how to construct method signatures
    // Passing wrong signature leads to a segfault
    final hexMethod = indir.GetStaticMethodID(
        longClass,
        "toHexString".toNativeChars(arena),
        "(J)Ljava/lang/String;".toNativeChars(arena));

    for (var i in [1, 80, 13, 76, 1134453224145]) {
      // Use Jni.jvalues method to easily construct native argument arrays
      // if your argument is int, bool, or JObject (`Pointer<Void>`)
      // it can be directly placed in the list. To convert into different primitive
      // types, use JValue<Type> wrappers.
      final jres = indir.CallStaticObjectMethodA(
          longClass, hexMethod, Jni.jvalues([JValueLong(i)], allocator: arena));

      // use asDartString extension method on Pointer<JniEnv>
      // to convert a String jobject result to string
      final res = indir.asDartString(jres);
      expect(res, equals(i.toRadixString(16)));

      // Any object or class result from java is a local reference
      // and needs to be deleted explicitly.
      // Note that method and field IDs aren't local references.
      // But they are valid only until a reference to corresponding
      // java class exists.
      indir.DeleteGlobalRef(jres);
    }
    indir.DeleteGlobalRef(longClass);
    arena.releaseAll();
  });

  test("asJString extension method", () {
    const str = "QWERTY QWERTY";
    // convenience method that wraps
    // converting dart string to native string,
    // instantiating java string, and freeing the native string
    final jstr = indir.asJString(str);
    expect(str, equals(indir.asDartString(jstr)));
    indir.DeleteGlobalRef(jstr);
  });

  test("Convert back and forth between dart and java string", () {
    final arena = Arena();
    const str = "ABCD EFGH";
    // This is what asJString and asDartString do internally
    final jstr = indir.NewStringUTF(str.toNativeChars(arena));
    final jchars = indir.GetStringUTFChars(jstr, nullptr);
    final dstr = jchars.toDartString();
    indir.ReleaseStringUTFChars(jstr, jchars);
    expect(str, equals(dstr));
    indir.DeleteGlobalRef(jstr);
    arena.releaseAll();
  });

  test("Print something from Java", () {
    final arena = Arena();
    final system = indir.FindClass("java/lang/System".toNativeChars(arena));
    final field = indir.GetStaticFieldID(system, "out".toNativeChars(arena),
        "Ljava/io/PrintStream;".toNativeChars(arena));
    final out = indir.GetStaticObjectField(system, field);
    final printStream = indir.GetObjectClass(out);
    /*
    final println = env.GetMethodID(printStream, "println".toNativeChars(arena),
        "(Ljava/lang/String;)V".toNativeChars(arena));
	*/
    const str = "\nHello JNI!";
    final jstr = indir.asJString(str);
    // test runner can't compare what's printed by Java, leaving it
    // env.CallVoidMethodA(out, println, Jni.jvalues([jstr]));
    indir.deleteAllRefs([system, printStream, jstr]);
    arena.releaseAll();
  });
}
