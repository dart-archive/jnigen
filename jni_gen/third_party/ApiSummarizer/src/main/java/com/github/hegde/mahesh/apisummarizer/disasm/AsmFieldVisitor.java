package com.github.hegde.mahesh.apisummarizer.disasm;

import com.github.hegde.mahesh.apisummarizer.elements.Field;
import com.github.hegde.mahesh.apisummarizer.elements.JavaAnnotation;
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
