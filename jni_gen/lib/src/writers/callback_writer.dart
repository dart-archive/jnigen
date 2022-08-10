import 'package:jni_gen/src/elements/elements.dart';
import 'package:jni_gen/src/config/wrapper_options.dart';

import 'bindings_writer.dart';

// mostly for debugging purposes

class CallbackWriter extends BindingsWriter {
  CallbackWriter(this.callback);
  Future<void> Function(Iterable<ClassDecl>, WrapperOptions) callback;

  @override
  Future<void> writeBindings(
      Iterable<ClassDecl> classes, WrapperOptions options) async {
    callback(classes, options);
  }
}
