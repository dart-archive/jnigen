import 'dart:convert';

Stream<String> commandOutputStream(
    String Function(String) lineMapper, Stream<List<int>> input) {
  return input
      .transform(Utf8Decoder())
      .transform(LineSplitter())
      .map(lineMapper);
}
