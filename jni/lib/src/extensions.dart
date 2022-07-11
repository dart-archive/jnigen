import 'dart:ffi';

import 'package:ffi/ffi.dart';

import 'third_party/jni_bindings_generated.dart';

extension StringMethodsForJni on String {
  /// Returns a Utf-8 encoded Pointer<Char> with contents same as this string.
  Pointer<Char> toNativeChars([Allocator allocator = malloc]) {
    return toNativeUtf8(allocator: allocator).cast<Char>();
  }
}

extension CharPtrMethodsForJni on Pointer<Char> {
  /// Same as calling `cast<Utf8>` followed by `toDartString`.
  String toDartString() {
    return cast<Utf8>().toDartString();
  }
}

extension AdditionalJniEnvMethods on Pointer<JniEnv> {
  /// Convenience method for converting a [JString]
  /// to dart string.
  String asDartString(JString jstring) {
    final chars = GetStringUTFChars(jstring, nullptr);
    if (chars == nullptr) {
      checkException();
    }
    final result = chars.cast<Utf8>().toDartString();
    ReleaseStringUTFChars(jstring, chars);
    return result;
  }

  /// Return a new [JString] from contents of [s].
  JString asJString(String s, [Allocator allocator = malloc]) {
    final utf = s.toNativeUtf8(allocator: allocator).cast<Char>();
    final result = NewStringUTF(utf);
    malloc.free(utf);
    return result;
  }

  /// Deletes all local references in [refs].
  void deleteAllLocalRefs(List<JObject> refs) {
    for (var ref in refs) {
      DeleteLocalRef(ref);
    }
  }

  /// If any exception is pending in JNI, throw it in Dart.
  ///
  /// If [describe] is true, a description is printed to screen.
  /// To access actual exception object, use `ExceptionOccurred`.
  void checkException({bool describe = false}) {
    var exc = ExceptionOccurred();
    if (exc != nullptr) {
      // TODO: Doing this every time is expensive
      // Should lookup and cache method reference
      // and keep it alive by keeping a reference to Exception class
      final ecls = GetObjectClass(exc);
      final toStr = GetMethodID(ecls, _toString, _toStringSig);
      final jstr = CallObjectMethod(exc, toStr);
      final dstr = asDartString(jstr);
      for (var i in [jstr, ecls, exc]) {
        DeleteLocalRef(i);
      }
      if (describe) {
        ExceptionDescribe();
      } else {
        ExceptionClear();
      }
      throw Exception(dstr);
    }
  }
}

// Better ways to allocate these?

final _toString = "toString".toNativeChars();
final _toStringSig = "()Ljava/lang/String;".toNativeChars();
