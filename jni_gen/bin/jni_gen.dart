// Copyright (c) 2022, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:jni_gen/src/config/config.dart';

void main(List<String> args) async => await JniGenTask.parseArgs(args).run();
