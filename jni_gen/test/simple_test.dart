// Tests on generated code.
import 'dart:io';

import 'package:jni/jni.dart';
import 'package:path/path.dart' hide equals;

// ignore_for_file: avoid_relative_lib_imports
import 'simple_package/lib/dev/dart/simple_package.dart';
import 'simple_package//lib/dev/dart/pkg2.dart';

import 'package:test/test.dart';

final simplePackagePath = join('test', 'simple_package');
final javaPath = join(simplePackagePath, 'java');

void setupDylibsAndClasses() {
  Process.runSync('dart', ['run', 'jni:setup']);
  Process.runSync(
      'dart', ['run', 'jni:setup', '-S', join(simplePackagePath, 'src')]);
  Process.runSync('javac', ['dev/dart/simple_package/Example.java'],
      workingDirectory: javaPath);

  if (!Platform.isAndroid) {
    Jni.spawn(helperDir: 'build/jni_libs', classPath: [javaPath]);
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
    expect(C2.CONSTANT, equals(12));
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
