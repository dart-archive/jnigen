// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

package com.github.dart_lang.jni;

import java.lang.reflect.*;
import java.util.Map;
import java.util.UUID;
import java.util.concurrent.ArrayBlockingQueue;
import java.util.concurrent.BlockingQueue;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.TimeUnit;

public class PortProxy implements InvocationHandler {
  static {
    System.loadLibrary("dartjni");
  }

  private final long port;
  private final long threadId;

  private PortProxy(long port, long threadId) {
    this.port = port;
    this.threadId = threadId;
  }

  private static String getDescriptor(Method method) {
    StringBuilder descriptor = new StringBuilder();
    descriptor.append(method.getName()).append("(");
    Class<?>[] parameterTypes = method.getParameterTypes();
    for (Class<?> paramType : parameterTypes) {
      appendType(descriptor, paramType);
    }
    descriptor.append(")");
    appendType(descriptor, method.getReturnType());
    return descriptor.toString();
  }

  private static void appendType(StringBuilder descriptor, Class<?> type) {
    if (type == void.class) {
      descriptor.append("V");
    } else if (type == boolean.class) {
      descriptor.append("Z");
    } else if (type == byte.class) {
      descriptor.append("B");
    } else if (type == char.class) {
      descriptor.append("C");
    } else if (type == short.class) {
      descriptor.append("S");
    } else if (type == int.class) {
      descriptor.append("I");
    } else if (type == long.class) {
      descriptor.append("J");
    } else if (type == float.class) {
      descriptor.append("F");
    } else if (type == double.class) {
      descriptor.append("D");
    } else if (type.isArray()) {
      descriptor.append('[');
      appendType(descriptor, type.getComponentType());
    } else {
      descriptor.append("L").append(type.getName().replace('.', '/')).append(";");
    }
  }

  public static Object newInstance(String binaryName, long port, long threadId) throws ClassNotFoundException {
    Class clazz = Class.forName(binaryName);
    return Proxy.newProxyInstance(clazz.getClassLoader(), new Class[]{clazz}, new PortProxy(port, threadId));
  }

  @Override
  public Object invoke(Object proxy, Method method, Object[] args) throws Throwable {
    return _invoke(port, threadId, proxy, getDescriptor(method), args);
  }

  private native Object _invoke(
    long port, long threadId, Object proxy, String methodDescriptor, Object[] args);
}
