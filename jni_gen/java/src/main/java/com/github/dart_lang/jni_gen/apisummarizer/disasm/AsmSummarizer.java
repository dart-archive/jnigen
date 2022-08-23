/*
 * Copyright (C) The Dart Project authors
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License as
 * published by the Free Software Foundation; either version 2 of the
 * License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
 * 02110-1301 USA.
 */

package com.github.dart_lang.jni_gen.apisummarizer.disasm;

import com.github.dart_lang.jni_gen.apisummarizer.elements.ClassDecl;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;
import java.util.jar.JarFile;
import java.util.stream.Collectors;
import java.util.zip.ZipEntry;
import org.objectweb.asm.ClassReader;

/** Class that summarizes Java APIs in compiled JARs using ASM not working yet. */
public class AsmSummarizer {

  private static class JarClass {
    JarFile jar;
    ZipEntry entry;

    public JarClass(JarFile jar, ZipEntry entry) {
      this.jar = jar;
      this.entry = entry;
    }
  }

  public static List<JarClass> findJarLocation(
      String binaryName, List<JarFile> jars, String suffix) {
    String path = binaryName.replace(".", "/");
    for (var jar : jars) {
      var classEntry = jar.getEntry(path + suffix);
      if (classEntry != null) {
        return List.of(new JarClass(jar, classEntry));
      }
      var dirPath = path.endsWith("/") ? path : path + "/";
      var dirEntry = jar.getEntry(dirPath);
      if (dirEntry != null && dirEntry.isDirectory()) {
        return jar.stream()
            .map(je -> (ZipEntry) je)
            .filter(
                entry -> {
                  var name = entry.getName();
                  return name.endsWith(suffix) && name.startsWith(dirPath);
                })
            .map(entry -> new JarClass(jar, entry))
            .collect(Collectors.toList());
      }
    }
    throw new RuntimeException("Cannot find class");
  }

  public static List<ClassDecl> run(String[] jarPaths, String[] classes) throws IOException {
    var jars =
        Arrays.stream(jarPaths)
            .map(
                filename -> {
                  try {
                    return new JarFile(filename);
                  } catch (IOException e) {
                    throw new RuntimeException(e);
                  }
                })
            .collect(Collectors.toList());
    return Arrays.stream(classes)
        .flatMap(c -> findJarLocation(c, jars, ".class").stream())
        .map(
            classFile -> {
              try {
                return new ClassReader(classFile.jar.getInputStream(classFile.entry));
              } catch (IOException e) {
                throw new RuntimeException(e);
              }
            })
        .flatMap(
            reader -> {
              var visitor = new AsmClassVisitor();
              reader.accept(visitor, 0);
              return visitor.getVisited().stream();
            })
        .collect(Collectors.toList());
  }
}
