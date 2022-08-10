import 'package:jni_gen/src/writers/bindings_writer.dart';
import 'summary_source.dart';
import 'wrapper_options.dart';

/// Represents a complete jni_gen binding generation configuration.
/// * [summarySource] handles the API summary generation.
/// * [options] specify any semantic options regarding generated code.
/// * [outputWriter] handles the output configuration.
class JniGenTask {
  JniGenTask({
    required this.summarySource,
    this.options = const WrapperOptions(),
    required this.outputWriter,
  });
  BindingsWriter outputWriter;
  SummarySource summarySource;
  WrapperOptions options;
}
