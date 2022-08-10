package com.github.hegde.mahesh.apisummarizer.doclet;

import com.sun.source.util.DocTrees;
import jdk.javadoc.doclet.DocletEnvironment;

import javax.lang.model.util.Elements;
import javax.lang.model.util.Types;

/** Class to hold Utility classes initialized from DocletEnvironment */
public class AstEnv {
    public final Types types;
    public final Elements elements;
    public final DocTrees trees;

    public AstEnv(Types types, Elements elements, DocTrees trees) {
        this.types = types;
        this.elements = elements;
        this.trees = trees;
    }

    public static AstEnv fromEnvironment(DocletEnvironment env) {
        return new AstEnv(env.getTypeUtils(), env.getElementUtils(), env.getDocTrees());
    }
}
