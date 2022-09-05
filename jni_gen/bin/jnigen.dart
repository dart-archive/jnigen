// Copyright (c) 2022, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:jnigen/jnigen.dart';

void main(List<String> args) async {
  final config = Config.parseArgs(args);
  await generateJniBindings(config);
}
