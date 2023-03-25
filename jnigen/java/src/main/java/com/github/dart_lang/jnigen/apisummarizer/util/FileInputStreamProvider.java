package com.github.dart_lang.jnigen.apisummarizer.util;

import java.io.*;

/** Implementation of InputStreamProvider backed by a File.
 * */
public class FileInputStreamProvider implements InputStreamProvider {
    File file;
    InputStream stream;
    volatile boolean isOpen = false;

    public FileInputStreamProvider(File file) {
        this.file = file;
    }

    synchronized private void openInputStream() {
        // Double-checked locking
        if (isOpen) return;
        try {
            stream = new FileInputStream(file);
            isOpen = true;
        } catch (FileNotFoundException e) {
            throw new RuntimeException(e);
        }
    }

    synchronized private void closeInputStream() {
        if (isOpen) {
            try {
                stream.close();
            } catch (IOException e) {
                throw new RuntimeException(e);
            }
        }
    }

    @Override
    public InputStream getInputStream() {
        if (!isOpen) {
            openInputStream();
        }
        return stream;
    }

    @Override
    public void close() {
        if (isOpen) {
            closeInputStream();
        }
    }
}
