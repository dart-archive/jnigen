// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

#include <jni.h>
#include <stdint.h>
#include <stdarg.h>

#include "dartjni.h"

// Context and shared global state. Initialized once or if thread-local, initialized once in a thread.
JniContext jni = {NULL, NULL, NULL, NULL, NULL};

thread_local JNIEnv *jniEnv = NULL;

/// Get JVM associated with current process.
/// Returns NULL if no JVM is running.
FFI_PLUGIN_EXPORT
JavaVM *GetJavaVM() { return jni.jvm; }

/// Load class through platform-specific mechanism.
///
/// Currently uses application classloader on android,
/// and JNIEnv->FindClass on other platforms.
FFI_PLUGIN_EXPORT
jclass LoadClass(const char *name) {
	jclass cls = NULL;
	attach_thread();
	load_class(&cls, name);
	return to_global_ref(cls);
};

// Android specifics

/// Returns Application classLoader (on Android), 
/// which can be used to load application and platform classes.
/// ...
/// On other platforms, NULL is returned.
FFI_PLUGIN_EXPORT
jobject GetClassLoader() {
	attach_thread();
	return (*jniEnv)->NewGlobalRef(jniEnv, jni.classLoader);
}

/// Returns application context on Android.
///
/// On other platforms, NULL is returned.
FFI_PLUGIN_EXPORT
jobject GetApplicationContext() {
	attach_thread();
	return (*jniEnv)->NewGlobalRef(jniEnv, jni.appContext);
}

/// Returns current activity of the app
FFI_PLUGIN_EXPORT
jobject GetCurrentActivity() {
	attach_thread();
	return (*jniEnv)->NewGlobalRef(jniEnv, jni.currentActivity);
}

// JNI Initialization

#ifdef __ANDROID__
JNIEXPORT void JNICALL Java_com_github_dart_1lang_jni_JniPlugin_initializeJni(
    JNIEnv *env, jobject obj, jobject appContext, jobject classLoader) {
	jniEnv = env;
	(*env)->GetJavaVM(env, &jni.jvm);
	jni.classLoader = (*env)->NewGlobalRef(env, classLoader);
	jni.appContext = (*env)->NewGlobalRef(env, appContext);
	jclass classLoaderClass = (*env)->GetObjectClass(env, classLoader);
	jni.loadClassMethod =
	    (*env)->GetMethodID(env, classLoaderClass, "loadClass",
	                        "(Ljava/lang/String;)Ljava/lang/Class;");
}

JNIEXPORT void JNICALL Java_com_github_dart_1lang_jni_JniPlugin_setJniActivity(JNIEnv *env, jobject obj, jobject activity, jobject context) {
	jniEnv = env;
	if (jni.currentActivity != NULL) {
		(*env)->DeleteGlobalRef(env, jni.currentActivity);
	}
	jni.currentActivity = (*env)->NewGlobalRef(env, activity);
	if (jni.appContext != NULL) {
		(*env)->DeleteGlobalRef(env, jni.appContext);
	}
	jni.appContext = (*env)->NewGlobalRef(env, context);
}

// Sometimes you may get linker error trying to link JNI_CreateJavaVM APIs
// on Android NDK. So IFDEF is required.
#else
FFI_PLUGIN_EXPORT
JNIEnv *SpawnJvm(JavaVMInitArgs *initArgs) {
	JavaVMOption jvmopt[1];
	char class_path[] = "-Djava.class.path=.";
	jvmopt[0].optionString = class_path;
	JavaVMInitArgs vmArgs;
	if (!initArgs) {
		vmArgs.version = JNI_VERSION_1_6;
		vmArgs.nOptions = 1;
		vmArgs.options = jvmopt;
		vmArgs.ignoreUnrecognized = JNI_TRUE;
		initArgs = &vmArgs;
	}
	const long flag =
	    JNI_CreateJavaVM(&jni.jvm, __ENVP_CAST &jniEnv, initArgs);
	if (flag == JNI_ERR) {
		return NULL;
	}
	return jniEnv;
}
#endif

// accessors - a bunch of functions which are directly called by jnigen generated bindings
// and also package:jni reflective method access.

jthrowable exceptionCheck() {
	jthrowable exception = (*jniEnv)->ExceptionOccurred(jniEnv);
	if (exception != NULL) (*jniEnv)->ExceptionClear(jniEnv);
	if (exception == NULL) return NULL;
	return to_global_ref(exception);
}

JniClassLookupResult getClass(char *internalName) {
	JniClassLookupResult result = {NULL, NULL};
	result.classRef = LoadClass(internalName);
	result.exception = exceptionCheck();
	return result;
}

static inline JniPointerResult _getId(void * (*getter)(JNIEnv*, jclass, char *, char*), jclass cls, char *name, char *sig) {
	JniPointerResult result = {NULL, NULL};
	attach_thread();
	result.id = getter(jniEnv, cls, name, sig);
	result.exception = exceptionCheck();
	return result;
}

JniPointerResult getMethodID(jclass cls, char *name, char *sig) {
	return _getId((*jniEnv)->GetMethodID, cls, name, sig);
}

JniPointerResult getStaticMethodID(jclass cls, char *name, char *sig) {
	return _getId((*jniEnv)->GetStaticMethodID, cls, name, sig);
}

JniPointerResult getFieldID(jclass cls, char *name, char *sig) {
	return _getId((*jniEnv)->GetFieldID, cls, name, sig);
}

JniPointerResult getStaticFieldID(jclass cls, char *name, char *sig) {
	return _getId((*jniEnv)->GetStaticFieldID, cls, name, sig);
}

JniResult callMethod(jobject obj, jmethodID fieldID, int callType, jvalue *args) {
	attach_thread();
	jvalue result = {.j = 0};
	switch (callType) {
		case booleanType:
			result.z = (*jniEnv)->CallBooleanMethodA(jniEnv, obj, fieldID, args);
			break;
		case byteType:
			result.b = (*jniEnv)->CallByteMethodA(jniEnv, obj, fieldID, args);
			break;
		case shortType:
			result.s = (*jniEnv)->CallShortMethodA(jniEnv, obj, fieldID, args);
			break;
		case charType:
			result.c = (*jniEnv)->CallCharMethodA(jniEnv, obj, fieldID, args);
			break;
		case intType:
			result.i = (*jniEnv)->CallIntMethodA(jniEnv, obj, fieldID, args);
			break;
		case longType:
			result.j = (*jniEnv)->CallLongMethodA(jniEnv, obj, fieldID, args);
			break;
		case floatType:
			result.f = (*jniEnv)->CallFloatMethodA(jniEnv, obj, fieldID, args);
			break;
		case doubleType:
			result.d = (*jniEnv)->CallDoubleMethodA(jniEnv, obj, fieldID, args);
			break;
		case objectType:
			result.l = to_global_ref((*jniEnv)->CallObjectMethodA(jniEnv, obj, fieldID, args));
			break;
		case voidType:
			(*jniEnv)->CallVoidMethodA(jniEnv, obj, fieldID, args);
			break;
	}
	JniResult jniResult = {.result = result, .exception = NULL};
	jniResult.exception = exceptionCheck();
	return jniResult;
}

// TODO(#60): Any way to reduce this boilerplate?
JniResult callStaticMethod(jclass cls, jmethodID methodID, int callType, jvalue *args) {
	attach_thread();
	jvalue result = {.j = 0};
	switch (callType) {
		case booleanType:
			result.z = (*jniEnv)->CallStaticBooleanMethodA(jniEnv, cls, methodID, args);
			break;
		case byteType:
			result.b = (*jniEnv)->CallStaticByteMethodA(jniEnv, cls, methodID, args);
			break;
		case shortType:
			result.s = (*jniEnv)->CallStaticShortMethodA(jniEnv, cls, methodID, args);
			break;
		case charType:
			result.c = (*jniEnv)->CallStaticCharMethodA(jniEnv, cls, methodID, args);
			break;
		case intType:
			result.i = (*jniEnv)->CallStaticIntMethodA(jniEnv, cls, methodID, args);
			break;
		case longType:
			result.j = (*jniEnv)->CallStaticLongMethodA(jniEnv, cls, methodID, args);
			break;
		case floatType:
			result.f = (*jniEnv)->CallStaticFloatMethodA(jniEnv, cls, methodID, args);
			break;
		case doubleType:
			result.d = (*jniEnv)->CallStaticDoubleMethodA(jniEnv, cls, methodID, args);
			break;
		case objectType:
			result.l = to_global_ref((*jniEnv)->CallStaticObjectMethodA(jniEnv, cls, methodID, args));
			break;
		case voidType:
			(*jniEnv)->CallStaticVoidMethodA(jniEnv, cls, methodID, args);
			break;
	}
	JniResult jniResult = {.result = result, .exception = NULL};
	jniResult.exception = exceptionCheck();
	return jniResult;
}

JniResult getField(jobject obj, jfieldID fieldID, int callType) {
	attach_thread();
	jvalue result = {.j = 0};
	switch (callType) {
		case booleanType:
			result.z = (*jniEnv)->GetBooleanField(jniEnv, obj, fieldID);
			break;
		case byteType:
			result.b = (*jniEnv)->GetByteField(jniEnv, obj, fieldID);
			break;
		case shortType:
			result.s = (*jniEnv)->GetShortField(jniEnv, obj, fieldID);
			break;
		case charType:
			result.c = (*jniEnv)->GetCharField(jniEnv, obj, fieldID);
			break;
		case intType:
			result.i = (*jniEnv)->GetIntField(jniEnv, obj, fieldID);
			break;
		case longType:
			result.j = (*jniEnv)->GetLongField(jniEnv, obj, fieldID);
			break;
		case floatType:
			result.f = (*jniEnv)->GetFloatField(jniEnv, obj, fieldID);
			break;
		case doubleType:
			result.d = (*jniEnv)->GetDoubleField(jniEnv, obj, fieldID);
			break;
		case objectType:
			result.l = to_global_ref((*jniEnv)->GetObjectField(jniEnv, obj, fieldID));
			break;
		case voidType:
			// This error should have been handled in Dart.
			break;
	}
	JniResult jniResult = {.result = result, .exception = NULL};
	jniResult.exception = exceptionCheck();
	return jniResult;
}

FFI_PLUGIN_EXPORT
JniResult getStaticField(jclass cls, jfieldID fieldID, int callType) {
	attach_thread();
	jvalue result = {.j = 0};
	switch (callType) {
		case booleanType:
			result.z = (*jniEnv)->GetStaticBooleanField(jniEnv, cls, fieldID);
			break;
		case byteType:
			result.b = (*jniEnv)->GetStaticByteField(jniEnv, cls, fieldID);
			break;
		case shortType:
			result.s = (*jniEnv)->GetStaticShortField(jniEnv, cls, fieldID);
			break;
		case charType:
			result.c = (*jniEnv)->GetStaticCharField(jniEnv, cls, fieldID);
			break;
		case intType:
			result.i = (*jniEnv)->GetStaticIntField(jniEnv, cls, fieldID);
			break;
		case longType:
			result.j = (*jniEnv)->GetStaticLongField(jniEnv, cls, fieldID);
			break;
		case floatType:
			result.f = (*jniEnv)->GetStaticFloatField(jniEnv, cls, fieldID);
			break;
		case doubleType:
			result.d = (*jniEnv)->GetStaticDoubleField(jniEnv, cls, fieldID);
			break;
		case objectType:
			result.l = to_global_ref((*jniEnv)->GetStaticObjectField(jniEnv, cls, fieldID));
			break;
		case voidType:
			// This error should have been handled in dart.
			// is there a way to mark this as unreachable?
			// or throw exception in Dart using Dart's C API.
			break;
	}
	JniResult jniResult = {.result = result, .exception = NULL};
		jniResult.exception = exceptionCheck();
	return jniResult;
}

JniResult newObject(jclass cls, jmethodID ctor, jvalue *args) {
	attach_thread();
	JniResult jniResult;
	jniResult.result.l = (*jniEnv)->NewObjectA(jniEnv, cls, ctor, args);
	jniResult.exception = exceptionCheck();
	return jniResult;
}

JniAccessors accessors = {
	.getClass = getClass,
	.getFieldID = getFieldID,
	.getStaticFieldID = getStaticFieldID,
	.getMethodID = getMethodID,
	.getStaticMethodID = getStaticMethodID,
	.newObject = newObject,
	.callMethod = callMethod,
	.callStaticMethod = callStaticMethod,
	.getField = getField,
	.getStaticField = getStaticField,
};

FFI_PLUGIN_EXPORT JniAccessors *GetAccessors() { return &accessors; }

// These will not be required after migrating to Dart-only bindings.
FFI_PLUGIN_EXPORT JniContext GetJniContext() { return jni; }

FFI_PLUGIN_EXPORT JNIEnv *GetJniEnv() {
	if (jni.jvm == NULL) {
		return NULL;
	}
	attach_thread();
	return jniEnv;
}
