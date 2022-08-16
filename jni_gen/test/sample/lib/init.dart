import "dart:ffi";
import "package:jni/jni.dart";

final Pointer<T> Function<T extends NativeType>(String sym) jlookup =
    Jni.getInstance().initGeneratedLibrary("jni_gen_sample");
