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
