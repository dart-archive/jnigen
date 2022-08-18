import 'dart:io';
import 'dart:convert';

import 'config/config.dart';
import 'elements/elements.dart';

Future<void> runTask(JniGenTask task) async {
  Stream<List<int>> input;
  try {
    input = await task.summarySource.getInputStream();
  } on Exception catch (e) {
    stderr.writeln('error obtaining API summary: $e');
    return;
  }
  final stream = JsonDecoder().bind(Utf8Decoder().bind(input));
  dynamic json;
  try {
    json = await stream.single;
  } on Exception catch (e) {
    stderr.writeln('error parsing summary: $e');
    return;
  }
  if (json == null) {
    stderr.writeln('error: expected JSON element from summarizer.');
    return;
  }
  final list = json as List;
  try {
    await task.outputWriter
        .writeBindings(list.map((c) => ClassDecl.fromJson(c)), task.options);
  } on Exception catch (e, trace) {
    stderr.writeln(trace);
    stderr.writeln('error writing bindings: $e');
  }
}
