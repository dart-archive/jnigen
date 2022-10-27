// Copyright (c) 2022, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

package com.github.dart_lang.jnigen.apisummarizer;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;
import com.github.dart_lang.jnigen.apisummarizer.disasm.AsmSummarizer;
import com.github.dart_lang.jnigen.apisummarizer.doclet.SummarizerDoclet;
import com.github.dart_lang.jnigen.apisummarizer.elements.ClassDecl;
import com.github.dart_lang.jnigen.apisummarizer.util.Log;
import java.io.File;
import java.io.FileFilter;
import java.io.IOException;
import java.util.*;
import java.util.stream.Collectors;
import javax.tools.DocumentationTool;
import javax.tools.ToolProvider;
import jdk.javadoc.doclet.Doclet;
import org.apache.commons.cli.*;

public class Main {
  public enum Backend {
    DOCLET,
    ASM,
    AUTO,
  }

  private static final CommandLineParser parser = new DefaultParser();
  static SummarizerOptions config;

  public static void writeJSON(List<ClassDecl> decls) {
    var mapper = new ObjectMapper();
    Log.timed("Writing JSON");
    mapper.enable(SerializationFeature.INDENT_OUTPUT);
    mapper.setSerializationInclusion(JsonInclude.Include.NON_EMPTY);
    try {
      mapper.writeValue(System.out, decls);
    } catch (IOException e) {
      e.printStackTrace();
    }
    Log.timed("Finished");
  }

  public static void runDoclet(List<String> qualifiedNames, SummarizerOptions options) {
    runDocletWithClass(SummarizerDoclet.class, qualifiedNames, options);
  }

  public static void runDocletWithClass(
      Class<? extends Doclet> docletClass, List<String> qualifiedNames, SummarizerOptions options) {
    String[] sourcePaths = options.sourcePath.split(File.pathSeparator);
    List<File> javaFilePaths =
        qualifiedNames.stream()
            .map(s -> findSourceLocation(s, sourcePaths))
            .collect(Collectors.toList());
    Log.setVerbose(options.verbose);

    var files =
        javaFilePaths.stream()
            .flatMap(
                path -> recursiveListFiles(path, file -> file.getName().endsWith(".java")).stream())
            .map(File::getPath)
            .toArray(String[]::new);

    DocumentationTool javadoc = ToolProvider.getSystemDocumentationTool();
    var fileManager = javadoc.getStandardFileManager(null, null, null);
    var fileObjects = fileManager.getJavaFileObjects(files);

    var cli = new ArrayList<String>();
    cli.add((options.useModules ? "--module-" : "--") + "source-path=" + options.sourcePath);
    if (options.classPath != null) {
      cli.add("--class-path=" + options.classPath);
    }
    if (options.addDependencies) {
      cli.add("--expand-requires=all");
    }
    cli.addAll(List.of("-encoding", "utf8"));

    if (options.toolArgs != null) {
      cli.addAll(List.of(options.toolArgs.split(" ")));
    }

    javadoc.getTask(null, fileManager, System.err::println, docletClass, cli, fileObjects).call();
  }

  public static void main(String[] args) {
    CommandLine cl = parseArgs(args);
    config = SummarizerOptions.fromCommandLine(cl);
    switch (config.backend) {
      case ASM:
        try {
          writeJSON(AsmSummarizer.run(config.classPath.split(File.pathSeparator), cl.getArgs()));
        } catch (IOException e) {
          e.printStackTrace();
        }
        break;
      case DOCLET:
        runDoclet(List.of(cl.getArgs()), config);
        break;
      case AUTO:
        // TODO: Run doclet as default but fall back to ASM with classpath + bootclasspath.
    }
  }

  public static File findSourceLocation(String qualifiedName, String[] sourcePaths) {
    var s = qualifiedName.replace(".", "/");
    for (var folder : sourcePaths) {
      var f = new File(folder, s + ".java");
      if (f.exists() && f.isFile()) {
        return f;
      }
      var d = new File(folder, s);
      if (d.exists() && d.isDirectory()) {
        return d;
      }
    }
    throw new RuntimeException("Cannot find class: " + qualifiedName);
  }

  public static List<File> recursiveListFiles(File file, FileFilter filter) {
    if (!file.isDirectory()) {
      return List.of(file);
    }
    // list files using a breadth-first traversal
    var files = new ArrayList<File>();
    var queue = new ArrayDeque<File>();
    queue.add(file);
    while (!queue.isEmpty()) {
      var dir = queue.poll();
      var list = dir.listFiles(entry -> entry.isDirectory() || filter.accept(entry));
      if (list == null) {
        throw new IllegalArgumentException();
      }
      Arrays.sort(list);
      for (var path : list) {
        if (path.isDirectory()) {
          queue.add(path);
        } else {
          files.add(path);
        }
      }
    }
    return files;
  }

  public static CommandLine parseArgs(String[] args) {
    var options = new Options();
    Option sources = new Option("s", "sources", true, "paths to search for source files");
    Option classes = new Option("c", "classes", true, "paths to search for compiled classes");
    Option backend =
        new Option(
            "b",
            "backend",
            true,
            "backend to use for summary generation ('doclet', 'asm' or 'auto' (default)).");
    Option useModules = new Option("M", "use-modules", false, "use Java modules");
    Option recursive = new Option("r", "recursive", false, "Include dependencies of classes");
    Option moduleNames =
        new Option("m", "module-names", true, "comma separated list of module names");
    Option doctoolArgs =
        new Option("D", "doctool-args", true, "Arguments to pass to the documentation tool");
    Option verbose = new Option("v", "verbose", false, "Enable verbose output");
    for (Option opt :
        new Option[] {
          sources, classes, backend, useModules, recursive, moduleNames, doctoolArgs, verbose
        }) {
      options.addOption(opt);
    }

    HelpFormatter help = new HelpFormatter();

    CommandLine cmd;

    try {
      cmd = parser.parse(options, args);
      if (cmd.getArgs().length < 1) {
        throw new ParseException("Need to specify paths to source files");
      }
    } catch (ParseException e) {
      System.out.println(e.getMessage());
      help.printHelp(
          "java -jar <JAR> [-s <SOURCE_DIR=.>] "
              + "[-c <CLASSES_JAR>] <CLASS_OR_PACKAGE_NAMES>\n"
              + "Class or package names should be fully qualified.\n\n",
          options);
      System.exit(1);
      return null;
    }
    return cmd;
  }

  public static class SummarizerOptions {
    String sourcePath, classPath;
    boolean useModules;

    Backend backend;
    String modulesList;
    boolean addDependencies;
    String toolArgs;
    boolean verbose;

    SummarizerOptions() {}

    public static SummarizerOptions fromCommandLine(CommandLine cmd) {
      var opts = new SummarizerOptions();
      opts.sourcePath = cmd.getOptionValue("sources", ".");
      var backendString = cmd.getOptionValue("backend", "doclet");
      opts.backend = Backend.valueOf(backendString.toUpperCase());
      opts.classPath = cmd.getOptionValue("classes", null);
      opts.useModules = cmd.hasOption("use-modules");
      opts.modulesList = cmd.getOptionValue("module-names", null);
      opts.addDependencies = cmd.hasOption("recursive");
      opts.toolArgs = cmd.getOptionValue("doctool-args", null);
      opts.verbose = cmd.hasOption("verbose");
      return opts;
    }
  }
}
