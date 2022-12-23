// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

package com.github.dart_lang.jni;

import androidx.annotation.Keep;
import androidx.annotation.NonNull;
import kotlin.coroutines.Continuation;
import kotlin.coroutines.CoroutineContext;
import kotlinx.coroutines.Dispatchers;

@Keep
public class PortContinuation implements Continuation {
  static {
    System.loadLibrary("dartjni");
  }

  private long port;

  public PortContinuation(long port) {
    this.port = port;
  }

  @NonNull
  @Override
  public CoroutineContext getContext() {
    return (CoroutineContext) Dispatchers.getIO();
  }

  @Override
  public void resumeWith(Object o) {
    _resumeWith(port, o);
  }

  private native void _resumeWith(long port, Object result);
}
