// Copyright (c) 2022, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Tests on generated code.
//
// Both the simple java example & jackson core classes example have tests in
// same file, because the test runner will reuse the process, which leads to
// reuse of the old JVM with old classpath if we have separate tests with
// different classpaths.

import 'dart:io';

import 'package:jni/jni.dart';
import 'package:path/path.dart' hide equals;
import 'package:test/test.dart';

// ignore_for_file: avoid_relative_lib_imports
import 'simple_package_test/lib/simple_package.dart';
import 'jackson_core_test/third_party/lib/com/fasterxml/jackson/core/_package.dart';

import 'test_util/test_util.dart';

final simplePackageTest = join('test', 'simple_package_test');
final jacksonCoreTest = join('test', 'jackson_core_test');
final simplePackageTestJava = join(simplePackageTest, 'java');

Future<void> setupDylibsAndClasses() async {
  await runCommand('dart', [
    'run',
    'jni:setup',
    '-p',
    'jni',
    '-s',
    join(simplePackageTest, 'src'),
  ]);
  final group = join('com', 'github', 'dart_lang', 'jnigen');
  await runCommand(
      'javac',
      [
        join(group, 'simple_package', 'Example.java'),
        join(group, 'pkg2', 'C2.java'),
        join(group, 'pkg2', 'Example.java'),
      ],
      workingDirectory: simplePackageTestJava);
  await runCommand('dart', [
    'run',
    'jnigen:download_maven_jars',
    '--config',
    join(jacksonCoreTest, 'jnigen.yaml')
  ]);

  final jacksonJars = await getJarPaths(join(jacksonCoreTest, 'third_party'));

  if (!Platform.isAndroid) {
    Jni.spawn(
        dylibDir: join('build', 'jni_libs'),
        classPath: [simplePackageTestJava, ...jacksonJars]);
  }
}

void main() async {
  await setupDylibsAndClasses();

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

  test('static methods arrays', () {
    final array = Example.getArr();
    expect(array[0], 1);
    expect(array[1], 2);
    expect(array[2], 3);
    expect(Example.addAll(array), 6);
    array[0] = 4;
    expect(Example.addAll(array), 9);
  });

  test('instance methods', () {
    final ex = Example();
    expect(ex.getNum(), equals(Example.num));
    final aux = Example.getAux();
    expect(aux.getValue(), equals(true));
    aux.setValue(false);
    expect(aux.getValue(), equals(false));
    aux.setValue(true);
    aux.delete();
    ex.delete();
  });

  test('array of the class', () {
    final ex1 = Example();
    final ex2 = Example();
    ex1.setInternal(1);
    ex2.setInternal(2);
    final array = JArray(Example.type, 2);
    array[0] = ex1;
    array[1] = ex2;
    print(array[0].getInternal());
    expect(array[0].getInternal(), 1);
    expect(array[1].getInternal(), 2);
    array.delete();
    ex1.delete();
    ex2.delete();
  });

  test("Check bindings for same-named classes", () {
    expect(Example().whichExample(), 0);
    expect(Example1().whichExample(), 1);
  });

  test('simple json parsing test', () {
    final json = JString.fromString('[1, true, false, 2, 4]');
    JsonFactory factory;
    factory = JsonFactory();
    final parser = factory.createParser6(json);
    final values = <bool>[];
    while (!parser.isClosed()) {
      final next = parser.nextToken();
      if (next.isNull) continue;
      values.add(next.isNumeric());
      next.delete();
    }
    expect(values, equals([false, true, false, false, true, true, false]));
    Jni.deleteAll([factory, parser, json]);
  });
  test("parsing invalid JSON throws JniException", () {
    using((arena) {
      final factory = JsonFactory()..deletedIn(arena);
      final erroneous = factory
          .createParser6("<html>".toJString()..deletedIn(arena))
        ..deletedIn(arena);
      expect(() => erroneous.nextToken(), throwsA(isA<JniException>()));
    });
  });
  test('exceptions', () {
    expect(() => Example.throwException(), throwsException);
  });
  group('generics', () {
    test('MyStack<T>', () {
      using((arena) {
        final stack = MyStack(JString.type)..deletedIn(arena);
        stack.push('Hello'.toJString()..deletedIn(arena));
        stack.push('World'.toJString()..deletedIn(arena));
        expect(stack.pop().toDartString(deleteOriginal: true), 'World');
        expect(stack.pop().toDartString(deleteOriginal: true), 'Hello');
      });
    });
    test('MyMap<K, V>', () {
      using((arena) {
        final map = MyMap(JString.type, Example.type)..deletedIn(arena);
        final helloExample = Example()
          ..setInternal(1)
          ..deletedIn(arena);
        final worldExample = Example()
          ..setInternal(2)
          ..deletedIn(arena);
        map.put('Hello'.toJString()..deletedIn(arena), helloExample);
        map.put('World'.toJString()..deletedIn(arena), worldExample);
        expect(
          (map.get0('Hello'.toJString()..deletedIn(arena))..deletedIn(arena))
              .getInternal(),
          1,
        );
        expect(
          (map.get0('World'.toJString()..deletedIn(arena))..deletedIn(arena))
              .getInternal(),
          2,
        );
        expect((map.entryArray()..deletedIn(arena)).length, 2);
        expect(
          (map.entryArray()..deletedIn(arena))[0]
              .key
              .toDartString(deleteOriginal: true),
          anyOf('Hello', 'World'),
        );
      });
    });
  });
}
