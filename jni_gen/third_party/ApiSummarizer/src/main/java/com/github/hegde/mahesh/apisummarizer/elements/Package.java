package com.github.hegde.mahesh.apisummarizer.elements;

import java.util.ArrayList;
import java.util.List;

public class Package {
  public JavaDocComment packageDoc;
  public String name;
  public String fullName;
  public String parent;

  public List<Package> packages = new ArrayList<>();
  public List<ClassDecl> classes = new ArrayList<>();
}
