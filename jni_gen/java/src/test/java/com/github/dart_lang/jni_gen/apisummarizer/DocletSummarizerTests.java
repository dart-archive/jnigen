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

package com.github.dart_lang.jni_gen.apisummarizer;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertTrue;

import com.github.dart_lang.jni_gen.apisummarizer.elements.ClassDecl;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;

public class DocletSummarizerTests {
  private List<ClassDecl> parsedDecls;
  private final Map<String, ClassDecl> classesByName = new HashMap<>();

  @Before
  public void setUp() {
    var opts = new Main.SummarizerOptions();
    opts.sourcePaths = "src/test/resources/";
    // javadoc tool API is quite inflexible, in that we cannot pass an doclet object, but a class
    // So any state we want to access from it has to be either serialized or saved in static fields.
    // This means we lose lot of control over loading of files etc..
    // Here, TestDoclet simply stores the result in a static variable which we can get and check
    // later.
    Main.runDocletWithClass(TestDoclet.class, List.of("com.example.Example"), opts);
    parsedDecls = TestDoclet.getClassDecls();
    for (var decl : parsedDecls) {
      classesByName.put(decl.binaryName, decl);
    }
  }

  @Test
  public void checkNumberOfClasses() {
    Assert.assertEquals(2, parsedDecls.size());
  }

  @Test
  public void checkNamesOfClasses() {
    var names = parsedDecls.stream().map(decl -> decl.binaryName).collect(Collectors.toSet());
    assertTrue(names.contains("com.example.Example"));
    assertTrue(names.contains("com.example.Example$Aux"));
  }

  @Test
  public void checkNumberOfFieldsAndMethods() {
    var example = classesByName.get("com.example.Example");
    assertEquals("Example", example.simpleName);
    assertEquals(3, example.fields.size());
    assertEquals(3, example.methods.size());
  }
}
