// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

package com.github.dart_lang.jni;

import kotlin.coroutines.Continuation;
import kotlin.coroutines.CoroutineContext;
import kotlinx.coroutines.Dispatchers;
import org.jetbrains.annotations.NotNull;

public class PortContinuation<T> implements Continuation<T> {
  static {
    System.loadLibrary("dartjni");
  }

  private final long port;

  public PortContinuation(long port) {
    System.out.println("Setting up cont. w/ port #" + port);
    this.port = port;
  }

  @NotNull
  @Override
  public CoroutineContext getContext() {
    return (CoroutineContext) Dispatchers.getIO();
  }

  @Override
  public void resumeWith(@NotNull Object o) {
    System.out.println("Resume with called on port #" + port);
    _resumeWith(port, o);
    System.out.println("Called native function on port #" + port);
  }

  private native void _resumeWith(long port, Object result);
}
