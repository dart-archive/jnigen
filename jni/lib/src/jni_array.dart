// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of 'jni_object.dart';

class JniArray<E> extends JniObject {
  /// Construct a new [JniArray] with [reference] as its underlying reference.
  JniArray.fromRef(JArray reference) : super.fromRef(reference);

  int? _length;

  /// The number of elements in this array.
  int get length {
    return _length ??= _env.GetArrayLength(reference);
  }
}

extension NativeJniArray<E extends NativeType> on JniArray<E> {
  void _allocate(int size, void Function(Pointer<E> ptr) use) {
    using((arena) {
      final ptr = arena.allocate<E>(size);
      use(ptr);
    }, malloc);
  }
}

extension BoolJniArray on JniArray<JBoolean> {
  bool operator [](int index) {
    RangeError.checkValidIndex(index, this);
    return _env.GetBooleanArrayElements(
            reference, nullptr.cast<Uint8>())[index] >
        0;
  }

  void operator []=(int index, bool value) {
    RangeError.checkValidIndex(index, this);
    _allocate(sizeOf<JBoolean>(), (ptr) {
      ptr.value = value ? 1 : 0;
      _env.SetBooleanArrayRegion(reference, index, 1, ptr);
    });
  }

  void setRange(int start, int end, Iterable<bool> iterable,
      [int skipCount = 0]) {
    RangeError.checkValidRange(start, end, length);
    final size = end - start;
    final it = iterable.skip(skipCount).take(size);
    _allocate(sizeOf<JBoolean>() * size, (ptr) {
      it.forEachIndexed((index, element) {
        ptr[index] = element ? 1 : 0;
      });
      _env.SetBooleanArrayRegion(reference, start, size, ptr);
    });
  }
}

extension ByteJniArray on JniArray<JByte> {
  int operator [](int index) {
    RangeError.checkValidIndex(index, this);
    return _env.GetByteArrayElements(reference, nullptr.cast<Uint8>())[index];
  }

  void operator []=(int index, int value) {
    RangeError.checkValidIndex(index, this);
    _allocate(sizeOf<JByte>(), (ptr) {
      ptr.value = value;
      _env.SetByteArrayRegion(reference, index, 1, ptr);
    });
  }

  void setRange(int start, int end, Iterable<int> iterable,
      [int skipCount = 0]) {
    RangeError.checkValidRange(start, end, length);
    final size = end - start;
    final it = iterable.skip(skipCount).take(size);
    _allocate(sizeOf<JByte>() * size, (ptr) {
      it.forEachIndexed((index, element) {
        ptr[index] = element;
      });
      _env.SetByteArrayRegion(reference, start, size, ptr);
    });
  }
}

extension CharJniArray on JniArray<JChar> {
  String operator [](int index) {
    RangeError.checkValidIndex(index, this);
    return String.fromCharCode(
      _env.GetCharArrayElements(reference, nullptr.cast<Uint8>()).value,
    );
  }

  void operator []=(int index, String value) {
    RangeError.checkValidIndex(index, this);
    _allocate(sizeOf<JChar>(), (ptr) {
      ptr.value = value.codeUnits.first;
      _env.SetCharArrayRegion(reference, index, 1, ptr);
    });
  }

  void setRange(int start, int end, Iterable<String> iterable,
      [int skipCount = 0]) {
    RangeError.checkValidRange(start, end, length);
    final size = end - start;
    final it = iterable.skip(skipCount).take(size);
    _allocate(sizeOf<JChar>() * size, (ptr) {
      it.forEachIndexed((index, element) {
        ptr[index] = element.codeUnits.first;
      });
      _env.SetCharArrayRegion(reference, start, size, ptr);
    });
  }
}

extension ShortJniArray on JniArray<JShort> {
  int operator [](int index) {
    RangeError.checkValidIndex(index, this);
    return _env.GetShortArrayElements(reference, nullptr.cast<Uint8>())[index];
  }

  void operator []=(int index, int value) {
    RangeError.checkValidIndex(index, this);
    _allocate(sizeOf<JShort>(), (ptr) {
      ptr.value = value;
      _env.SetShortArrayRegion(reference, index, 1, ptr);
    });
  }

  void setRange(int start, int end, Iterable<int> iterable,
      [int skipCount = 0]) {
    RangeError.checkValidRange(start, end, length);
    final size = end - start;
    final it = iterable.skip(skipCount).take(size);
    _allocate(sizeOf<JShort>() * size, (ptr) {
      it.forEachIndexed((index, element) {
        ptr[index] = element;
      });
      _env.SetShortArrayRegion(reference, start, size, ptr);
    });
  }
}

extension IntJniArray on JniArray<JInt> {
  int operator [](int index) {
    RangeError.checkValidIndex(index, this);
    return _env.GetIntArrayElements(reference, nullptr.cast<Uint8>())[index];
  }

  void operator []=(int index, int value) {
    RangeError.checkValidIndex(index, this);
    _allocate(sizeOf<JInt>(), (ptr) {
      ptr.value = value;
      _env.SetIntArrayRegion(reference, index, 1, ptr);
    });
  }

  void setRange(int start, int end, Iterable<int> iterable,
      [int skipCount = 0]) {
    RangeError.checkValidRange(start, end, length);
    final size = end - start;
    final it = iterable.skip(skipCount).take(size);
    _allocate(sizeOf<JInt>() * size, (ptr) {
      it.forEachIndexed((index, element) {
        ptr[index] = element;
      });
      _env.SetIntArrayRegion(reference, start, size, ptr);
    });
  }
}

extension LongJniArray on JniArray<JLong> {
  int operator [](int index) {
    RangeError.checkValidIndex(index, this);
    return _env.GetLongArrayElements(reference, nullptr.cast<Uint8>())[index];
  }

  void operator []=(int index, int value) {
    RangeError.checkValidIndex(index, this);
    _allocate(sizeOf<JLong>(), (ptr) {
      ptr.value = value;
      _env.SetLongArrayRegion(reference, index, 1, ptr);
    });
  }

  void setRange(int start, int end, Iterable<int> iterable,
      [int skipCount = 0]) {
    RangeError.checkValidRange(start, end, length);
    final size = end - start;
    final it = iterable.skip(skipCount).take(size);
    _allocate(sizeOf<JLong>() * size, (ptr) {
      it.forEachIndexed((index, element) {
        ptr[index] = element;
      });
      _env.SetLongArrayRegion(reference, start, size, ptr);
    });
  }
}

extension FloatJniArray on JniArray<JFloat> {
  double operator [](int index) {
    RangeError.checkValidIndex(index, this);
    return _env.GetFloatArrayElements(reference, nullptr.cast<Uint8>())[index];
  }

  void operator []=(int index, double value) {
    RangeError.checkValidIndex(index, this);
    _allocate(sizeOf<JFloat>(), (ptr) {
      ptr.value = value;
      _env.SetFloatArrayRegion(reference, index, 1, ptr);
    });
  }

  void setRange(int start, int end, Iterable<double> iterable,
      [int skipCount = 0]) {
    RangeError.checkValidRange(start, end, length);
    final size = end - start;
    final it = iterable.skip(skipCount).take(size);
    _allocate(sizeOf<JFloat>() * size, (ptr) {
      it.forEachIndexed((index, element) {
        ptr[index] = element;
      });
      _env.SetFloatArrayRegion(reference, start, size, ptr);
    });
  }
}

extension DoubleJniArray on JniArray<JDouble> {
  double operator [](int index) {
    RangeError.checkValidIndex(index, this);
    return _env.GetDoubleArrayElements(reference, nullptr.cast<Uint8>())[index];
  }

  void operator []=(int index, double value) {
    RangeError.checkValidIndex(index, this);
    _allocate(sizeOf<JDouble>(), (ptr) {
      ptr.value = value;
      _env.SetDoubleArrayRegion(reference, index, 1, ptr);
    });
  }

  void setRange(int start, int end, Iterable<double> iterable,
      [int skipCount = 0]) {
    RangeError.checkValidRange(start, end, length);
    final size = end - start;
    final it = iterable.skip(skipCount).take(size);
    _allocate(sizeOf<JDouble>() * size, (ptr) {
      it.forEachIndexed((index, element) {
        ptr[index] = element;
      });
      _env.SetDoubleArrayRegion(reference, start, size, ptr);
    });
  }
}

extension TJniArray<T extends JniObject> on JniArray<T> {
  void operator []=(int index, T value) {
    RangeError.checkValidIndex(index, this);
    _env.SetObjectArrayElement(reference, index, value.reference);
  }

  void setRange(int start, int end, Iterable<T> iterable, [int skipCount = 0]) {
    RangeError.checkValidRange(start, end, length);
    final size = end - start;
    final it = iterable.skip(skipCount).take(size);
    it.forEachIndexed((index, element) {
      this[index] = element;
    });
  }
}

extension ObjectJniArray on JniArray<JniObject> {
  JniObject operator [](int index) {
    RangeError.checkValidIndex(index, this);
    return JniObject.fromRef(_env.GetObjectArrayElement(reference, index));
  }
}

extension ArrayJniArray<T> on JniArray<JniArray<T>> {
  JniArray<T> operator [](int index) {
    RangeError.checkValidIndex(index, this);
    return JniArray<T>.fromRef(_env.GetObjectArrayElement(reference, index));
  }
}

extension StringJniArray on JniArray<JniString> {
  JniString operator [](int index) {
    RangeError.checkValidIndex(index, this);
    return JniString.fromRef(_env.GetObjectArrayElement(reference, index));
  }
}
