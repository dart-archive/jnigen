// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:math';

import 'package:ffigen/src/code_generator/writer.dart';
import 'package:ffigen/src/code_generator.dart';

import 'logging.dart';

final dummyWriter = Writer(
  lookUpBindings: [],
  ffiNativeBindings: [],
  noLookUpBindings: [],
  className: 'unused',
);

/// Find compound having [name] in [library].
Compound findCompound(library, String name) {
  final compound = library.bindings
      .firstWhere((element) => element.name == name) as Compound;
  _sanitizeVaLists(compound);
  return compound;
}

/// Filter out MethodVs and NewObjectVs
void _sanitizeVaLists(Compound compound) {
  final fields = compound.members;
  for (var field in fields) {
    if (field.type is PointerType && field.type.baseType is NativeFunc) {
      _sanitizeVaListArg((field.type.baseType as NativeFunc).type, field.name);
    }
  }
}

void _sanitizeVaListArg(FunctionType ft, String fieldName) {
  if (ft.parameters.isEmpty) return;
  final lastParam = ft.parameters.last.type.baseType.getCType(dummyWriter);
  if (lastParam == 'va_list' || lastParam == '__va_list_tag') {
    ft.parameters.last = Parameter(
      type: PointerType(NativeType(SupportedNativeType.Void)),
      name: '',
    );
    logger.info("sanitize: $fieldName");
  }
}
