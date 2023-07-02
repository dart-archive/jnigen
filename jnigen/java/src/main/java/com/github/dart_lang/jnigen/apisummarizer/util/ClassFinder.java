package com.github.dart_lang.jnigen.apisummarizer.util;

import javax.tools.JavaFileObject;
import javax.tools.StandardJavaFileManager;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.TreeSet;
import java.util.function.BiFunction;
import java.util.function.Function;
import java.util.jar.JarEntry;
import java.util.jar.JarFile;
import java.util.stream.Collectors;
import java.util.zip.ZipEntry;

public class ClassFinder {
  private static boolean isNestedClassOf(String pathString, String fqnWithSlashes, String suffix) {
    var fqnWithSlashesDollarSign = fqnWithSlashes + "$";
    if (!pathString.startsWith(fqnWithSlashesDollarSign) || !pathString.endsWith(suffix)) {
      return false;
    }
    String nested =
        pathString.substring(
            fqnWithSlashesDollarSign.length(), pathString.length() - suffix.length());
    if (nested.matches("[a-zA-Z_][a-zA-Z0-9_$]*")) {
      return true;
    }
    Log.warning("Possibly invalid path - '%s', skipping", pathString);
    return false;
  }

  public static List<Path> getNestedClassesInPathList(
      TreeSet<Path> paths, String fqnWithSlashes, String suffix) {
    return paths.tailSet(Path.of(fqnWithSlashes)).stream()
        .takeWhile(path -> isNestedClassOf(path.toString(), fqnWithSlashes, suffix))
        .collect(Collectors.toList());
  }

  public static List<String> getNestedClassesInStringList(
      TreeSet<String> paths, String fqnWithSlashes, String suffix) {
    return paths.tailSet(fqnWithSlashes).stream()
        .takeWhile(path -> isNestedClassOf(path, fqnWithSlashes, suffix))
        .collect(Collectors.toList());
  }

  public static <E> void findFilesInPath(
      String searchLocation,
      String suffix,
      Map<String, List<E>> classes,
      Function<List<Path>, List<E>> mapper) {
    Path searchPath = Path.of(searchLocation);

    TreeSet<Path> filePaths;
    try (var walk = Files.walk(searchPath)) {
      filePaths = walk.filter(Files::isRegularFile).collect(Collectors.toCollection(TreeSet::new));
    } catch (IOException e) {
      throw new RuntimeException(e);
    }

    for (var className : classes.keySet()) {
      if (classes.get(className) != null) { // Already found by other method of searching
        continue;
      }
      var fqnWithSlashes = className.replace(".", File.separator);
      var dirPath = Path.of(searchLocation, fqnWithSlashes);
      var filePath = Path.of(searchLocation, fqnWithSlashes + suffix);
      if (filePaths.contains(filePath)) {
        List<Path> resultPaths = new ArrayList<>();
        resultPaths.add(filePath);
        var filePathsWithoutSearchPathPrefix =
            filePaths.stream()
                .map(searchPath::relativize)
                .collect(Collectors.toCollection(TreeSet::new));
        List<Path> nestedClasses =
            getNestedClassesInPathList(filePathsWithoutSearchPathPrefix, fqnWithSlashes, suffix);
        resultPaths.addAll(StreamUtil.map(nestedClasses, searchPath::resolve));
        classes.put(className, mapper.apply(resultPaths));
      } else if (Files.exists(dirPath) && Files.isDirectory(dirPath)) {
        try (var walk = Files.walk(dirPath)) {
          List<Path> resultPaths =
              walk.filter(Files::isRegularFile)
                  .filter(innerPath -> innerPath.toString().endsWith(suffix))
                  .collect(Collectors.toList());
          classes.put(className, mapper.apply(resultPaths));
        } catch (IOException e) {
          throw new RuntimeException(e);
        }
      }
    }
  }

  public static <E> void findFilesInJar(
      Map<String, List<E>> classes,
      JarFile jar,
      String suffix,
      BiFunction<JarFile, List<ZipEntry>, List<E>> mapper) {
    var entries =
        jar.stream().map(JarEntry::getName).collect(Collectors.toCollection(TreeSet::new));
    for (var binaryName : classes.keySet()) {
      if (classes.get(binaryName) != null) {
        continue;
      }
      var fqnWithSlashes = binaryName.replace('.', '/');
      var filePath = fqnWithSlashes + suffix;
      if (entries.contains(filePath)) {
        // find nested classes as well
        var foundPaths = getNestedClassesInStringList(entries, fqnWithSlashes, suffix);
        var found = StreamUtil.map(foundPaths, jar::getEntry);
        found.add(jar.getEntry(filePath));
        classes.put(binaryName, mapper.apply(jar, found));
      }

      // Obtain set of all strings prefixed with relativePath + '/'
      var dirPath = fqnWithSlashes + '/';
      var children =
          entries.tailSet(dirPath).stream()
              .takeWhile(e -> e.startsWith(dirPath))
              .filter(e -> e.endsWith(suffix))
              .map(jar::getEntry)
              .collect(Collectors.toList());
      if (!children.isEmpty()) {
        var mapped = mapper.apply(jar, children);
        classes.put(binaryName, mapped);
      }
    }
  }

  public static <T> void find(
      Map<String, List<T>> classes,
      List<String> searchPaths,
      String suffix,
      Function<List<Path>, List<T>> fileMapper,
      BiFunction<JarFile, List<ZipEntry>, List<T>> entryMapper) {
    for (var searchPath : searchPaths) {
      File searchFile = new File(searchPath);
      if (searchFile.isDirectory()) {
        findFilesInPath(searchPath, suffix, classes, fileMapper);
      } else if (searchFile.isFile() && searchPath.endsWith(".jar")) {
        var jarFile = ExceptionUtil.wrapCheckedException(JarFile::new, searchPath);
        findFilesInJar(classes, jarFile, suffix, entryMapper);
      }
    }
  }

  private static List<JavaFileObject> getJavaFileObjectsFromFiles(
      List<Path> paths, StandardJavaFileManager fm) {
    var result = new ArrayList<JavaFileObject>();
    var files = StreamUtil.map(paths, Path::toFile);
    fm.getJavaFileObjectsFromFiles(files).forEach(result::add);
    return result;
  }

  private static List<JavaFileObject> getJavaFileObjectsFromJar(
      JarFile jarFile, List<ZipEntry> entries) {
    return StreamUtil.map(entries, (entry) -> new JarEntryFileObject(jarFile, entry));
  }

  private static List<InputStreamProvider> getInputStreamProvidersFromFiles(List<Path> files) {
    return StreamUtil.map(files, (path) -> new FileInputStreamProvider(path.toFile()));
  }

  private static List<InputStreamProvider> getInputStreamProvidersFromJar(
      JarFile jarFile, List<ZipEntry> entries) {
    return StreamUtil.map(entries, entry -> new JarEntryInputStreamProvider(jarFile, entry));
  }

  public static void findJavaSources(
      Map<String, List<JavaFileObject>> classes,
      List<String> searchPaths,
      StandardJavaFileManager fm) {
    find(
        classes,
        searchPaths,
        ".java",
        files -> getJavaFileObjectsFromFiles(files, fm),
        ClassFinder::getJavaFileObjectsFromJar);
  }

  public static void findJavaClasses(
      Map<String, List<InputStreamProvider>> classes, List<String> searchPaths) {
    find(
        classes,
        searchPaths,
        ".class",
        ClassFinder::getInputStreamProvidersFromFiles,
        ClassFinder::getInputStreamProvidersFromJar);
  }
}
