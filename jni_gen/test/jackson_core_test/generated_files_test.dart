import 'dart:io';

import 'package:path/path.dart' hide equals;
import 'package:test/test.dart';

import '../test_util/test_util.dart';
import 'generate.dart';

const testName = 'jackson_core_test';

void main() async {
  await generate(isTest: true);
  test("compare generated bindings for jackson_core", () {
    compareFiles(testName, 'lib');
    compareFiles(testName, 'src');
  });
  test(
      'generate and analyze bindings for complete library, '
      'not just required classes', () async {
    await generate(isTest: true, generateFullVersion: true);
    final analyzeProc = await Process.start(
        'dart', ['analyze', join('test', testName, 'test_lib')],
        mode: ProcessStartMode.inheritStdio);
    final exitCode = await analyzeProc.exitCode;
    expect(exitCode, 0);
  });
  tearDownAll(() async {
    for (var dirName in ['test_lib', 'test_src']) {
      final dir = Directory(join('test', testName, dirName));
      if (await dir.exists()) {
        await dir.delete(recursive: true);
      }
    }
  });
}
