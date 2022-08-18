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

package com.github.hegde.mahesh.apisummarizer.elements;

public class JavaDocComment {
  public String comment;

  // TODO: Escape HTML tags, and optionally convert the familiar ones to markdown.

  // TODO: Build a detailed tree representation of JavaDocComment
  // which can be processed by tools in other languages as well.

  public JavaDocComment(String comment) {
    this.comment = comment;
  }
}
