import 'dart:ffi';

import 'third_party/jni_bindings_generated.dart';

class UseAfterFreeException implements Exception {
  dynamic object;
  Pointer<Void> ptr;
  UseAfterFreeException(this.object, this.ptr);

  @override
  String toString() {
    return "use after free on $ptr through $object";
  }
}

class DoubleFreeException implements Exception {
  dynamic object;
  Pointer<Void> ptr;
  DoubleFreeException(this.object, this.ptr);

  @override
  String toString() {
    return "double on $ptr through $object";
  }
}

class JniException implements Exception {
  /// Exception object pointer from JNI.
  final JObject err;

  /// brief description, usually initialized with error message from Java.
  final String msg;
  JniException(this.err, this.msg);

  @override
  String toString() => msg;

  void deleteIn(Pointer<JniEnv> env) => env.DeleteLocalRef(err);
}
