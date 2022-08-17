import 'dart:io';
import 'package:path/path.dart' hide equals;
import 'package:test/test.dart';

import 'test_util/generate_files.dart';

void compareFiles(String path) {
  expect(File(join(simplePackagePath, path)).readAsStringSync(),
      equals(File(join(simplePackagePath, 'test_$path')).readAsStringSync()));
}

void main() async {
  await generateSources('test_lib', 'test_src');
  // test if generated file == expected file
  test('compare generated files', () {
    compareFiles(join('lib', 'init.dart'));
    compareFiles(join('lib', 'dev', 'dart', 'simple_package.dart'));
    compareFiles(join('src', 'CMakeLists.txt'));
    compareFiles(join('src', 'simple_package.c'));
    compareFiles(join('src', 'dartjni.h'));
  });
}
