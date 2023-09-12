## 0.7.0-wip
* **Breaking Change** ([#387](https://github.com/dart-lang/jnigen/issues/387)): Added `JBuffer` and `JByteBuffer` classes as default classes for `java.nio.Buffer` and `java.nio.ByteBuffer` respectively.
* **Breaking Change**: Made the type classes `final`.
* Added `ignore_for_file: lines_longer_than_80_chars` to the generated file preamble.
* Added an explicit cast in generated `<Interface>.implement` code to allow `dart analyze` to pass when `strict-casts` is set.

## 0.6.0
* **Breaking Change** ([#131](https://github.com/dart-lang/jnigen/issues/131)): Renamed `delete*` to `release*`.
* **Breaking Change** ([#354](https://github.com/dart-lang/jnigen/issues/354)): Renamed constructors from `ctor1`, `ctor2`, ... to `new1`, `new2`, ...
* **Breaking Change**: Specifying a class always pulls in nested classes by default. If a nested class is specified in config, it will be an error.
* **Breaking Change**: Removed `suspend_fun_to_async` flag from the config. It's now happening by default since we read the Kotlin's metadata and reliably identify the `suspend fun`s.
* Fixed a bug where the nested classes would be generated incorrectly depending on the backend used for generation.
* Fixed a bug where ASM backend would produce the incorrect parent for multi-level nested classes.
* Fixed a bug where the backends would produce different descriptors for the same method.
* Added `enable_experiment` option to config.
* Created an experiment called `interface_implementation` which creates a `.implement` method for interfaces, so you can implement them using Dart.
* Save all `jnigen` logs to a file in `.dart_tool/jnigen/logs/`. This is useful for debugging.

## 0.5.0
* **Breaking Change** ([#72](https://github.com/dart-lang/jnigen/issues/72)): Removed support for `importMap` in favor of the newly added interop mechanism with importing yaml files.
* **Breaking Change** ([#72](https://github.com/dart-lang/jnigen/issues/72)): `java.util.Set`, `java.util.Map`, `java.util.List`, `java.util.Iterator` and the boxed types like `java.lang.Integer`, `java.lang.Double`, ... will be generated as their corresponding classes in `package:jni`.
* Strings now use UTF16.

## 0.4.0
* **Breaking Change** ([#145](https://github.com/dart-lang/jnigen/issues/145)): Type arguments are now named instead of positional.
* Type parameters can now be inferred when possible.
* Fixed a bug where passing a `long` argument truncated it to `int` in pure dart bindings.
* Removed array extensions from the generated code.
* Added the ability to use source dependencies from Gradle.
* Fixed an issue with the field setter.
* Fixed an issue where exceptions were not properly thrown in pure Dart bindings.

## 0.3.0
* Added the option to convert Kotlin `suspend fun` to Dart async methods. Add `suspend_fun_to_async: true` to `jnigen.yaml`.

## 0.2.0
* Support generating bindings for generics.

## 0.1.1
* Windows support for running tests and examples on development machines.

## 0.1.0
* Initial version: Basic bindings generation, maven and android utilities
