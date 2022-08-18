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

package com.github.hegde.mahesh.apisummarizer.disasm;

import com.github.hegde.mahesh.apisummarizer.elements.JavaAnnotation;
import org.objectweb.asm.AnnotationVisitor;
import org.objectweb.asm.Type;

// This interface removes some repetitive code using default methods

public interface AsmAnnotatedElementVisitor {
  void addAnnotation(JavaAnnotation annotation);

  default AnnotationVisitor visitAnnotationDefault(String descriptor, boolean visible) {
    var annotation = new JavaAnnotation();
    var aType = Type.getType(descriptor);
    annotation.binaryName = aType.getClassName();
    annotation.simpleName = TypeUtils.simpleName(aType);
    addAnnotation(annotation);
    return new AsmAnnotationVisitor(annotation);
  }
}
