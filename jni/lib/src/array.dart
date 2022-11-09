// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// ignore_for_file: unnecessary_cast

part of 'types.dart';

class _JArrayType<T> extends JType<JArray<T>> {
  final JType<T> elementType;

  const _JArrayType(this.elementType);

  @override
  String get signature => '[${elementType.signature}';
}

class JArray<E> extends JObject {
  /// The type which includes information such as the signature of this class.
  static JType<JArray<T>> type<T>(JType<T> innerType) => _JArrayType(innerType);

  /// Construct a new [JArray] with [reference] as its underlying reference.
  JArray.fromRef(JArrayPtr reference) : super.fromRef(reference);

  JArray(JType<E> typeClass, int length)
      : super.fromRef(
          (typeClass._type == JniCallType.objectType)
              ? _accessors
                  .newObjectArray(
                      length, typeClass._getClass().reference, nullptr)
                  .checkedRef
              : _accessors
                  .newPrimitiveArray(length, typeClass._type)
                  .checkedRef,
        );

  int? _length;

  JniResult elementAt(int index, int type) {
    RangeError.checkValidIndex(index, this);
    return _accessors.getArrayElement(reference, index, type);
  }

  /// The number of elements in this array.
  int get length {
    return _length ??= _env.GetArrayLength(reference);
  }
}

extension NativeJArray<E extends JPrimitive> on JArray<E> {
  void _allocate<T extends NativeType>(
    int size,
    void Function(Pointer<T> ptr) use,
  ) {
    using((arena) {
      final ptr = arena.allocate<T>(size);
      use(ptr);
    }, malloc);
  }
}

extension BoolJArray on JArray<JBoolean> {
  bool operator [](int index) {
    return elementAt(index, JniCallType.booleanType).boolean;
  }

  void operator []=(int index, bool value) {
    RangeError.checkValidIndex(index, this);
    _allocate<JBooleanMarker>(sizeOf<JBooleanMarker>(), (ptr) {
      ptr.value = value ? 1 : 0;
      _env.SetBooleanArrayRegion(reference, index, 1, ptr);
    });
  }

  void setRange(int start, int end, Iterable<bool> iterable,
      [int skipCount = 0]) {
    RangeError.checkValidRange(start, end, length);
    final size = end - start;
    final it = iterable.skip(skipCount).take(size);
    _allocate<JBooleanMarker>(sizeOf<JBooleanMarker>() * size, (ptr) {
      it.forEachIndexed((index, element) {
        ptr[index] = element ? 1 : 0;
      });
      _env.SetBooleanArrayRegion(reference, start, size, ptr);
    });
  }
}

extension ByteJArray on JArray<JByte> {
  int operator [](int index) {
    return elementAt(index, JniCallType.byteType).byte;
  }

  void operator []=(int index, int value) {
    RangeError.checkValidIndex(index, this);
    _allocate<JByteMarker>(sizeOf<JByteMarker>(), (ptr) {
      ptr.value = value;
      _env.SetByteArrayRegion(reference, index, 1, ptr);
    });
  }

  void setRange(int start, int end, Iterable<int> iterable,
      [int skipCount = 0]) {
    RangeError.checkValidRange(start, end, length);
    final size = end - start;
    final it = iterable.skip(skipCount).take(size);
    _allocate<JByteMarker>(sizeOf<JByteMarker>() * size, (ptr) {
      it.forEachIndexed((index, element) {
        ptr[index] = element;
      });
      _env.SetByteArrayRegion(reference, start, size, ptr);
    });
  }
}

extension CharJArray on JArray<JChar> {
  String operator [](int index) {
    return String.fromCharCode(
      elementAt(index, JniCallType.charType).char,
    );
  }

  void operator []=(int index, String value) {
    RangeError.checkValidIndex(index, this);
    _allocate<JCharMarker>(sizeOf<JCharMarker>(), (ptr) {
      ptr.value = value.codeUnits.first;
      _env.SetCharArrayRegion(reference, index, 1, ptr);
    });
  }

  void setRange(int start, int end, Iterable<String> iterable,
      [int skipCount = 0]) {
    RangeError.checkValidRange(start, end, length);
    final size = end - start;
    final it = iterable.skip(skipCount).take(size);
    _allocate<JCharMarker>(sizeOf<JCharMarker>() * size, (ptr) {
      it.forEachIndexed((index, element) {
        ptr[index] = element.codeUnits.first;
      });
      _env.SetCharArrayRegion(reference, start, size, ptr);
    });
  }
}

extension ShortJArray on JArray<JShort> {
  int operator [](int index) {
    return elementAt(index, JniCallType.shortType).short;
  }

  void operator []=(int index, int value) {
    RangeError.checkValidIndex(index, this);
    _allocate<JShortMarker>(sizeOf<JShortMarker>(), (ptr) {
      ptr.value = value;
      _env.SetShortArrayRegion(reference, index, 1, ptr);
    });
  }

  void setRange(int start, int end, Iterable<int> iterable,
      [int skipCount = 0]) {
    RangeError.checkValidRange(start, end, length);
    final size = end - start;
    final it = iterable.skip(skipCount).take(size);
    _allocate<JShortMarker>(sizeOf<JShortMarker>() * size, (ptr) {
      it.forEachIndexed((index, element) {
        ptr[index] = element;
      });
      _env.SetShortArrayRegion(reference, start, size, ptr);
    });
  }
}

extension IntJArray on JArray<JInt> {
  int operator [](int index) {
    return elementAt(index, JniCallType.intType).integer;
  }

  void operator []=(int index, int value) {
    RangeError.checkValidIndex(index, this);
    _allocate<JIntMarker>(sizeOf<JIntMarker>(), (ptr) {
      ptr.value = value;
      _env.SetIntArrayRegion(reference, index, 1, ptr);
    });
  }

  void setRange(int start, int end, Iterable<int> iterable,
      [int skipCount = 0]) {
    RangeError.checkValidRange(start, end, length);
    final size = end - start;
    final it = iterable.skip(skipCount).take(size);
    _allocate<JIntMarker>(sizeOf<JIntMarker>() * size, (ptr) {
      it.forEachIndexed((index, element) {
        ptr[index] = element;
      });
      _env.SetIntArrayRegion(reference, start, size, ptr);
    });
  }
}

extension LongJArray on JArray<JLong> {
  int operator [](int index) {
    return elementAt(index, JniCallType.longType).long;
  }

  void operator []=(int index, int value) {
    RangeError.checkValidIndex(index, this);
    _allocate<JLongMarker>(sizeOf<JLongMarker>(), (ptr) {
      ptr.value = value;
      _env.SetLongArrayRegion(reference, index, 1, ptr);
    });
  }

  void setRange(int start, int end, Iterable<int> iterable,
      [int skipCount = 0]) {
    RangeError.checkValidRange(start, end, length);
    final size = end - start;
    final it = iterable.skip(skipCount).take(size);
    _allocate<JLongMarker>(sizeOf<JLongMarker>() * size, (ptr) {
      it.forEachIndexed((index, element) {
        ptr[index] = element;
      });
      _env.SetLongArrayRegion(reference, start, size, ptr);
    });
  }
}

extension FloatJArray on JArray<JFloat> {
  double operator [](int index) {
    return elementAt(index, JniCallType.floatType).float;
  }

  void operator []=(int index, double value) {
    RangeError.checkValidIndex(index, this);
    _allocate<JFloatMarker>(sizeOf<JFloatMarker>(), (ptr) {
      ptr.value = value;
      _env.SetFloatArrayRegion(reference, index, 1, ptr);
    });
  }

  void setRange(int start, int end, Iterable<double> iterable,
      [int skipCount = 0]) {
    RangeError.checkValidRange(start, end, length);
    final size = end - start;
    final it = iterable.skip(skipCount).take(size);
    _allocate<JFloatMarker>(sizeOf<JFloatMarker>() * size, (ptr) {
      it.forEachIndexed((index, element) {
        ptr[index] = element;
      });
      _env.SetFloatArrayRegion(reference, start, size, ptr);
    });
  }
}

extension DoubleJArray on JArray<JDouble> {
  double operator [](int index) {
    return elementAt(index, JniCallType.doubleType).doubleFloat;
  }

  void operator []=(int index, double value) {
    RangeError.checkValidIndex(index, this);
    _allocate<JDoubleMarker>(sizeOf<JDoubleMarker>(), (ptr) {
      ptr.value = value;
      _env.SetDoubleArrayRegion(reference, index, 1, ptr);
    });
  }

  void setRange(int start, int end, Iterable<double> iterable,
      [int skipCount = 0]) {
    RangeError.checkValidRange(start, end, length);
    final size = end - start;
    final it = iterable.skip(skipCount).take(size);
    _allocate<JDoubleMarker>(sizeOf<JDoubleMarker>() * size, (ptr) {
      it.forEachIndexed((index, element) {
        ptr[index] = element;
      });
      _env.SetDoubleArrayRegion(reference, start, size, ptr);
    });
  }
}

extension ObjectJArray<T extends JObject> on JArray<T> {
  JObject operator [](int index) {
    return JObject.fromRef(elementAt(index, JniCallType.objectType).object);
  }

  void operator []=(int index, JObject value) {
    RangeError.checkValidIndex(index, this);
    _env.SetObjectArrayElement(reference, index, value.reference);
  }

  void setRange(int start, int end, Iterable<JObject> iterable,
      [int skipCount = 0]) {
    RangeError.checkValidRange(start, end, length);
    final size = end - start;
    final it = iterable.skip(skipCount).take(size);
    it.forEachIndexed((index, element) {
      this[index] = element;
    });
  }
}

extension ArrayJArray<T> on JArray<JArray<T>> {
  JArray<T> operator [](int index) {
    return JArray<T>.fromRef(elementAt(index, JniCallType.objectType).object);
  }

  void operator []=(int index, JArray<T> value) {
    (this as JArray<JObject>)[index] = value;
  }
}

extension StringJArray on JArray<JString> {
  JString operator [](int index) {
    return JString.fromRef(elementAt(index, JniCallType.objectType).object);
  }

  void operator []=(int index, JString value) {
    (this as JArray<JObject>)[index] = value;
  }
}
