// Copyright (c) 2023, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../elements/elements.dart';

abstract class Visitor<T extends Element<T>, R> {
  const Visitor();

  R visit(T node);
}

abstract class TypeVisitor<R> {
  const TypeVisitor();

  R visitPrimitiveType(PrimitiveType node);
  R visitArrayType(ArrayType node);
  R visitDeclaredType(DeclaredType node);
  R visitTypeVar(TypeVar node);
  R visitWildcard(Wildcard node);
}

extension MultiVisitor<T extends Element<T>> on Iterable<Element<T>> {
  Iterable<R> accept<R>(Visitor<T, R> v) {
    return map((e) => e.accept(v));
  }
}

extension MultiTypeVisitor<T extends ReferredType<T>>
    on Iterable<ReferredType<T>> {
  Iterable<R> accept<R>(TypeVisitor<R> v) {
    return map((e) => e.accept(v));
  }
}

extension MultiTypeUsageVisitor on Iterable<TypeUsage> {
  Iterable<R> accept<R>(TypeVisitor<R> v) {
    return map((e) => e.type.accept(v));
  }
}
