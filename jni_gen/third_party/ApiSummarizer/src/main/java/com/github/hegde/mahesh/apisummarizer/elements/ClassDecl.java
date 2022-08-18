/*
 * Copyright (C) The Dart Project authors
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License as
 * published by the Free Software Foundation; either version 2 of the
 * License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
 * 02110-1301 USA.
 */

package com.github.hegde.mahesh.apisummarizer.elements;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

/**
 * Denotes a class or interface declaration. Here's an example for various kinds of names stored in
 * this structure: simpleName : "Example", binaryName : "dev.dart.sample.Example", parentName :
 * null, packageName : "dev.dart.sample",
 */
public class ClassDecl {
  public DeclKind declKind;

  /** Modifiers eg: static, public and abstract. */
  public Set<String> modifiers;

  /** Unqualified name of the class. For example `ClassDecl` */
  public String simpleName;

  /**
   * Unique, fully qualified name of the class, it's like a qualified name used in a program but
   * uses $ instead of dot (.) before nested classes.
   */
  public String binaryName;

  public String parentName;
  public String packageName;
  public List<TypeParam> typeParams;
  public List<Method> methods = new ArrayList<>();
  public List<Field> fields = new ArrayList<>();
  public TypeUsage superclass;
  public List<TypeUsage> interfaces;
  public boolean hasStaticInit;
  public boolean hasInstanceInit;
  public JavaDocComment javadoc;
  public List<JavaAnnotation> annotations;

  /** In case of enum, names of enum constants */
  public List<String> values = new ArrayList<>();
}
