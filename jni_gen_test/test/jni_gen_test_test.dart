import 'dart:io';

import 'package:jni/jni.dart';

import 'package:jni_gen_test/dev/dart/jni_gen_test.dart';
import 'package:test/test.dart';

void main() {
  if (!Platform.isAndroid) {
    Jni.spawn(helperDir: 'build/jni_libs', classPath: ['java/']);
  }

  test('static final fields', () {
    expect(Example.ON, equals(1));
    expect(Example.OFF, equals(0));
  });

  test('static & instance fields', () {
    expect(Example.num, equals(121));

    final aux = Example.aux;
    expect(aux.value, equals(true));
    aux.delete();
  });

  test('static methods', () {
    expect(Example.addInts(10, 15), equals(25));
  });

  test('instance methods', () {
    final ex = Example();
    expect(ex.getNum(), equals(Example.num));
    final aux = Example.getAux();
    expect(aux.getValue(), equals(true));
    aux.setValue(false);
    expect(aux.getValue(), equals(false));
    aux.delete();
    ex.delete();
  });
}
