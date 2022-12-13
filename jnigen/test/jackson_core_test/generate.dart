// Copyright (c) 2022, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:jnigen/jnigen.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' hide equals;

const jacksonPreamble = '// Generated from jackson-core which is licensed under'
    ' the Apache License 2.0.\n'
    '// The following copyright from the original authors applies.\n'
    '// See https://github.com/FasterXML/jackson-core/blob/2.14/LICENSE\n'
    '//\n'
    '// Copyright (c) 2007 - The Jackson Project Authors\n'
    '// Licensed under the Apache License, Version 2.0 (the "License")\n'
    '// you may not use this file except in compliance with the License.\n'
    '// You may obtain a copy of the License at\n'
    '//\n'
    '//     http://www.apache.org/licenses/LICENSE-2.0\n'
    '//\n'
    '// Unless required by applicable law or agreed to in writing, software\n'
    '// distributed under the License is distributed on an "AS IS" BASIS,\n'
    '// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.\n'
    '// See the License for the specific language governing permissions and\n'
    '// limitations under the License.\n';

const testName = 'jackson_core_test';
final thirdPartyDir = join('test', testName, 'third_party');
const deps = ['com.fasterxml.jackson.core:jackson-core:2.13.4'];

Config getConfig(
    {String? root, bool generateFullVersion = false, bool useAsm = false}) {
  final rootDir = root ?? thirdPartyDir;
  final config = Config(
    mavenDownloads: MavenDownloads(
      sourceDeps: deps,
      sourceDir: join(thirdPartyDir, 'java'),
      jarDir: join(thirdPartyDir, 'jar'),
    ),
    summarizerOptions: SummarizerOptions(
      backend: useAsm ? 'asm' : null,
    ),
    preamble: jacksonPreamble,
    outputConfig: OutputConfig(
      bindingsType: BindingsType.dartOnly,
      dartConfig: DartCodeOutputConfig(
        path: Uri.directory(join(rootDir, 'lib')),
      ),
    ),
    classes: (generateFullVersion)
        ? ['com.fasterxml.jackson.core']
        : [
            'com.fasterxml.jackson.core.JsonFactory',
            'com.fasterxml.jackson.core.JsonParser',
            'com.fasterxml.jackson.core.JsonToken',
          ],
    logLevel: Level.INFO,
    exclude: BindingExclusions(
        fields: excludeAll<Field>([
          ['com.fasterxml.jackson.core.JsonFactory', 'DEFAULT_QUOTE_CHAR'],
          ['com.fasterxml.jackson.core.Base64Variant', 'PADDING_CHAR_NONE'],
          ['com.fasterxml.jackson.core.base.ParserMinimalBase', 'CHAR_NULL'],
          ['com.fasterxml.jackson.core.io.UTF32Reader', 'NC'],
        ]),
        // TODO(#159): Remove class exclusions.
        classes: ClassNameFilter.exclude(
          'com.fasterxml.jackson.core.JsonFactoryBuilder',
        )),
  );
  return config;
}

void main() async => await generateJniBindings(getConfig());
