// Copyright (c) 2023, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

package com.github.dart_lang.jnigen.interfaces;

public interface MyInterface<T> {
  void voidCallback(String s);

  String stringCallback(String s);

  T varCallback(T t);
}
