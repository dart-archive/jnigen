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
  private final long port;
  private final Map<String, ArrayBlockingQueue<Object>> map;

  private PortProxy(long port) {
    this.port = port;
    this.map = new ConcurrentHashMap<>();
  }

  private BlockingQueue<Object> queueOf(String key) {
    if (!map.containsKey(key)) {
      map.put(key, new ArrayBlockingQueue<>(1));
    }
    return map.get(key);
  }

  public static Object newInstance(String binaryName, long port) throws ClassNotFoundException {
    Class clazz = Class.forName(binaryName);
    return Proxy.newProxyInstance(
        clazz.getClassLoader(), clazz.getInterfaces(), new PortProxy(port));
  }

  @Override
  public Object invoke(Object proxy, Method method, Object[] args) throws Throwable {
    String uuid = UUID.randomUUID().toString();
    _invoke(port, uuid, proxy, method, args);
    return queueOf(uuid).poll(10, TimeUnit.SECONDS);
  }

  public void resultFor(String uuid, Object object) {
    queueOf(uuid).offer(object);
  }

  private native void _invoke(long port, String uuid, Object proxy, Method method, Object[] args);
}
