package com.github.hegde.mahesh.apisummarizer.disasm;

import com.github.hegde.mahesh.apisummarizer.elements.JavaAnnotation;
import com.github.hegde.mahesh.apisummarizer.elements.Method;
import org.objectweb.asm.AnnotationVisitor;
import org.objectweb.asm.MethodVisitor;
import org.objectweb.asm.TypePath;

import java.util.ArrayList;
import java.util.List;

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