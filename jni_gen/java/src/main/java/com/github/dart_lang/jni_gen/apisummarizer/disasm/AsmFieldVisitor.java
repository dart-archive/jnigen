package com.github.dart_lang.jni_gen.apisummarizer.disasm;
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

import com.github.dart_lang.jni_gen.apisummarizer.elements.Field;
import com.github.dart_lang.jni_gen.apisummarizer.elements.JavaAnnotation;
import org.objectweb.asm.AnnotationVisitor;
import org.objectweb.asm.FieldVisitor;

public class AsmFieldVisitor extends FieldVisitor implements AsmAnnotatedElementVisitor {
  Field field;

  public AsmFieldVisitor(Field field) {
    super(AsmConstants.API);
    this.field = field;
  }

  @Override
  public void addAnnotation(JavaAnnotation annotation) {
    field.annotations.add(annotation);
  }

  @Override
  public AnnotationVisitor visitAnnotation(String descriptor, boolean visible) {
    return AsmAnnotatedElementVisitor.super.visitAnnotationDefault(descriptor, visible);
  }
}
