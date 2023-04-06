// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

package com.github.dart_lang.jnigen.generics;

import java.util.Stack;

public class MyStack<T> {
  private Stack<T> stack;

  public MyStack() {
    stack = new Stack<>();
  }

  public static <T> MyStack<T> of() {
    return new MyStack<>();
  }

  public static <T> MyStack<T> of(T obj) {
    var stack = new MyStack<T>();
    stack.push(obj);
    return stack;
  }

  public static <T> MyStack<T> of(T obj, T obj2) {
    var stack = new MyStack<T>();
    stack.push(obj);
    stack.push(obj2);
    return stack;
  }

  public void push(T item) {
    stack.push(item);
  }

  public T pop() {
    return stack.pop();
  }
}
