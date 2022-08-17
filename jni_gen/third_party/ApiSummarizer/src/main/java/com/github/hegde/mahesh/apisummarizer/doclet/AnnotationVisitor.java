package com.github.hegde.mahesh.apisummarizer.doclet;

import javax.lang.model.element.AnnotationMirror;
import javax.lang.model.element.AnnotationValue;
import javax.lang.model.element.AnnotationValueVisitor;
import javax.lang.model.element.VariableElement;
import javax.lang.model.type.TypeMirror;
import java.util.List;
import java.util.stream.Collectors;

// AnnotationVisitor mechanism is not perfect right now. There are edge cases which need to be handled but
// this is not an immediate priority, since the utility of annotations other than Override and NonNull in
// jni_gen is perhaps limited to custom exclusion filters and rename configuration.
public class AnnotationVisitor implements AnnotationValueVisitor<Object, Void> {

  private final ElementBuilders builders;
  AstEnv env;

  public AnnotationVisitor(ElementBuilders builders) {
    this.builders = builders;
    this.env = builders.env;
  }

  @Override
  public Object visit(AnnotationValue annotationValue, Void unused) {
    return null;
  }

  @Override
  public Object visitBoolean(boolean b, Void unused) {
    return b;
  }

  @Override
  public Object visitByte(byte b, Void unused) {
    return b;
  }

  @Override
  public Object visitChar(char c, Void unused) {
    return c;
  }

  @Override
  public Object visitDouble(double v, Void unused) {
    return v;
  }

  @Override
  public Object visitFloat(float v, Void unused) {
    return v;
  }

  @Override
  public Object visitInt(int i, Void unused) {
    return i;
  }

  @Override
  public Object visitLong(long l, Void unused) {
    return l;
  }

  @Override
  public Object visitShort(short i, Void unused) {
    return i;
  }

  @Override
  public Object visitString(String s, Void unused) {
    return s;
  }

  @Override
  public Object visitType(TypeMirror typeMirror, Void unused) {
    return builders.typeUsage(typeMirror);
  }

  @Override
  public Object visitEnumConstant(VariableElement variableElement, Void unused) {
    // TODO: Perhaps simple name is not enough. We need to return qualified name + enum constant name for completeness.
    return variableElement.getSimpleName();
  }

  @Override
  public Object visitAnnotation(AnnotationMirror mirror, Void unused) {
    return builders.annotation(mirror);
  }

  @Override
  public Object visitArray(List<? extends AnnotationValue> list, Void unused) {
    return list.stream().map(x -> x.accept(this, null)).collect(Collectors.toList());
  }

  @Override
  public Object visitUnknown(AnnotationValue annotationValue, Void unused) {
    return null;
  }
}
