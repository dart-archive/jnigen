package com.github.dart_lang.jni_gen.apisummarizer.util;

// Generic skip exception when the code cannot decide how to handle an element.
// The caller in some above layer can catch this and skip to appropriate extent.
public class SkipException extends RuntimeException {
  public SkipException(String message) {
    super(message);
  }
}
