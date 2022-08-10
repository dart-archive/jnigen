package com.github.hegde.mahesh.apisummarizer.elements;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

public class Method {
    public Set<String> modifiers = new HashSet<>();
    public String name;
    public List<TypeParam> typeParams;
    public List<Param> params = new ArrayList<>();
    public TypeUsage returnType;

    public JavaDocComment javadoc;
    public List<JavaAnnotation> annotations = new ArrayList<>();
}
