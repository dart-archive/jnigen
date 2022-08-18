import 'package:test/test.dart';

import 'generate.dart';
import '../test_util/test_util.dart';

void main() async {
  await generateSources('test_lib', 'test_src');
  // test if generated file == expected file
  test('compare generated files', () {
    compareFiles(testName, 'lib');
    compareFiles(testName, 'src');
  });
}
