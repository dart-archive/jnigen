package com.github.hegde.mahesh.apisummarizer.elements;

public interface TypeDecl {
  // can be EnumType, ClassType, InterfaceType, or ArrayType
  DeclKind getKind();

  String getQualifiedName();

  String getSimpleName();
  // String getPackageName();
  // String getInternalName();
}
