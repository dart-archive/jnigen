import 'dart:io';
import 'dart:convert';

import 'config/config.dart';
import 'elements/elements.dart';

Future<void> runTask(JniGenTask task) async {
  final input = await task.summarySource.getInputStream();
  final stream = JsonDecoder().bind(Utf8Decoder().bind(input));
  final json = await stream.single;
  if (json == null) {
    stderr.writeln('error: expected JSON element from summarizer.');
    return;
  }
  final list = json as List;
  task.outputWriter
      .writeBindings(list.map((c) => ClassDecl.fromJson(c)), task.options);
}
