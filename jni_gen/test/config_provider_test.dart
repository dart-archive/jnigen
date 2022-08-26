// Copyright (c) 2022, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:jni_gen/src/config/config_provider.dart';
import 'package:test/test.dart';
import 'package:path/path.dart' hide equals;

void main() {
  final config = ConfigProvider.parseArgs([
    '--config',
    join('test', 'test_data', 'test_config.yaml'),
    '-Dsummarizer.use_asm=true',
    '--override c_root=src/third_party',
  ], allowYamlConfig: true);
  test('getBool', () {
    expect(config.getBool('summarizer.use_asm'), isTrue);
    expect(config.getBool('summarizer.bad_config'), isNull);
  });

  test('getString', () {
    expect(config.getString('library_name'), equals('abc'));
    expect(config.getString('preamble'), 'a\nb\n');
    expect(config.getString('maven_downloads.source_dir'), equals('.tmp/java'));
    expect(config.getString('summarizer.bad_config'), isNull);
    expect(config.getString('c_root'), equals('src/third_party'));
  });

  test('getStringList', () {
    expect(config.getStringList('summarizer.classes'),
        equals(['a.b.c', 'x.y.z', 'p.q.r']));
  });
  test('hasValue', () {
    expect(config.hasValue('summarizer'), isTrue);
    expect(config.hasValue('android_sdk_config'), isFalse);
  });
  test('getOneOf', () {
    expect(config.getOneOf('summarizer.log_level', {'info', 'warn', 'error'}),
        equals('warn'));
    expect(
        () =>
            config.getOneOf('summarizer.log_level', {'debug', 'info', 'error'}),
        throwsA(isA<ConfigError>()));
  });
}
