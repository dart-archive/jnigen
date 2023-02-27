// Copyright (c) 2023, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../elements/elements.dart';

abstract class ElementVisitor<T> {
  const ElementVisitor();

  T visitClasses(Classes classes);
  T visitClassDecl(ClassDecl classDecl);
  T visitTypeUsage(TypeUsage typeUsage);
  T visitMethod(Method method);
  T visitField(Field field);
  T visitPrimitiveType(PrimitiveType type);
  T visitDeclaredType(DeclaredType type);
  T visitTypeVar(TypeVar type);
  T visitWildcard(Wildcard wildcard);
  T visitArrayType(ArrayType type);
  T visitParam(Param param);
  T visitTypeParam(TypeParam typeParam);
  T visitJavaDocComment(JavaDocComment comment);
  T visitAnnotation(Annotation annotation);
}
