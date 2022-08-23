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

package com.github.dart_lang.jni_gen.apisummarizer.elements;

import java.util.HashMap;
import java.util.Map;

public class JavaAnnotation {
  public String simpleName;
  public String binaryName;
  public Map<String, Object> properties = new HashMap<>();

  public static class EnumVal {
    String enumClass;
    String value;

    public EnumVal(String enumClass, String value) {
      this.enumClass = enumClass;
      this.value = value;
    }
  }
}
