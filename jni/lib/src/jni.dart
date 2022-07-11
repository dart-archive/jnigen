import 'dart:ffi';
import 'dart:io';

import 'package:ffi/ffi.dart';
import 'package:path/path.dart';

import 'third_party/jni_bindings_generated.dart';
import 'extensions.dart';
import 'jvalues.dart';

import 'jni_object.dart';
import 'jni_class.dart';

part 'direct_methods_generated.dart';

String _getLibraryFileName(String base) {
  if (Platform.isLinux || Platform.isAndroid) {
    return "lib$base.so";
  } else if (Platform.isWindows) {
    return "$base.dll";
  } else if (Platform.isMacOS) {
    // TODO: Is this correct?
    return "$base.framework/$base";
  } else {
    throw Exception("cannot derive library name: unsupported platform");
  }
}

/// Load Dart-JNI Helper library.
///
/// If path is provided, it's used to load the library.
/// Else just the platform-specific filename is passed to DynamicLibrary.open
DynamicLibrary _loadJniHelpersLibrary(
    {String? dir, String baseName = "dartjni"}) {
  final fileName = _getLibraryFileName(baseName);
  final libPath = (dir != null) ? join(dir, fileName) : fileName;
  final dylib = DynamicLibrary.open(libPath);
  return dylib;
}

/// Jni represents a single running JNI instance.
///
/// It provides convenience functions for looking up and invoking functions
/// without several FFI conversions.
///
/// You can also get access to instance of underlying JavaVM and JniEnv, and
/// then use them in a way similar to JNI C++ API.
class Jni {
  final JniBindings _bindings;

  Jni._(this._bindings);

  static Jni? _instance;

  /// Returns the existing Jni object.
  ///
  /// If not running on Android and no Jni is spawned
  /// using Jni.spawn(), throws an exception.
  ///
  /// On Dart standalone, when calling for the first time from
  /// a new isolate, make sure to pass the library path.
  static Jni getInstance() {
    // TODO: Throw appropriate error on standalone target.
    // if helpers aren't loaded using spawn() or load().

    // TODO: There may be still some edge cases not handled here.
    if (_instance == null) {
      final inst = Jni._(JniBindings(_loadJniHelpersLibrary()));
      if (inst.getJavaVM() == nullptr) {
        throw Exception("Fatal: No JVM associated with this process!"
            " Did you call Jni.spawn?");
      }
      // If no error, save this singleton.
      _instance = inst;
    }
    return _instance!;
  }

  /// Initialize instance from custom helper library path.
  ///
  /// On dart standalone, call this in new isolate before
  /// doing getInstance().
  ///
  /// (The reason is that dylibs need to be loaded in every isolate.
  /// On flutter it's done by library. On dart standalone we don't
  /// know the library path.)
  static void load({required String helperDir}) {
    if (_instance != null) {
      throw Exception('Fatal: a JNI instance already exists in this isolate');
    }
    final inst = Jni._(JniBindings(_loadJniHelpersLibrary(dir: helperDir)));
    if (inst.getJavaVM() == nullptr) {
      throw Exception("Fatal: No JVM associated with this process");
    }
    _instance = inst;
  }

  /// Spawn an instance of JVM using JNI.
  /// This instance will be returned by future calls to [getInstance]
  ///
  /// [helperDir] is path of the directory where the wrapper library is found.
  /// This parameter needs to be passed manually on __Dart standalone target__,
  /// since we have no reliable way to bundle it with the package.
  ///
  /// [jvmOptions], [ignoreUnrecognized], & [jniVersion] are passed to the JVM.
  /// Strings in [classPath], if any, are used to construct an additional
  /// JVM option of the form "-Djava.class.path={paths}".
  static Jni spawn({
    String? helperDir,
    int logLevel = JniLogLevel.JNI_INFO,
    List<String> jvmOptions = const [],
    List<String> classPath = const [],
    bool ignoreUnrecognized = false,
    int jniVersion = JNI_VERSION_1_6,
  }) {
    if (_instance != null) {
      throw Exception("Currently only 1 VM is supported.");
    }
    final dylib = _loadJniHelpersLibrary(dir: helperDir);
    final inst = Jni._(JniBindings(dylib));
    _instance = inst;
    inst._bindings.SetJNILogging(logLevel);
    final jArgs = _createVMArgs(
      options: jvmOptions,
      classPath: classPath,
      version: jniVersion,
      ignoreUnrecognized: ignoreUnrecognized,
    );
    inst._bindings.SpawnJvm(jArgs);
    _freeVMArgs(jArgs);
    return inst;
  }

  static Pointer<JavaVMInitArgs> _createVMArgs({
    List<String> options = const [],
    List<String> classPath = const [],
    bool ignoreUnrecognized = false,
    int version = JNI_VERSION_1_6,
  }) {
    final args = calloc<JavaVMInitArgs>();
    if (options.isNotEmpty || classPath.isNotEmpty) {
      var length = options.length;
      var count = length + (classPath.isNotEmpty ? 1 : 0);

      final optsPtr = (count != 0) ? calloc<JavaVMOption>(count) : nullptr;
      args.ref.options = optsPtr;
      for (int i = 0; i < options.length; i++) {
        optsPtr.elementAt(i).ref.optionString = options[i].toNativeChars();
      }
      if (classPath.isNotEmpty) {
        final classPathString = classPath.join(Platform.isWindows ? ';' : ":");
        optsPtr.elementAt(count - 1).ref.optionString =
            "-Djava.class.path=$classPathString".toNativeChars();
      }
      args.ref.nOptions = count;
    }
    args.ref.ignoreUnrecognized = ignoreUnrecognized ? 1 : 0;
    args.ref.version = version;
    return args;
  }

  static void _freeVMArgs(Pointer<JavaVMInitArgs> argPtr) {
    if (argPtr.ref.nOptions != 0) {
      calloc.free(argPtr.ref.options);
    }
    calloc.free(argPtr);
  }

  /// Returns pointer to current JNI JavaVM instance
  Pointer<JavaVM> getJavaVM() {
    return _bindings.GetJavaVM();
  }

  /// Returns JniEnv* associated with current thread.
  ///
  /// Do not reuse JniEnv between threads, it's only valid
  /// in the thread it is obtained.
  Pointer<JniEnv> getEnv() {
    return _bindings.GetJniEnv();
  }

  void setJniLogging(int loggingLevel) {
    _bindings.SetJNILogging(loggingLevel);
  }

  /// Returns current application context on Android.
  JObject getCachedApplicationContext() {
    return _bindings.GetApplicationContext();
  }

  /// Returns current activity
  JObject getCurrentActivity() {
    return _bindings.GetCurrentActivity();
  }

  /// Get the initial classLoader of the application.
  ///
  /// This is especially useful on Android, where
  /// JNI threads cannot access application classes using
  /// the usual `JniEnv.FindClass` method.
  JObject getApplicationClassLoader() {
    return _bindings.GetClassLoader();
  }

  /// Returns class reference found through system-specific mechanism
  JClass findClass(String qualifiedName) {
    var nameChars = qualifiedName.toNativeChars();
    final cls = _bindings.LoadClass(nameChars);
    calloc.free(nameChars);
    return cls;
  }

  /// Returns class for [qualifiedName] found by platform-specific mechanism.
  ///
  /// TODO: Determine when to use class loader, and when FindClass
  /// TODO: This isn't consistent with other methods, eg: getCurrentActivity,
  /// which do not wrap reference in JniObject. But the way it's used most of
  /// the time, we need a direct method.
  JniClass findJniClass(String qualifiedName) {
    var nameChars = qualifiedName.toNativeChars();
    final cls = _bindings.LoadClass(nameChars);
    final env = getEnv();
    env.checkException();
    calloc.free(nameChars);
    return JniClass.of(env, cls);
  }

  /// Constructs an instance of class with given args.
  ///
  /// Use it when you only need one instance, but not the actual class
  /// nor any constructor / static methods.
  JniObject newInstance(
      String qualifiedName, String ctorSignature, List<dynamic> args) {
    final nameChars = qualifiedName.toNativeChars();
    final sigChars = ctorSignature.toNativeChars();
    final env = getEnv();
    final cls = _bindings.LoadClass(nameChars);
    if (cls == nullptr) {
      env.checkException();
    }
    final ctor = env.GetMethodID(cls, ctorLookupChars, sigChars);
    if (ctor == nullptr) {
      env.checkException();
    }
    final jvArgs = JValueArgs(args, env);
    final obj = env.NewObjectA(cls, ctor, jvArgs.values);
    calloc.free(jvArgs.values);
    jvArgs.disposeIn(env);
    calloc.free(nameChars);
    calloc.free(sigChars);
    return JniObject.of(env, obj, cls);
  }

  /// Wraps a JObject ref in a JniObject.
  /// The original ref is stored in JniObject, and
  /// deleted with the latter's [delete] method.
  JniObject wrap(JObject obj) {
    return JniObject.of(getEnv(), obj, nullptr);
  }

  /// Wraps a JObject ref in a JniObject.
  /// The original ref is stored in JniObject, and
  /// deleted with the latter's [delete] method.
  JniClass wrapClass(JClass cls) {
    return JniClass.of(getEnv(), cls);
  }

  /// Converts passed arguments to JValue array
  /// for use in methods that take arguments.
  ///
  /// int, bool, double and JObject types are converted out of the box.
  /// wrap values in types such as [JValueLong]
  /// to convert to other primitive types instead.
  static Pointer<JValue> jvalues(List<dynamic> args,
      {Allocator allocator = calloc}) {
    return toJValues(args, allocator: allocator);
  }
}
