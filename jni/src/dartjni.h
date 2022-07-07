#include <stdint.h>
#include <stdio.h>
#include <jni.h>
#include <stdlib.h>

#if _WIN32
#include <windows.h>
#else
#include <pthread.h>
#include <unistd.h>
#endif

#if _WIN32
#define FFI_PLUGIN_EXPORT __declspec(dllexport)
#else
#define FFI_PLUGIN_EXPORT
#endif

enum DartJniLogLevel {
	JNI_VERBOSE = 2, JNI_DEBUG, JNI_INFO, JNI_WARN, JNI_ERROR
};

FFI_PLUGIN_EXPORT JavaVM *GetJavaVM();

FFI_PLUGIN_EXPORT JNIEnv *GetJniEnv();

FFI_PLUGIN_EXPORT JNIEnv *SpawnJvm(JavaVMInitArgs *args);

FFI_PLUGIN_EXPORT jclass LoadClass(const char *name);

FFI_PLUGIN_EXPORT jobject GetClassLoader();

FFI_PLUGIN_EXPORT jobject GetApplicationContext();

FFI_PLUGIN_EXPORT jobject GetCurrentActivity();

FFI_PLUGIN_EXPORT void SetJNILogging(int level);

