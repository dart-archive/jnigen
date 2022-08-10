import 'package:jni_gen/src/elements/elements.dart';
import 'package:jni_gen/src/config/wrapper_options.dart';

abstract class BindingsWriter {
  Future<void> writeBindings(
      Iterable<ClassDecl> classes, WrapperOptions options);
}
