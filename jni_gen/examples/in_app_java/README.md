# in_app_java

Minimal example on how to integrate java and dart code in flutter project using `jni_gen`.

#### How to run this example:
* Run `dart run jni_gen --config jnigen.yaml`

* `flutter run`

#### General steps:
* Write Java code in suitable package folder, under `android/` subproject of the flutter app.

* Create A jnigen config like `jnigen.yaml` in this example.

* Generate bindings using jnigen config.

* Add an `externalNativeBuild` to gradle script (see `android/app/build.gradle` in this example).

* Add proguard rules to exclude your custom classes from tree shaking, since they are always accessed reflectively in JNI.

* Build and run the app.

#### Caveats
It's possible to use only android core libraries in the Java code. See [#33](https://github.com/dart-lang/jni_gen/issues/33) for more details. We have plans to add some tooling to make working with android gradle dependencies easier.

