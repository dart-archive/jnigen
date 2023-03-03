// Copyright (c) 2023, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../elements/elements.dart';

abstract class Visitor<T extends Element<T>> {
  const Visitor();

  void visit(T node);
}

abstract class TypeVisitor {
  const TypeVisitor();

  void visitPrimitiveType(PrimitiveType node);
  void visitArrayType(ArrayType node);
  void visitDeclaredType(DeclaredType node);
  void visitTypeVar(TypeVar node);
  void visitWildcard(Wildcard node);
}
