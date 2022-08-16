package com.github.hegde.mahesh.apisummarizer.elements;

import java.util.HashMap;
import java.util.Map;

public class JavaAnnotation {
  public String simpleName;
  public String binaryName;
  public Map<String, Object> properties = new HashMap<>();

  public static class EnumVal {
    String enumClass;
    String value;

    public EnumVal(String enumClass, String value) {
      this.enumClass = enumClass;
      this.value = value;
    }
  }
}
