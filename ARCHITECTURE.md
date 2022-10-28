This document explains the architecture of `jnigen` to potential developers and contributors.

## Introduction
The purpose of `jnigen` is providing a bindings generator for Java interop through JNI. It started as a GSoC 2022 project.

This repository contains two components: `package:jnigen` which is the code generator tool, and `package:jni` which is the support library for generated code.

`jnigen` is highly experimental at this moment. Basic language features like methods and exceptions are supported. The binding generation pipeline is relatively stable, and new language features will be added in future.

## Prerequisites & resources

Before reading this document, we assume you're familiar with

* User Documentation from top level [README.md](README.md). This document will not repeat the user facing documentation.

* Dart FFI and FFI Plugins

The following documents are useful:

* [JNI Specification](https://docs.oracle.com/en/java/javase/17/docs/specs/jni/)

* [JNI Tips from Android NDK](https://developer.android.com/training/articles/perf-jni). Many things about the JNI are not clear from the Spec. This document contains some useful information.

Many sections of this document assume basic familiarity with the JNI.

* [OpenJDK Doclet API](https://openjdk.org/groups/compiler/using-new-doclet.html). We use Doclet for generating API descriptions of Java libraries from java source code.

* [ASM Library User Guide](https://asm.ow2.io/asm4-guide.pdf). We use ASM for generating API descriptions from compiled JAR files.

* [Apache Maven Dependency Plugin Docs](https://maven.apache.org/plugins/maven-dependency-plugin/). We use this for fetching Java sources and JARs specified in jnigen's declarative configuration.

## `package:jni` (support library)

`package:jni` is the support library used by generated code.

It's an FFI plugin. In particular, it contains plugin classes for Android which initialize the JNI.

The initialization order differs on Android and Desktop platforms.

On Android, the Android JVM has spawned the flutter app embedding. A JVM already exists and it calls the initialization code in [JniPlugin.java](jni/android/src/main/java/com/github/dart_lang/jni/JniPlugin.java).

On other platforms, a JVM must be explicitly spawned through `Jni.spawn` call in dart. Support library contains native code which wraps JNI_CreateJavaVM.

The native code in support library also does some bookkeeping. `JNIEnv` is supposed to be thread-local whereas Dart often hides the threads. Dart has a thread-pool and it's not generally possible to keep track of threads.

Native code in `package:jni` wraps `JNIEnv *` as `GlobalJNIEnv` which keeps track of a thread-local JNIEnv, and converts JNI local references into global references.

Sometimes in future, however, we may want to support local references for efficiency.

### Some more Android quirks
On Android, flutter embedding runs on a different thread than Android UI thread. (Confusingly, it's referred to as the main thread). This means only few Java base libraries will be in the classpath of the flutter UI thread.

To counter this, we cache the reference to Android UI thread's classloader, and use it to lookup classes (instead of `FindClass`).

Flutter embedding also doesn't allow us to return from FFI when a JNI exception is pending. To counter this, we usually return a `JniResult` struct. It will contain any exceptions occurred during the call. It's checked using extension getters in Dart layer. If any exception has occurred, using some helper methods, we convert both the Java stack trace and message of the exception into dart strings, and rethrow in Dart.

### On standalone
With `Jni.spawn` it's usually necessary to specify classpaths. ClassPath is nothing but another JVM option. It has some additional code handling it in [jni.dart](jni/lib/src/jni.dart) so that classpaths can be passed as a dart list of paths.

`jni:setup` scans the packageConfig and finds JNI plugins by looking for the first line of `CMakeLists.txt`. It should be identical to that of [jni/src/CMakeLists.txt](jni/src/CMakeLists.txt). `jnigen` ensures this while generating the CMake configuration for generated bindings.

### Bindings to `jni.h`
`package:jni` also contains some automatically generated bindings to `jni.h`. This header file is taken from Android NDK and annotated with some parameter names. The bindings are generated using a patched and vendored version of `ffigen`. The main purpose of the patch is to generate extension methods for function pointer fields. We use this idiom in both `GlobalJniEnv` and `JniAccessors` types. It also hides some pointless methods, for instance the ones taking `va_list` parameters.

### CMake configuration
CMake configuration for `package:jni` is pretty simple. It uses CMakes builtin detection of JNI libraries. Only thing worth noting is the `DELAYLOAD` flag when linking `jvm.dll` on Windows.

## ApiSummarizer
ApiSummarizer is an important component of `jnigen`. It's a pretty standard maven Java project. We use `assembly` plugin for building a runnable JAR. The confusing details of building it are in the dart code! It generates an API tree in JSON format.

ApiSummarizer contains 2 "back-ends". Doclet is OpenJDK's API which enables us to plug into JavaDoc tool, and create description of the public API provided by source. We use ToolProvider API so that we can invoke JavaDoc in-process rather than as external command.

Most of ApiSummarizer is pretty boring methods, which scan the JavaDoc's representation of the API, and serialize it into a tree of plain data types. This can be easily written to stdout using jackson-databind. On the dart side, we have [elements.dart](jnigen/lib/src/elements/elements.dart) which defines the same structures. JSON deserialization code is generated using `json_serializable` code generation package.

We use JSON because it was easier to use for data classes during development. Maybe in distant future this can be converted to use JNI itself.

### Finding java classes in ApiSummarizer
A heuristic is used: In a standard java package layout, `a.b.C` is always `a/b/C.java` in source path, and package `a.b` always corresponds to directory `a/b`. ApiSummarizer recursively lists the .java files under a package using breadth first traversal. Each level's listing is sorted so that the order is deterministic.

It's a convention followed by almost every java library, but it's not enforced (technically). So `a/b/C.java` may declare its package as `package x.y;`. In such a case, a.b.C will map to `a/b/C.java` but the processed information will include the class under its actual package(`x.y`), and not `a.b`.

Similar logic is used in ASM to find class files.

### Doclet API quirks
Doclet as exposed by `ToolProvider` doesn't really allow to return information meaningfully from the doclet. Apparently, it's just a thin wrapper around calling `javadoc` tool's `public static void main`. Since we run single threaded, what we currently do is store the processed class declarations in a static field.

In integration test, we have a sample JSON file. We generate another JSON file from by calling Main.main with args. And compare it using `git diff --no-index`. This is the same strategy we use in `jnigen` tests to compare generated bindings.

### Formatting
All Java files should be formatted with [google-java-format](https://github.com/google/google-java-format/), including the examples committed in jnigen tests.

`google-java-format` can be installed using `scoop` on windows and `homebrew` on MacOS. On Linux, you can download the JAR and write a shell script like this:

```sh
#!/bin/sh
java -jar ~/.local/path_to_jar/google-java-format.jar $@
```
There's a plugin available for IntelliJ.

The command line JAR apparently needs a manual listing of java files, and does not process directories recursively. You can use something like `$(find jnigen/java/ -name *.java)` as an argument when running from shell.

See [google-java-format#129](https://github.com/google/google-java-format/issues/129).

## `package:jnigen`
This is the component which generates the bindings. It invokes summarizer, ([summary.dart](jnigen/lib/src/summary/summary.dart)), and processes each class to generate bindings.

### Preprocessing
Before being passed to one of the `BindingsGenerator` classes, class declaration structs are _preprocessed_. Preprocessingassigns a shorter name (which can also be final visible name in `single_file` config). Shorter name is the simple name of the class + optionally a number to disambiguate naming conflicts. This leads to shorter bindings than using FQN, while still being pretty deterministic (due to sorting in the summarizer). Additionally, in practice, Java libraries do not have many colliding names, because Java classes are also imported unqualified.

Preprocessing also renames methods (since dart doesn't support overloading). Ad-hoc overloading can lead to a methods signature being different than the same-named method in its superclass - which is an error. We actually do some circus to prevent this. We save java signature of each method as a string, which is a unique representation. Now it's possible to have a map per class of these methods and their associated disambiguating numbers. By ensuring the superclass is sorted before subclass, we ensure methods with same signature get the same number. (Sounds like topological sort, but actually it's not needed. We just lazily preprocess the parent and mark it as preprocessed.)

### File mapping
Depending on `output` >> `dart` >> `structure` key in config, output can be package structured or single file. In package structure, the original source is mirrored, with each top level class being mapped to a separate dart file. An `_init.dart` file will be created to hold common variables. In each package, `_package.dart` file will be created, which exports all classes directly (__not transitively__) in the package. This is equivalent of the wildcard import in Java.

Note that even in package structure mode, nested classes will be in the same file as their parent class, and not separate file. Nested classes will be renamed using an underscore. `A$B` becomes `A_B`.

In single file mode, all classes will be written to a single dart file, and renamed if required.

There are 2 separate writer classes ([FilesWriter](jnigen/lib/src/writers/files_writer.dart) and [SingleFileWriter](jnigen/lib/src/single_file_writer.dart)) for each strategy. They descend from same abstract class and share some code.

Similarly, for both binding types, (`c_based` and `pure_dart`), there are `BindingsGenerator` subclasses which provide an identical interface. The pre and post import boilerplates differ based on binding type, which is provided by overridden methods.

### Resolution
A method signature, or a class declaration (in form of an `extends` clause), can refer to other classes. If the class is included in the same `jnigen` config, the generated code should refer to that class. Otherwise it should fall back to `JniObject`.

Resolution process is different for single file and package structured bindings. In case of single file bindings, using the final name of the referred class is sufficient. In package structured bindings, the following is an abstract description of algorithm is used to resolve shortest path to class B from class A.

```
1. let A' and B' be the directories containing A and B. split A' and B' into path segment lists.

2. common := length(common prefix of A' and B').

3. pathToCommon = "../" * (A'.length - common)

4. pathToDestFromCommon = dest[common:] join by '/'

5. return pathToCommon + pathToDestFromCommon
```

The implementation in [files_writer.dart](jnigen/lib/src/writers/files_writer.dart) is slightly different from the above abstract description.

Interop with other `jnigen` bindings, by generating a YAML symbols file is planned. [#72](https://github.com/dart-lang/jnigen/issues/72). This should follow the same design as implemented in `ffigen`.

## Tests
Most tests generate bindings and compare them with existing bindings. All use an `generateAndCompareBindings` primitive, which takes a config, generates bindings into a temporary directory, and compares with reference bindings. (Which are committed in the repository).

Some tests generate complete bindings for large libraries like `jackson_core` and run `dart analyze`, to ensure that code generator is not creating any naming conflicts.

[simple_package_test](jnigen/test/simple_package_test) contains a simple java class and generates bindings for it. If you implement support for a language feature, you can add a function to Example class and test it.

`bindings_test.dart` imports the committed bindings and runs some tests on them. Add a test here when you add a language feature.

There are also additional checks in CI which build / run the [examples](jnigen/example/).

## Regenerating reference bindings after a code generator change
If you change something that affects the generated code, run `dart run tool/regenerate_all_bindings.dart` from `jnigen/` directory. This will update the bindings accordingly.

## Pre-PR checks
You can run the script [jnigen/tool/pr_checks.dart](jnigen/tool/pr_checks.dart) before submitting a PR. It locally runs a subset of checks we run in CI. Some of these are run in cloned directory by default. But android-related examples are always checked in project directory, and assume you have run `flutter build apk` before in both android example directories (`jnigen/example/in_app_java` and `jnigen/example/notification_plugin/example`, which is required for gradle-related features of jnigen.

Note: The script is concurrent and CPU usage may peak for a brief duration of time.

