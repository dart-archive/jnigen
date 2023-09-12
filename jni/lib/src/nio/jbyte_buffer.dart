// Copyright (c) 2023, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:ffi';
import 'dart:typed_data';

import '../accessors.dart';
import '../jarray.dart';
import '../jni.dart';
import '../jprimitives.dart';
import '../jreference.dart';
import '../jvalues.dart';
import '../third_party/generated_bindings.dart';
import '../types.dart';
import 'jbuffer.dart';

class JByteBufferType extends JObjType<JByteBuffer> {
  const JByteBufferType();

  @override
  String get signature => r"Ljava/nio/ByteBuffer;";

  @override
  JByteBuffer fromRef(JObjectPtr ref) => JByteBuffer.fromRef(ref);

  @override
  JObjType get superType => const JBufferType();

  @override
  final superCount = 2;

  @override
  int get hashCode => (JByteBufferType).hashCode;

  @override
  bool operator ==(Object other) {
    return other.runtimeType == (JByteBufferType) && other is JByteBufferType;
  }
}

class JByteBuffer extends JBuffer {
  @override
  // ignore: overridden_fields
  late final JObjType<JByteBuffer> $type = type;

  JByteBuffer.fromRef(
    JObjectPtr ref,
  ) : super.fromRef(ref);

  static final _class = Jni.findJClass(r"java/nio/ByteBuffer");

  /// The type which includes information such as the signature of this class.
  static const type = JByteBufferType();

  static final _allocateDirectId = Jni.accessors.getStaticMethodIDOf(
      _class.reference, r"allocateDirect", r"(I)Ljava/nio/ByteBuffer;");

  /// Allocates a new direct byte buffer.
  ///
  /// Throws:
  /// * [IllegalArgumentException] - If the capacity is a negative integer
  factory JByteBuffer.allocateDirect(int capacity) {
    return JByteBuffer.fromRef(
      Jni.accessors.callStaticMethodWithArgs(
          _class.reference,
          _allocateDirectId,
          JniCallType.objectType,
          [JValueInt(capacity)]).object,
    );
  }

  static final _allocateId = Jni.accessors.getStaticMethodIDOf(
      _class.reference, r"allocate", r"(I)Ljava/nio/ByteBuffer;");

  /// Allocates a new byte buffer.
  ///
  /// Throws:
  /// * [IllegalArgumentException] - If the capacity is a negative integer
  factory JByteBuffer.allocate(int capacity) {
    return const JByteBufferType().fromRef(Jni.accessors
        .callStaticMethodWithArgs(_class.reference, _allocateId,
            JniCallType.objectType, [JValueInt(capacity)]).object);
  }

  static final _wrapWholeId = Jni.accessors.getStaticMethodIDOf(
      _class.reference, r"wrap", r"([B)Ljava/nio/ByteBuffer;");
  static final _wrapId = Jni.accessors.getStaticMethodIDOf(
      _class.reference, r"wrap", r"([BII)Ljava/nio/ByteBuffer;");

  /// Wraps a byte array into a buffer.
  ///
  /// The new buffer will be backed by the given byte array; that is,
  /// modifications to the buffer will cause the array to be modified
  /// and vice versa.
  static JByteBuffer wrap(
    JArray<jbyte> array, [
    int? offset,
    int? length,
  ]) {
    if (offset == null && length == null) {
      return const JByteBufferType().fromRef(
        Jni.accessors.callStaticMethodWithArgs(
          _class.reference,
          _wrapWholeId,
          JniCallType.objectType,
          [array.reference],
        ).object,
      );
    }
    offset ??= 0;
    length ??= array.length - offset;
    return const JByteBufferType().fromRef(
      Jni.accessors.callStaticMethodWithArgs(
        _class.reference,
        _wrapId,
        JniCallType.objectType,
        [array.reference, JValueInt(offset), JValueInt(length)],
      ).object,
    );
  }

  static final _sliceId = Jni.accessors
      .getMethodIDOf(_class.reference, r"slice", r"()Ljava/nio/ByteBuffer;");

  /// Creates a new byte buffer whose content is a shared subsequence of this
  /// buffer's content.
  JByteBuffer slice() {
    return const JByteBufferType().fromRef(Jni.accessors.callMethodWithArgs(
        reference, _sliceId, JniCallType.objectType, []).object);
  }

  static final _duplicateId = Jni.accessors.getMethodIDOf(
      _class.reference, r"duplicate", r"()Ljava/nio/ByteBuffer;");

  /// Creates a new byte buffer that shares this buffer's content.
  JByteBuffer duplicate() {
    return const JByteBufferType().fromRef(Jni.accessors.callMethodWithArgs(
        reference, _duplicateId, JniCallType.objectType, []).object);
  }

  static final _asReadOnlyBufferId = Jni.accessors.getMethodIDOf(
      _class.reference, r"asReadOnlyBuffer", r"()Ljava/nio/ByteBuffer;");

  /// Creates a new, read-only byte buffer that shares this buffer's content.
  JByteBuffer asReadOnlyBuffer() {
    return const JByteBufferType().fromRef(Jni.accessors.callMethodWithArgs(
        reference, _asReadOnlyBufferId, JniCallType.objectType, []).object);
  }

  static final _getId =
      Jni.accessors.getMethodIDOf(_class.reference, r"get", r"()B");

  /// Reads the byte at this buffer's current [position], and then increments the
  /// [position].
  ///
  /// Throws:
  ///  * [BufferOverflowException] - If the buffer's current [position] is not
  ///    smaller than its [limit]
  int get nextByte {
    return Jni.accessors
        .callMethodWithArgs(reference, _getId, JniCallType.byteType, []).byte;
  }

  static final _putId = Jni.accessors
      .getMethodIDOf(_class.reference, r"put", r"(B)Ljava/nio/ByteBuffer;");

  /// Writes the given byte into this buffer at the current [position], and then
  /// increments the [position].
  ///
  /// Throws:
  /// * [BufferOverflowException] - If this buffer's current [position] is not
  ///   smaller than its [limit]
  /// * [ReadOnlyBufferException] - If this buffer is read-only
  set nextByte(int b) {
    Jni.env.DeleteGlobalRef(Jni.accessors.callMethodWithArgs(
        reference, _putId, JniCallType.objectType, [JValueByte(b)]).object);
  }

  static final _arrayId =
      Jni.accessors.getMethodIDOf(_class.reference, r"array", r"()[B");

  @override
  JArray<jbyte> get array {
    return const JArrayType(jbyteType()).fromRef(Jni.accessors
        .callMethodWithArgs(
            reference, _arrayId, JniCallType.objectType, []).object);
  }

  /// Returns this byte buffer as a [Uint8List].
  ///
  /// If [releaseOriginal] is `true`, this byte buffer will be released.
  ///
  /// Throws [StateError] if the buffer is not direct or the JVM does not
  /// support the direct buffer operations or the object is an unaligned view
  /// buffer and the processor does not support unaligned access.
  Uint8List asUint8List({bool releaseOriginal = false}) {
    if (!isDirect) {
      throw StateError(
        'The buffer must be created with `JByteBuffer.allocateDirect`.',
      );
    }
    final address = Jni.env.GetDirectBufferAddress(reference);
    if (address == nullptr) {
      StateError(
        'The memory region is undefined or '
        'direct buffer access is not supported by this JVM.',
      );
    }
    final capacity = Jni.env.GetDirectBufferCapacity(reference);
    if (capacity == -1) {
      StateError(
        'The object is an unaligned view buffer and the processor '
        'architecture does not support unaligned access.',
      );
    }
    final token = releaseOriginal ? reference : Jni.env.NewGlobalRef(reference);
    if (releaseOriginal) {
      setAsReleased();
    }
    return address.cast<Uint8>().asTypedList(
          capacity,
          token: token,
          finalizer: Jni.env.ptr.ref.DeleteGlobalRef.cast(),
        );
  }
}
