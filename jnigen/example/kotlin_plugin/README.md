# kotlin_example

This example generates bindings for a Kotlin-based library. It showcases the conversion of `suspend fun` in Kotlin to `async` functions in Dart.

The command to regenerate JNI bindings is:
```
flutter pub run jnigen --config jnigen.yaml # run from datastore project root 
```

The `example/` app must be built at least once in _release_ mode (eg `flutter build apk`) before running jnigen. This is the equivalent of Gradle Sync in Android Studio, and enables `jnigen` to run a Gradle stub and determine release build's classpath, which contains the paths to relevant dependencies. Therefore a build must have been run after cleaning build directories, or updating Java dependencies. This is a known complexity of the Gradle build system, and if you know a solution, please contribute to issue discussion at #33.

Note that `jnigen.yaml` of this example contains the option `suspend_fun_to_async: true`. This will generate `async` method bindings from Kotlin's `suspend fun`s.

For Kotlin coroutines to work, you must first run `Jni.initDLApi();`.
