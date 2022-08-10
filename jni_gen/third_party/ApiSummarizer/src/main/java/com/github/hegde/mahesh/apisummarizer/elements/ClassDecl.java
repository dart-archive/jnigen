package com.github.hegde.mahesh.apisummarizer.elements;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

// Currently Interfaces are stored as ClassDecl
// EnumDecl is a subclass which has names of enum constants

/** Denotes class or interface declaration. */
public class ClassDecl {
    public DeclKind declKind;
    public Set<String> modifiers;
    public String qualifiedName;
    public String simpleName;
    public String binaryName;
    public String internalName;
    public String parentName;
    public String packageName;
    public List<TypeParam> typeParams;
    public List<Method> methods = new ArrayList<>();
    public List<Field> fields = new ArrayList<>();
    public TypeUsage superclass;
    public List<TypeUsage> interfaces;
    public boolean hasStaticInit;
    public boolean hasInstanceInit;
    public JavaDocComment javadoc;
    public List<JavaAnnotation> annotations;
    // In case of enum, names of enum constants
    public List<String> values = new ArrayList<>();
}
