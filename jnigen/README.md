# Experimental generator for FFI+JNI bindings.

This package will generate JNI code to invoke Java from C, and Dart FFI bindings to invoke this C code.
This enables calling Java code from Dart.

This is a GSoC 2022 project.

Currently this package is highly experimental and proof-of-concept. [examples/](examples) and [jackson_core_test](test/jackson_core_test) for some usage examples. It is possible to specify some dependencies to be downloaded automatically through `maven`. When targetting Android, it's also possible to generate bindings for custom code depending on Android libraries.

Basic features of the Java language (static and instance methods, fields, constructors) are supported in generated bindings.

## Basics
### Running `jnigen`
There are 2 ways to use `jnigen`:

* Run as command line tool with a YAML config.
* Import `package:jnigen/jnigen.dart` from a script in `tool/` directory of your project.

Both approaches are almost identical. When using YAML, it's possible to selectively override configuration properties with command line, using `-Dproperty.name=value` syntax.

### Generated bindings
Generated bindings will consist of 2 parts - C bindings which call JNI, and Dart bindings which call C bindings. The generated bindings will depend on `package:jni` for instantiating / obtaining a JVM instance.

The following properties must be specified in yaml.

* `c_root`: root folder to write generated C bindings.
* `dart_root`: root folder to write generated Dart bindings (see below).
* `library_name`: specifies name of the generated library in CMakeFiles.txt.

The generated C file has to be linked to JNI libraries. Therefore a CMake configuration is always generated which builds the generated code as shared library. The `init.dart` in generated dart code loads the library on first time a method is accessed. On dart standalone, it will be loaded from the same directory specified in `Jni.spawn` call.

## Examples
Few runnable examples are provided in [examples/](examples/) directory. (Re)generate the bindings by running `dart run jnigen --config jnigen.yaml` in the root of the respective examples. Corresponding README files contain more information about the examples.

