package com.github.dart_lang.jnigen.apisummarizer.util;

import java.io.InputStream;

public interface InputStreamProvider {
    InputStream getInputStream();
    void close();
}
