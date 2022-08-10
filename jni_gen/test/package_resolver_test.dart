import 'package:jni_gen/src/bindings/symbol_resolver.dart';
import 'package:jni_gen/src/util/name_utils.dart';
import 'package:test/test.dart';

class ResolverTest {
  ResolverTest(this.binaryName, this.expectedImport, this.expectedName);
  String binaryName;
  String expectedImport;
  String expectedName;
}

void main() {
  final resolver = PackagePathResolver(
      {
        'org.apache.pdfbox': 'package:pdfbox',
        'org.apache.fontbox': 'package:fontbox',
        'java.lang': 'package:java_lang',
        'java.util': 'package:java_util',
        'org.me.package': 'package:my_package/src/',
      },
      'a.b',
      {'a.b.C', 'a.b.c.D', 'a.b.c.d.E'});

  final tests = [
    // Simple example
    ResolverTest('org.apache.pdfbox.PDF',
        'package:pdfbox/org/apache/pdfbox.dart', 'pdfbox.PDF'),
    // Nested classes
    ResolverTest('org.apache.fontbox.Font\$FontFile',
        'package:fontbox/org/apache/fontbox.dart', 'fontbox.Font_FontFile'),
    // slightly deeper package
    ResolverTest('java.lang.ref.WeakReference',
        'package:java_lang/java/lang/ref.dart', 'ref.WeakReference'),
    // Renaming
    ResolverTest('java.util.U', 'package:java_util/java/util.dart', 'util.U'),
    ResolverTest('org.me.package.util.U',
        'package:my_package/src/org/me/package/util.dart', 'util1.U'),
    // Relative imports
    ResolverTest('a.b.c.D', 'b/c.dart', 'c.D'),
    ResolverTest('a.b.c.d.E', 'b/c/d.dart', 'd.E'),
  ];

  for (var testCase in tests) {
    final binaryName = testCase.binaryName;
    final packageName = cutFromLast(binaryName, '.')[0];
    test(
        'getImport $binaryName',
        () => expect(resolver.getImport(packageName, binaryName),
            equals(testCase.expectedImport)));
    test(
        'resolve $binaryName',
        () => expect(
            resolver.resolve(binaryName), equals(testCase.expectedName)));
  }
  test('resolve in same package',
      () => expect(resolver.resolve('a.b.C'), equals('C')));
}
