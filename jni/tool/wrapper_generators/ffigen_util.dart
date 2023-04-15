// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:ffigen/src/code_generator/writer.dart';
import 'package:ffigen/src/code_generator.dart';

final dummyWriter = Writer(
  lookUpBindings: [],
  ffiNativeBindings: [],
  noLookUpBindings: [],
  className: 'unused',
);

/// Find compound having [name] in [library].
Compound findCompound(library, String name) {
  return library.bindings.firstWhere((element) => element.name == name)
      as Compound;
}
