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

package com.github.hegde.mahesh.apisummarizer.doclet;

import com.sun.source.util.DocTrees;
import javax.lang.model.util.Elements;
import javax.lang.model.util.Types;
import jdk.javadoc.doclet.DocletEnvironment;

/** Class to hold Utility classes initialized from DocletEnvironment */
public class AstEnv {
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
}
