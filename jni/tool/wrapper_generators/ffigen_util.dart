// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

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
Compound findCompoundSanitized(library, String name) {
  final compound = library.bindings
      .firstWhere((element) => element.name == name) as Compound;
  sanitizeVaLists(compound);
  return compound;
}

/// Filter out MethodVs and NewObjectVs: because they give different output
/// on Windows and Linux.
void sanitizeVaLists(Compound compound) {
  final fields = compound.members;
  for (var field in fields) {
    if (field.type is PointerType &&
        field.type.baseType is NativeFunc &&
        (field.name.endsWith('MethodV') || field.name.endsWith('ObjectV'))) {
      _sanitizeVaListArg((field.type.baseType as NativeFunc).type, field.name);
    }
  }
}

void _sanitizeVaListArg(FunctionType ft, String fieldName) {
  ft.parameters.last = Parameter(
    type: PointerType(NativeType(SupportedNativeType.Void)),
    name: '',
  );
  logger.fine("sanitize va_list method: $fieldName");
}
