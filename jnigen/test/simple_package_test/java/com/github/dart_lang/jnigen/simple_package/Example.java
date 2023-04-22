// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

package com.github.dart_lang.jnigen.simple_package;

import java.util.*;

public class Example {
  // static fields - primitive & string
  public static final int ON = 1;
  public static final int OFF = 0;
  public static final double PI = 3.14159;
  public static final char SEMICOLON = ';';
  public static final String SEMICOLON_STRING = ";";

  // static fields - non-final primitive & string
  public static int amount = 500;
  public static double pi = 3.14159;
  public static char asterisk = '*';
  public static String name = "Ragnar Lothbrok";

  // Static fields - object
  public static Aux aux;

  // static methods
  public static int getAmount() {
    return amount;
  }

  public static double getPi() {
    return pi;
  }

  public static char getAsterisk() {
    return asterisk;
  }

  public static String getName() {
    return name;
  }

  // void functions with 1 parameter
  public static void setAmount(int newAmount) {
    amount = newAmount;
  }

  public static void setName(String newName) {
    name = newName;
  }

  // void functions with many parameters
  public static int max4(int a, int b, int c, int d) {
    return Integer.max(Integer.max(a, b), Integer.max(c, d));
  }

  public static int max8(int a, int b, int c, int d, int e, int f, int g, int h) {
    return Integer.max(max4(a, b, c, d), max4(e, f, g, h));
  }

  // Instance fields - primitive and string

  public long trillion = 1024L * 1024L * 1024L * 1024L;
  public boolean isAchillesDead = false;
  public String bestFighterInGreece = "Achilles";

  // Instance fields - object
  public Random random = new Random();

  // Instance methods
  public long getTrillion() {
    return trillion;
  }

  public boolean isAchillesAlive() {
    return !isAchillesDead;
  }

  public String whoIsBestFighterInGreece() {
    return bestFighterInGreece;
  }

  public Random getRandom() {
    return random;
  }

  public long getRandomLong() {
    return random.nextLong();
  }

  public long add4Longs(long a, long b, long c, long d) {
    return a + b + c + d;
  }

  public long add8Longs(long a, long b, long c, long d, long e, long f, long g, long h) {
    return a + b + c + d + e + f + g + h;
  }

  public String getRandomNumericString(Random random) {
    return String.format(
        "%d%d%d%d", random.nextInt(10), random.nextInt(10), random.nextInt(10), random.nextInt(10));
  }

  private int internal = 0;

  public Example() {}

  public Example(int internal) {
    this.internal = internal;
  }

  public static int num;

  static {
    aux = new Aux(true);
    num = 121;
  }

  public int whichExample() {
    return 0;
  }

  public static Aux getAux() {
    return aux;
  }

  public static int addInts(int a, int b) {
    return a + b;
  }

  public static int[] getArr() {
    return new int[] {1, 2, 3};
  }

  public static int addAll(int[] arr) {
    return Arrays.stream(arr).sum();
  }

  public Example getSelf() {
    return this;
  }

  public int getNum() {
    return num;
  }

  public void setNum(int num) {
    this.num = num;
  }

  public int getInternal() {
    return internal;
  }

  public void setInternal(int internal) {
    this.internal = internal;
  }

  public static void throwException() {
    throw new RuntimeException("Hello");
  }

  public static class Aux {
    public boolean value;

    public Aux(boolean value) {
      this.value = value;
    }

    public boolean getValue() {
      return value;
    }

    public void setValue(boolean value) {
      this.value = value;
    }
  }
}
