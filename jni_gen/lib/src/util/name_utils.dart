import 'package:jni_gen/src/elements/elements.dart';

String getPackageName(String binaryName) => cutFromLast(binaryName, '.')[0];

List<String> cutFromLast(String str, String sep) {
  final li = str.lastIndexOf(sep);
  if (li == -1) {
    return ['', str];
  }
  return [str.substring(0, li), str.substring(li + 1)];
}

String getSimpleName(String binaryName) => binaryName.split('.').last;

String getSimpleNameOf(ClassDecl cls) => cls.simpleName;

// Eg -> a.b.X.Y -> X_Y
String simplifiedClassName(String binaryName) =>
    getSimpleName(binaryName).replaceAll('\$', '_');

// Utilities to operate on package names
List<String> getComponents(String packageName) => packageName.split('.');

String getLastName(String packageName) => cutFromLast(packageName, '.')[1];
