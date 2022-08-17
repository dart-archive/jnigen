package com.github.hegde.mahesh.apisummarizer;

import com.github.hegde.mahesh.apisummarizer.doclet.SummarizerDocletBase;
import com.github.hegde.mahesh.apisummarizer.elements.ClassDecl;
import java.util.List;
import jdk.javadoc.doclet.DocletEnvironment;

public class TestDoclet extends SummarizerDocletBase {
  @Override
  public boolean run(DocletEnvironment docletEnvironment) {
    return super.run(docletEnvironment);
  }

  public static List<ClassDecl> getClassDecls() {
    return types;
  }
}
