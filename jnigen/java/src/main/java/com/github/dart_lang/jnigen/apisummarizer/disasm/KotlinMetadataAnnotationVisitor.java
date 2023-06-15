// Copyright (c) 2023, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

package com.github.dart_lang.jnigen.apisummarizer.disasm;

import java.util.List;
import kotlinx.metadata.jvm.KotlinClassHeader;
import kotlinx.metadata.jvm.KotlinClassMetadata;
import org.objectweb.asm.AnnotationVisitor;

public class KotlinMetadataAnnotationVisitor extends AnnotationVisitor {
  private int kind;
  private int[] metadataVersion;
  private List<String> data1;
  private List<String> data2;
  private String extraString;
  private String packageName;
  private int extraInt;

  public KotlinMetadataAnnotationVisitor() {
    super(AsmConstants.API);
  }

  @Override
  public void visit(String name, Object value) {
    switch (name) {
      case "k" -> kind = (int) value;
      case "mv" -> metadataVersion = (int[]) value;
      case "xs" -> extraString = (String) value;
      case "pn" -> packageName = (String) value;
      case "xi" -> extraInt = (int) value;
    }
  }

  @Override
  public AnnotationVisitor visitArray(String name) {
    List<String> arr;
    switch (name) {
      case "d1" -> arr = data1;
      case "d2" -> arr = data2;
      default -> {
        return super.visitArray(name);
      }
    }
    return new AnnotationVisitor(AsmConstants.API) {
      @Override
      public void visit(String name, Object value) {
        arr.add((String) value);
        super.visit(name, value);
      }
    };
  }

  @Override
  public void visitEnd() {
    var header =
        new KotlinClassHeader(
            kind,
            metadataVersion,
            data1.toArray(String[]::new),
            data2.toArray(String[]::new),
            extraString,
            packageName,
            extraInt);
    var metadata = KotlinClassMetadata.read(header);
    if (metadata instanceof KotlinClassMetadata.Class) {
      var klass = ((KotlinClassMetadata.Class) metadata).toKmClass();
      // TODO
    } else if (metadata instanceof KotlinClassMetadata.FileFacade) {
      // TODO(#301): Top-level functions can be represented as top-level functions in Dart.
    } else if (metadata instanceof KotlinClassMetadata.SyntheticClass) {
      // Ignore synthetic classes such as lambdas.
    } else if (metadata instanceof KotlinClassMetadata.MultiFileClassFacade) {
      // Ignore multi-file classes
    } else if (metadata instanceof KotlinClassMetadata.MultiFileClassPart) {
      // Ignore multi-file classes
    } else if (metadata instanceof KotlinClassMetadata.Unknown) {
      // Unsupported
    }
    super.visitEnd();
  }
}
