// Copyright (c) 2023, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:jnigen/jnigen.dart';

import 'visitor.dart';

class CGenerator {}

class CFieldName extends Visitor<Field, String> {
  const CFieldName();

  @override
  String visit(Field node) {
    final className = node.classDecl.uniqueName;
    final fieldName = node.finalName;
    return '${className}__$fieldName';
  }
}

class CMethodName extends Visitor<Method, String> {
  const CMethodName();

  @override
  String visit(Method node) {
    final className = node.classDecl.uniqueName;
    final methodName = node.finalName;
    return '${className}__$methodName';
  }
}
