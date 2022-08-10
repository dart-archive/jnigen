import 'package:jni_gen/src/writers/bindings_writer.dart';
import 'summary_source.dart';
import 'wrapper_options.dart';

class JniGenTask {
  JniGenTask({
    required this.outputWriter,
    this.options = const WrapperOptions(),
    required this.summarySource,
  });
  BindingsWriter outputWriter;
  SummarySource summarySource;
  WrapperOptions options;
}
