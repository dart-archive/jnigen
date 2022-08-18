import 'package:test/test.dart';

import '../test_util/test_util.dart';
import 'generate.dart';

void main() async {
  await generate(isTest: true);
  test("compare generated bindings for jackson_core", () {
    compareFiles('jackson_core_test', 'lib');
    compareFiles('jackson_core_test', 'src');
  });
}
