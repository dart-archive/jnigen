// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:logging/logging.dart';

final logger = () {
  hierarchicalLoggingEnabled = true;
  final logger = Logger('ffi_wrappers_generator');
  Logger.root.level = Level.INFO; // defaults to Level.INFO
  Logger.root.onRecord.listen((record) {
    stderr.writeln('${record.level.name}: ${record.message}');
  });
  return logger;
}();
