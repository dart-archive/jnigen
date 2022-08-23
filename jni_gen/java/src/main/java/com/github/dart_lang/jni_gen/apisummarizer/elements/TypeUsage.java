package com.github.dart_lang.jni_gen.apisummarizer.elements;
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

import java.util.List;

public class TypeUsage {
  public enum Kind {
    DECLARED,
    TYPE_VARIABLE,
    WILDCARD,
    ARRAY,
    INTERSECTION,
    PRIMITIVE,
  }

  // Could've made it just a type hierarchy, but client code parsing JSON
  // needs to know the type beforehand, before it can deserialize the `type` field.
  public String shorthand;
  public Kind kind;
  public ReferredType type;

  public abstract static class ReferredType {}

  public static class PrimitiveType extends ReferredType {
    public String name;

    public PrimitiveType(String name) {
      this.name = name;
    }
  }

  public static class DeclaredType extends ReferredType {
    public String binaryName;
    public String simpleName;
    public List<TypeUsage> params;

    public DeclaredType(String binaryName, String simpleName, List<TypeUsage> params) {
      this.binaryName = binaryName;
      this.simpleName = simpleName;
      this.params = params;
    }
  }

  public static class TypeVar extends ReferredType {
    public String name;

    public TypeVar(String name) {
      this.name = name;
    }
  }

  public static class Wildcard extends ReferredType {
    public TypeUsage extendsBound, superBound;

    public Wildcard(TypeUsage extendsBound, TypeUsage superBound) {
      this.extendsBound = extendsBound;
      this.superBound = superBound;
    }
  }

  public static class Intersection extends ReferredType {
    public List<TypeUsage> types;

    public Intersection(List<TypeUsage> types) {
      this.types = types;
    }
  }

  public static class Array extends ReferredType {
    public TypeUsage type;

    public Array(TypeUsage type) {
      this.type = type;
    }
  }
}
