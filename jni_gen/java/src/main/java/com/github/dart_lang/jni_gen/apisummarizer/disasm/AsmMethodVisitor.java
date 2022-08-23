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

package com.github.dart_lang.jni_gen.apisummarizer.disasm;

import com.github.dart_lang.jni_gen.apisummarizer.elements.JavaAnnotation;
import com.github.dart_lang.jni_gen.apisummarizer.elements.Method;
import java.util.ArrayList;
import java.util.List;
import org.objectweb.asm.AnnotationVisitor;
import org.objectweb.asm.MethodVisitor;
import org.objectweb.asm.TypePath;

public class AsmMethodVisitor extends MethodVisitor implements AsmAnnotatedElementVisitor {
  Method method;
  List<String> paramNames = new ArrayList<>();

  protected AsmMethodVisitor(Method method) {
    super(AsmConstants.API);
    this.method = method;
  }

  @Override
  public void visitParameter(String name, int access) {
    paramNames.add(name);
  }

  @Override
  public void addAnnotation(JavaAnnotation annotation) {
    method.annotations.add(annotation);
  }

  @Override
  public AnnotationVisitor visitAnnotationDefault(String descriptor, boolean visible) {
    return AsmAnnotatedElementVisitor.super.visitAnnotationDefault(descriptor, visible);
  }

  @Override
  public AnnotationVisitor visitTypeAnnotation(
      int typeRef, TypePath typePath, String descriptor, boolean visible) {
    // TODO: Collect annotation on type parameter
    return super.visitTypeAnnotation(typeRef, typePath, descriptor, visible);
  }

  @Override
  public AnnotationVisitor visitParameterAnnotation(
      int parameter, String descriptor, boolean visible) {
    // TODO: collect and attach it to parameters
    return super.visitParameterAnnotation(parameter, descriptor, visible);
  }

  @Override
  public void visitEnd() {
    if (paramNames.size() == method.params.size()) {
      for (int i = 0; i < paramNames.size(); i++) {
        method.params.get(i).name = paramNames.get(i);
      }
    }
  }
}
