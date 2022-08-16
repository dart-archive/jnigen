package com.github.hegde.mahesh.apisummarizer.util;

// Generic skip exception when method does not know what to do with a class or method
public class SkipException extends RuntimeException {
  public SkipException(String message) {
    super(message);
  }
}
