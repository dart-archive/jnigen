package com.github.hegde.mahesh.apisummarizer.disasm;
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

import com.github.hegde.mahesh.apisummarizer.elements.JavaAnnotation;
import java.util.ArrayList;
import java.util.List;
import org.objectweb.asm.AnnotationVisitor;
import org.objectweb.asm.Type;

public class AsmAnnotationVisitor extends AnnotationVisitor {

  JavaAnnotation annotation;

  protected AsmAnnotationVisitor(JavaAnnotation annotation) {
    super(AsmConstants.API);
    this.annotation = annotation;
  }

  @Override
  public void visit(String name, Object value) {
    annotation.properties.put(name, value);
  }

  @Override
  public void visitEnum(String name, String descriptor, String value) {
    annotation.properties.put(
        name, new JavaAnnotation.EnumVal(Type.getType(descriptor).getClassName(), value));
  }

  @Override
  public AnnotationVisitor visitAnnotation(String name, String descriptor) {
    var type = Type.getType(descriptor);
    var nested = new JavaAnnotation();
    nested.binaryName = type.getClassName();
    nested.simpleName = TypeUtils.simpleName(type);
    annotation.properties.put(name, nested);
    return new AsmAnnotationVisitor(nested);
  }

  @Override
  public AnnotationVisitor visitArray(String name) {
    List<Object> list = new ArrayList<>();
    annotation.properties.put(name, list);
    return new AnnotationArrayVisitor(list);
  }

  public static class AnnotationArrayVisitor extends AnnotationVisitor {
    List<Object> list;

    protected AnnotationArrayVisitor(List<Object> list) {
      super(AsmConstants.API);
      this.list = list;
    }

    @Override
    public void visit(String unused, Object value) {
      list.add(value);
    }

    @Override
    public void visitEnum(String unused, String descriptor, String value) {
      var type = Type.getType(descriptor);
      list.add(new JavaAnnotation.EnumVal(type.getClassName(), value));
    }

    @Override
    public AnnotationVisitor visitAnnotation(String unused, String descriptor) {
      var type = Type.getType(descriptor);
      var nested = new JavaAnnotation();
      nested.binaryName = type.getClassName();
      nested.simpleName = TypeUtils.simpleName(type);
      list.add(nested);
      return new AsmAnnotationVisitor(nested);
    }

    @Override
    public AnnotationVisitor visitArray(String unused) {
      List<Object> nested = new ArrayList<>();
      list.add(nested);
      return new AnnotationArrayVisitor(nested);
    }
  }
}
