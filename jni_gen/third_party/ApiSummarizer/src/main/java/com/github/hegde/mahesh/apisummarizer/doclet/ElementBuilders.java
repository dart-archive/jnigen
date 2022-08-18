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

package com.github.hegde.mahesh.apisummarizer.doclet;

import com.github.hegde.mahesh.apisummarizer.elements.*;
import com.github.hegde.mahesh.apisummarizer.util.StreamUtil;
import com.sun.source.doctree.DocCommentTree;
import java.util.HashMap;
import java.util.List;
import java.util.stream.Collectors;
import javax.lang.model.element.*;
import javax.lang.model.type.*;

public class ElementBuilders {
  AstEnv env;

  public ElementBuilders(AstEnv env) {
    this.env = env;
  }

  private void fillInFromTypeElement(TypeElement e, ClassDecl c) {
    c.modifiers = e.getModifiers().stream().map(Modifier::toString).collect(Collectors.toSet());
    switch (e.getKind()) {
      case INTERFACE:
        c.declKind = DeclKind.INTERFACE;
        break;
      case CLASS:
        c.declKind = DeclKind.CLASS;
        break;
      case ENUM:
        c.declKind = DeclKind.ENUM;
        break;
      case ANNOTATION_TYPE:
        c.declKind = DeclKind.ANNOTATION_TYPE;
        break;
    }
    c.simpleName = e.getSimpleName().toString();
    c.binaryName = env.elements.getBinaryName(e).toString();
    var parent = e.getEnclosingElement();
    if (parent instanceof TypeElement) {
      c.parentName = env.elements.getBinaryName((TypeElement) parent).toString();
    }
    c.packageName = env.elements.getPackageOf(e).getQualifiedName().toString();
    c.javadoc = docComment(env.trees.getDocCommentTree(e));
    c.typeParams = StreamUtil.map(e.getTypeParameters(), this::typeParam);
    var superclass = e.getSuperclass();
    if (superclass instanceof DeclaredType) {
      c.superclass = typeUsage(superclass);
    }
    c.annotations = StreamUtil.map(e.getAnnotationMirrors(), this::annotation);
    c.interfaces = StreamUtil.map(e.getInterfaces(), this::typeUsage);
  }

  public ClassDecl classDecl(TypeElement e) {
    var c = new ClassDecl();
    fillInFromTypeElement(e, c);
    return c;
  }

  public Field field(VariableElement e) {
    assert e.getKind() == ElementKind.FIELD;
    var field = new Field();
    field.name = e.getSimpleName().toString();
    field.modifiers = e.getModifiers().stream().map(Modifier::toString).collect(Collectors.toSet());
    field.defaultValue = e.getConstantValue();
    field.type = typeUsage(e.asType());
    field.javadoc = docComment(env.trees.getDocCommentTree(e));
    field.annotations = annotations(e.getAnnotationMirrors());
    return field;
  }

  public List<JavaAnnotation> annotations(List<? extends AnnotationMirror> mirrors) {
    return mirrors.stream().map(this::annotation).collect(Collectors.toList());
  }

  public JavaAnnotation annotation(AnnotationMirror mirror) {
    var annotation = new JavaAnnotation();
    var type = mirror.getAnnotationType();
    var typeElement = (TypeElement) (env.types.asElement(type));
    annotation.simpleName = typeElement.getSimpleName().toString();
    annotation.binaryName = env.elements.getBinaryName(typeElement).toString();
    var values = env.elements.getElementValuesWithDefaults(mirror);
    if (values.isEmpty()) {
      return annotation;
    }

    // This is not perfect, but some metadata is better than none.
    annotation.properties = new HashMap<>();
    for (var key : values.keySet()) {
      var val = values.get(key);
      var obj = val.getValue();
      // TODO: Accurately represent more complex annotation values
      if (obj instanceof String || obj instanceof Number) {
        annotation.properties.put(key.getSimpleName().toString(), obj);
      } else {
        annotation.properties.put(
            key.getSimpleName().toString(), val.accept(new AnnotationVisitor(this), null));
      }
    }
    return annotation;
  }

  public JavaDocComment docComment(DocCommentTree tree) {
    if (tree == null) {
      return null;
    }
    // Leave it as is, for now
    // tree.accept(new TreeScanner(), j);
    return new JavaDocComment(tree.toString());
  }

  public TypeParam typeParam(TypeParameterElement tpe) {
    var tp = new TypeParam();
    tp.name = tpe.getSimpleName().toString();
    tp.bounds = tpe.getBounds().stream().map(this::typeUsage).collect(Collectors.toList());
    return tp;
  }

  public Param param(VariableElement e) {
    var param = new Param();
    param.javadoc = docComment(env.trees.getDocCommentTree(e));
    param.name = e.getSimpleName().toString();
    param.type = typeUsage(e.asType());
    param.annotations = annotations(e.getAnnotationMirrors());
    return param;
  }

  public TypeUsage typeUsage(TypeMirror type) {
    var u = new TypeUsage();
    u.shorthand = type.toString();
    var element = env.types.asElement(type);
    switch (type.getKind()) {
      case DECLARED:
        // Unique name that's binary name not qualified name
        // (It's somewhat confusing but qualified name does not need to be unique,
        // because of nesting)
        u.kind = TypeUsage.Kind.DECLARED;
        var name =
            element instanceof TypeElement
                ? env.elements.getBinaryName((TypeElement) element).toString()
                : element.getSimpleName().toString();
        List<TypeUsage> params = null;
        if (type instanceof DeclaredType) { // it will be
          params =
              ((DeclaredType) type)
                  .getTypeArguments().stream().map(this::typeUsage).collect(Collectors.toList());
        }
        u.type = new TypeUsage.DeclaredType(name, element.getSimpleName().toString(), params);
        break;
      case TYPEVAR:
        u.kind = TypeUsage.Kind.TYPE_VARIABLE;
        // TODO: Encode bounds of type variable.
        // But somehow skip self referencing or mutually referencing
        // bounds which will cause a stack overflow.
        // Alternatively, the consumer can keep a context to find the type variable by itself
        // but dealing with shadowing etc.. will be tougher.
        // Also consider: encoding the erasure of the type, which doesn't seem to cause
        // infinite recursion.
        u.type = new TypeUsage.TypeVar(element.getSimpleName().toString());
        break;
      case ARRAY:
        u.kind = TypeUsage.Kind.ARRAY;
        var arr = ((ArrayType) type);
        u.type = new TypeUsage.Array(typeUsage(arr.getComponentType()));
        break;
      case VOID:
        u.type = new TypeUsage.PrimitiveType("void");
        u.kind = TypeUsage.Kind.PRIMITIVE;
        break;
      case WILDCARD:
        u.kind = TypeUsage.Kind.WILDCARD;
        var wildcard = ((WildcardType) type);
        var extendsBound = wildcard.getExtendsBound();
        var superBound = wildcard.getSuperBound();
        u.type =
            new TypeUsage.Wildcard(
                extendsBound != null ? typeUsage(extendsBound) : null,
                superBound != null ? typeUsage(superBound) : null);
        break;
      case INTERSECTION:
        u.kind = TypeUsage.Kind.INTERSECTION;
        u.type =
            new TypeUsage.Intersection(
                ((IntersectionType) type)
                    .getBounds().stream().map(this::typeUsage).collect(Collectors.toList()));
        break;
      default:
        u.kind = TypeUsage.Kind.PRIMITIVE;
        if (type instanceof PrimitiveType) {
          u.type = new TypeUsage.PrimitiveType(type.toString());
        } else {
          System.out.println("Unsupported type: " + type);
          // throw exception.
        }
    }
    return u;
  }

  public Method method(ExecutableElement e) {
    var m = new Method();
    m.name = e.getSimpleName().toString();
    m.modifiers = e.getModifiers().stream().map(Modifier::toString).collect(Collectors.toSet());
    m.typeParams = e.getTypeParameters().stream().map(this::typeParam).collect(Collectors.toList());
    m.returnType = typeUsage(e.getReturnType());
    m.javadoc = docComment(env.trees.getDocCommentTree(e));
    m.annotations = annotations(e.getAnnotationMirrors());
    return m;
  }
}
