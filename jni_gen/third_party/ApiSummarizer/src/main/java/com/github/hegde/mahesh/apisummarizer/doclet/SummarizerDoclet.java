package com.github.hegde.mahesh.apisummarizer.doclet;

import com.github.hegde.mahesh.apisummarizer.Main;
import jdk.javadoc.doclet.DocletEnvironment;

public class SummarizerDoclet extends SummarizerDocletBase {
  @Override
  public boolean run(DocletEnvironment docletEnvironment) {
    var result = super.run(docletEnvironment);
    Main.writeAll(types);
    return result;
  }
}
