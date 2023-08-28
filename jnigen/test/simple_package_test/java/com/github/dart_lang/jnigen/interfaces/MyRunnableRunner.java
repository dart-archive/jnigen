// Copyright (c) 2023, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

package com.github.dart_lang.jnigen.interfaces;

import static com.github.dart_lang.jnigen.interfaces.MyInterfaceConsumer.consumeOnSameThread;

public class MyRunnableRunner {
  final MyRunnable runnable;

  public MyRunnableRunner(MyRunnable runnable) {
    this.runnable = runnable;
  }

  public void runOnSameThread() {
    runnable.run();
  }

  public void runOnAnotherThread() {
    var thread = new Thread(this::runOnSameThread);
    thread.start();
  }
}
