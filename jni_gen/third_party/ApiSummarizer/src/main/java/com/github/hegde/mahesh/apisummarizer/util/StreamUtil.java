package com.github.hegde.mahesh.apisummarizer.util;

import java.util.Arrays;
import java.util.List;
import java.util.function.Function;
import java.util.stream.Collectors;

public class StreamUtil {
  public static <T, R> List<R> map(List<T> list, Function<T, R> function) {
    return list.stream().map(function).collect(Collectors.toList());
  }

  public static <T, R> List<R> map(T[] array, Function<T, R> function) {
    return Arrays.stream(array).map(function).collect(Collectors.toList());
  }
}
