// Copyright (c) 2023, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:ffi';
import 'dart:io';

import 'package:jni/jni.dart';
import 'package:test/test.dart';

// Mocking this type tree:
//   JObject
//      |  \
//      A   B
//     / \   \
//    C   D   E
//   /
//  F

class A extends JObject {
  A.fromRef(super.reference) : super.fromRef();
  @override
  JObjType<JObject> get $type => $AType();
}

class $AType extends JObjType<A> {
  @override
  A fromRef(Pointer<Void> ref) {
    return A.fromRef(ref);
  }

  @override
  String get signature => 'A';

  @override
  int get superCount => superType.superCount + 1;

  @override
  JObjType<JObject> get superType => JObject.type;
}

class B extends JObject {
  B.fromRef(super.reference) : super.fromRef();
  @override
  JObjType<JObject> get $type => $BType();
}

class $BType extends JObjType<B> {
  @override
  B fromRef(Pointer<Void> ref) {
    return B.fromRef(ref);
  }

  @override
  String get signature => 'B';

  @override
  int get superCount => superType.superCount + 1;

  @override
  JObjType<JObject> get superType => JObject.type;
}

class C extends A {
  C.fromRef(super.reference) : super.fromRef();

  @override
  JObjType<JObject> get $type => $CType();
}

class $CType extends JObjType<C> {
  @override
  C fromRef(Pointer<Void> ref) {
    return C.fromRef(ref);
  }

  @override
  String get signature => 'C';

  @override
  int get superCount => superType.superCount + 1;

  @override
  JObjType<JObject> get superType => $AType();
}

class D extends A {
  D.fromRef(super.reference) : super.fromRef();

  @override
  JObjType<JObject> get $type => $DType();
}

class $DType extends JObjType<D> {
  @override
  D fromRef(Pointer<Void> ref) {
    return D.fromRef(ref);
  }

  @override
  String get signature => 'D';

  @override
  int get superCount => superType.superCount + 1;

  @override
  JObjType<JObject> get superType => $AType();
}

class E extends B {
  E.fromRef(super.reference) : super.fromRef();

  @override
  JObjType<JObject> get $type => $EType();
}

class $EType extends JObjType<E> {
  @override
  E fromRef(Pointer<Void> ref) {
    return E.fromRef(ref);
  }

  @override
  String get signature => 'E';

  @override
  int get superCount => superType.superCount + 1;

  @override
  JObjType<JObject> get superType => $BType();
}

class F extends C {
  F.fromRef(super.reference) : super.fromRef();

  @override
  JObjType<JObject> get $type => $FType();
}

class $FType extends JObjType<F> {
  @override
  F fromRef(Pointer<Void> ref) {
    return F.fromRef(ref);
  }

  @override
  String get signature => 'F';

  @override
  int get superCount => superType.superCount + 1;

  @override
  JObjType<JObject> get superType => $CType();
}

void main() {
  if (!Platform.isAndroid) {
    try {
      Jni.spawn(dylibDir: "build/jni_libs", jvmOptions: ["-Xmx128m"]);
    } on JvmExistsException catch (_) {
      // TODO(#51): Support destroying and reinstantiating JVM.
    }
  }

  test('lowestCommonSuperType', () {
    expect(lowestCommonSuperType([JObject.type]), JObject.type);
    expect(lowestCommonSuperType([JString.type]), JString.type);
    expect(lowestCommonSuperType([JObject.type, JObject.type]), JObject.type);
    expect(lowestCommonSuperType([JString.type, JString.type]), JString.type);
    expect(lowestCommonSuperType([JString.type, JArray.type(JLong.type)]),
        JObject.type);
  });

  test('Mocked type tree', () {
    // As a reminder, this is how the type tree looks like:
    //   JObject
    //      |  \
    //      A   B
    //     / \   \
    //    C   D   E
    //   /
    //  F
    expect(lowestCommonSuperType([$AType(), $BType()]), isA<JObjectType>());
    expect(lowestCommonSuperType([$CType(), $BType()]), isA<JObjectType>());
    expect(lowestCommonSuperType([$FType(), $BType()]), isA<JObjectType>());
    expect(lowestCommonSuperType([$EType(), $CType(), $FType()]),
        isA<JObjectType>());

    expect(lowestCommonSuperType([$CType(), $DType()]), isA<JObjectType>());
    expect(lowestCommonSuperType([$FType(), $DType()]), isA<$AType>());
    expect(
        lowestCommonSuperType([$FType(), $CType(), $DType()]), isA<$AType>());

    expect(lowestCommonSuperType([$EType(), $BType()]), isA<$BType>());
    expect(lowestCommonSuperType([$BType(), $BType()]), isA<$BType>());
  });
}
