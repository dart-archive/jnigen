package com.github.dart_lang.jnigen.apisummarizer.util;

import javax.tools.SimpleJavaFileObject;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.net.URI;
import java.nio.charset.StandardCharsets;
import java.util.jar.JarFile;
import java.util.zip.ZipEntry;

class JarEntryFileObject extends SimpleJavaFileObject {
    JarFile jarFile;
    String relativePath;

    protected JarEntryFileObject(JarFile jarFile, ZipEntry entry) {
        super(URI.create(jarFile.getName() + "!" + entry.getName()), Kind.SOURCE);
        this.jarFile = jarFile;
        this.relativePath = entry.getName();
    }

    private int getEntrySize(ZipEntry entry) {
        long limit = 1024L * 1024L * 16L; // Arbitrary limit, how long can be a source file?
        long size = entry.getSize();
        return size > limit ? (int) limit : (int) size;
    }

    @Override
    public CharSequence getCharContent(boolean ignoreEncodingErrors) {
        var entry = jarFile.getEntry(relativePath);
        var out = new ByteArrayOutputStream(getEntrySize(entry));

        try (var stream = jarFile.getInputStream(entry)) {
            stream.transferTo(out);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
        return out.toString(StandardCharsets.UTF_8);
    }
}