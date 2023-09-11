## 0.7.0-wip
* **Breaking Change** ([#387](https://github.com/dart-lang/jnigen/issues/387)): Added `JBuffer` and `JByteBuffer` classes as default classes for `java.nio.Buffer` and `java.nio.ByteBuffer` respectively.
* Fixed a bug where `addAll`, `removeAll` and `retainAll` in `JSet` would run their respective operation twice.
* Fixed a bug where `JList.insertAll` would not throw the potentially thrown Java exception.

## 0.6.1
* Depend on the stable version of Dart 3.1.

## 0.6.0
* **Breaking Change** ([#131](https://github.com/dart-lang/jnigen/issues/131)): Renamed `delete*` to `release*`.
* Added `PortProxy` and related methods used for interface implementation.
* Added the missing binding for `java.lang.Character`.

## 0.5.0
* **Breaking Change** ([#137](https://github.com/dart-lang/jnigen/issues/137)): Java primitive types are now all lowercase like `jint`, `jshort`, ...
* The bindings for `java.util.Set`, `java.util.Map`, `java.util.List` and the numeric types like `java.lang.Integer`, `java.lang.Boolean`, ... are now included in `package:jni`.

## 0.4.0
* Type classes now have `superCount` and `superType` getters used for type inference.

## 0.3.0
* Added `PortContinuation` used for `suspend fun` in Kotlin.
* `dartjni` now depends on `dart_api_dl.h`.

## 0.2.1
* Added `.clang-format` to pub.

## 0.2.0
* Added array support
* Added generic support
* `JniX` turned into `JX` for a more terse code.

## 0.1.1
* Windows support for running tests and examples on development machines.

## 0.1.0
* Initial version: Android and Linux support, JObject API

