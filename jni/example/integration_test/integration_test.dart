import 'dart:io';
// import 'package:path/path.dart' as path;
import 'package:ffi/ffi.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:jni/jni.dart';

void main() {
  if (!Platform.isAndroid) {
    Jni.spawn();
  }

  var jni = Jni.getInstance();

  testWidgets('Manually lookup & call Long.toHexString static method',
      (tester) async {
    final arena = Arena();
    final env = jni.getEnv();

    final longClass = env.FindClass("java/lang/Long".toNativeChars(arena));
    final hexMethod = env.GetStaticMethodID(
        longClass,
        "toHexString".toNativeChars(arena),
        "(J)Ljava/lang/String;".toNativeChars(arena));

    for (var i in [1, 80, 13, 76, 1134453224145]) {
      final jres = env.CallStaticObjectMethodA(
          longClass, hexMethod, Jni.jvalues([JValueLong(i)], allocator: arena));

      final res = env.asDartString(jres);
      expect(res, equals(i.toRadixString(16)));

      env.DeleteLocalRef(jres);
    }
    env.DeleteLocalRef(longClass);
    arena.releaseAll();
  });
}
