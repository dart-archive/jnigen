# notif_plugin

Example of android plugin project with jni_gen.

This plugin project contains [custom code](android/src/main/java/com/example/notif_plugin) which uses the Android libraries. The bindings are generated using [jnigen config](jnigen.yaml) and then used in [flutter example](example/lib/main.dart), with help of `package:jni` APIs.

The command to regenerate JNI bindings is:
```
flutter run jni_gen --config jnigen.yaml # run from notif_plugin project root 
```

The `example/` app must be built at least once in _release_ mode (eg `flutter build apk`) before running jni_gen. This is the equivalent of Gradle Sync in Android Studio, and enables `jni_gen` to run a Gradle stub and determine release build's classpath, which contains the paths to relevant dependencies. Therefore a build must have been run after cleaning build directories, or updating Java dependencies. This is a known complexity of the Gradle build system, and if you know a solution, please contribute to issue discussion at #33.

