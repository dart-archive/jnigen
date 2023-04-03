package com.github.dart_lang.jnigen.apisummarizer.util;

import java.io.InputStream;

public interface InputStreamProvider {
  /** Return the input stream, initializing it if needed. */
  InputStream getInputStream();

  /** close the underlying InputStream. */
  void close();
}
