package com.github.hegde.mahesh.apisummarizer.elements;

import java.util.ArrayList;
import java.util.List;

public class Param {
  public String name;
  public TypeUsage type;

  public JavaDocComment javadoc;
  public List<JavaAnnotation> annotations = new ArrayList<>();
}
