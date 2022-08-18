import 'package:jni_gen/jni_gen.dart';
import '../test_util/test_util.dart';

Future<void> generate({bool isTest = false}) async {
  final deps = ['com.fasterxml.jackson.core:jackson-core:2.13.3'];
  await generateBindings(
    testName: 'jackson_core_test',
    sourceDepNames: deps,
    jarDepNames: deps,
    classes: [
      'com.fasterxml.jackson.core.JsonFactory',
      'com.fasterxml.jackson.core.JsonParser',
      'com.fasterxml.jackson.core.JsonToken',
    ],
    isGeneratedFileTest: isTest,
    options: WrapperOptions(
        fieldFilter: CombinedFieldFilter([
          excludeAll<Field>([
            ['com.fasterxml.jackson.core.JsonFactory', 'DEFAULT_QUOTE_CHAR']
          ]),
          CustomFieldFilter((decl, field) => !field.name.startsWith("_")),
        ]),
        methodFilter:
            CustomMethodFilter((decl, method) => !method.name.startsWith('_'))),
  );
}

void main() => generate(isTest: false);
