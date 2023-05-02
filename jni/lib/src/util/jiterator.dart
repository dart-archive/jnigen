// Copyright (c) 2023, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// ignore_for_file: overridden_fields

import '../accessors.dart';
import '../jni.dart';
import '../jobject.dart';
import '../third_party/generated_bindings.dart';
import '../types.dart';

class JIteratorType<$E extends JObject> extends JObjType<JIterator<$E>> {
  final JObjType<$E> E;

  const JIteratorType(
    this.E,
  );

  @override
  String get signature => r"Ljava/util/Iterator;";

  @override
  JIterator<$E> fromRef(JObjectPtr ref) => JIterator.fromRef(E, ref);

  @override
  JObjType get superType => const JObjectType();

  @override
  final superCount = 1;

  @override
  int get hashCode => Object.hash(JIteratorType, E);

  @override
  bool operator ==(Object other) {
    return other.runtimeType == JIteratorType &&
        other is JIteratorType &&
        E == other.E;
  }
}

class JIterator<$E extends JObject> extends JObject implements Iterator<$E> {
  @override
  late final JObjType $type = type(E);

  final JObjType<$E> E;

  JIterator.fromRef(
    this.E,
    JObjectPtr ref,
  ) : super.fromRef(ref);

  static final _classRef = Jni.accessors.getClassOf(r"java/util/Iterator");

  /// The type which includes information such as the signature of this class.
  static JIteratorType<$E> type<$E extends JObject>(
    JObjType<$E> E,
  ) {
    return JIteratorType(
      E,
    );
  }

  $E? _current;

  @override
  $E get current => _current as $E;

  static final _hasNextId =
      Jni.accessors.getMethodIDOf(_classRef, r"hasNext", r"()Z");
  bool _hasNext() {
    return Jni.accessors.callMethodWithArgs(
        reference, _hasNextId, JniCallType.booleanType, []).boolean;
  }

  static final _nextId =
      Jni.accessors.getMethodIDOf(_classRef, r"next", r"()Ljava/lang/Object;");
  $E _next() {
    return E.fromRef(Jni.accessors.callMethodWithArgs(
        reference, _nextId, JniCallType.objectType, []).object);
  }

  @override
  bool moveNext() {
    if (!_hasNext()) {
      return false;
    }
    _current = _next();
    return true;
  }
}
