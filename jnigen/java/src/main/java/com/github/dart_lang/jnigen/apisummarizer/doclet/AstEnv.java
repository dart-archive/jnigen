// Copyright (c) 2022, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

package com.github.dart_lang.jnigen.apisummarizer.doclet;

import com.sun.source.util.DocTrees;

import javax.annotation.processing.Filer;
import javax.annotation.processing.Messager;
import javax.annotation.processing.ProcessingEnvironment;
import javax.lang.model.SourceVersion;
import javax.lang.model.util.Elements;
import javax.lang.model.util.Types;
import jdk.javadoc.doclet.DocletEnvironment;

import java.util.Locale;
import java.util.Map;

/** Class to hold utility classes initialized from DocletEnvironment. */
public class AstEnv implements ProcessingEnvironment {
  public final Types types;
  public final Elements elements;
  public final DocTrees trees;

  public AstEnv(Types types, Elements elements, DocTrees trees) {
    this.types = types;
    this.elements = elements;
    this.trees = trees;
  }

  public static AstEnv fromEnvironment(DocletEnvironment env) {
    return new AstEnv(env.getTypeUtils(), env.getElementUtils(), env.getDocTrees());
  }

  @Override
  public Map<String, String> getOptions() {
    return null;
  }

  @Override
  public Messager getMessager() {
    return null;
  }

  @Override
  public Filer getFiler() {
    return null;
  }

  @Override
  public Elements getElementUtils() {
    return elements;
  }

  @Override
  public Types getTypeUtils() {
    return types;
  }

  @Override
  public SourceVersion getSourceVersion() {
    return null;
  }

  @Override
  public Locale getLocale() {
    return null;
  }
}
