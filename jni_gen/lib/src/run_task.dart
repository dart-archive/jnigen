import 'dart:convert';

import 'config/config.dart';
import 'elements/elements.dart';

Future<void> runTask(JniGenTask task) async {
  final input = await task.summarySource.getInputStream();
  final stream = JsonDecoder().bind(Utf8Decoder().bind(input));

  // ASK: Is it better to use stream.first? because there's supposed to be
  // one JSON list in summarizer output?

  await for (var json in stream) {
    final list = json as List;
    task.outputWriter
        .writeBindings(list.map((c) => ClassDecl.fromJson(c)), task.options);
  }
}
