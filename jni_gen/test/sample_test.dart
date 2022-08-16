// Tests on generated code.
import 'dart:io';

import 'package:jni/jni.dart';
import 'package:path/path.dart' hide equals;

// ignore_for_file: avoid_relative_lib_imports
import 'sample/lib/dev/dart/sample.dart';
import 'package:test/test.dart';

final samplePath = join('test', 'sample');
final javaPath = join(samplePath, 'java');

void setupDylibsAndClasses() {
  Process.runSync('dart', ['run', 'jni:setup']);
  Process.runSync('dart', ['run', 'jni:setup', '-S', 'test/sample/src']);
  Process.runSync('javac', ['dev/dart/sample/Example.java'],
      workingDirectory: javaPath);

  if (!Platform.isAndroid) {
    Jni.spawn(helperDir: 'build/jni_libs', classPath: ['test/sample/java/']);
  }
}

void main() {
  setupDylibsAndClasses();

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
