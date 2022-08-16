package com.github.hegde.mahesh.apisummarizer.util;

public class Log {
  private static long lastPrinted = System.currentTimeMillis();

  public static void setVerbose(boolean verbose) {
    Log.verboseLogs = verbose;
  }

  private static boolean verboseLogs = false;

  public static void verbose(String format, Object... args) {
    if (!verboseLogs) {
      return;
    }
    System.err.printf(format + "\n", args);
  }

  public static void timed(String format, Object... args) {
    long now = System.currentTimeMillis();
    System.err.printf("[%6d ms] ", now - lastPrinted);
    lastPrinted = now;
    System.err.printf(format + "\n", args);
  }

  public static void always(String format, Object... args) {
    System.err.printf(format + "\n", args);
  }
}
