import 'dart:convert';

Stream<String> commandOutputStream(
        String Function(String) lineMapper, Stream<List<int>> input) =>
    input.transform(Utf8Decoder()).transform(LineSplitter()).map(lineMapper);

Stream<String> prefixedCommandOutputStream(
        String prefix, Stream<List<int>> input) =>
    commandOutputStream((line) => '$prefix $line', input);
