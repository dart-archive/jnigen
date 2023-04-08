#include "global_jni_env.h"

JniResult globalJniEnv_GetVersion() {
  attach_thread();
  jint _result = (*jniEnv)->GetVersion(jniEnv);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return (JniResult){.value = {.j = 0}, .exception = _exception};
  }
  return (JniResult){.value = {.i = _result}, .exception = NULL};
}

JniClassLookupResult globalJniEnv_DefineClass(char* name,
                                              jobject loader,
                                              jbyte* buf,
                                              jsize bufLen) {
  attach_thread();
  jclass _result = (*jniEnv)->DefineClass(jniEnv, name, loader, buf, bufLen);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return (JniClassLookupResult){.value = NULL, .exception = _exception};
  }
  _result = to_global_ref(_result);
  return (JniClassLookupResult){.value = _result, .exception = NULL};
}

JniClassLookupResult globalJniEnv_FindClass(char* name) {
  attach_thread();
  jclass _result = (*jniEnv)->FindClass(jniEnv, name);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return (JniClassLookupResult){.value = NULL, .exception = _exception};
  }
  _result = to_global_ref(_result);
  return (JniClassLookupResult){.value = _result, .exception = NULL};
}

JniPointerResult globalJniEnv_FromReflectedMethod(jobject method) {
  attach_thread();
  jmethodID _result = (*jniEnv)->FromReflectedMethod(jniEnv, method);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return (JniPointerResult){.value = NULL, .exception = _exception};
  }
  return (JniPointerResult){.value = _result, .exception = NULL};
}

JniPointerResult globalJniEnv_FromReflectedField(jobject field) {
  attach_thread();
  jfieldID _result = (*jniEnv)->FromReflectedField(jniEnv, field);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return (JniPointerResult){.value = NULL, .exception = _exception};
  }
  return (JniPointerResult){.value = _result, .exception = NULL};
}

JniResult globalJniEnv_ToReflectedMethod(jclass cls,
                                         jmethodID methodId,
                                         jboolean isStatic) {
  attach_thread();
  jobject _result =
      (*jniEnv)->ToReflectedMethod(jniEnv, cls, methodId, isStatic);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return (JniResult){.value = {.j = 0}, .exception = _exception};
  }
  _result = to_global_ref(_result);
  return (JniResult){.value = {.l = _result}, .exception = NULL};
}

JniClassLookupResult globalJniEnv_GetSuperclass(jclass clazz) {
  attach_thread();
  jclass _result = (*jniEnv)->GetSuperclass(jniEnv, clazz);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return (JniClassLookupResult){.value = NULL, .exception = _exception};
  }
  _result = to_global_ref(_result);
  return (JniClassLookupResult){.value = _result, .exception = NULL};
}

JniResult globalJniEnv_IsAssignableFrom(jclass clazz1, jclass clazz2) {
  attach_thread();
  jboolean _result = (*jniEnv)->IsAssignableFrom(jniEnv, clazz1, clazz2);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return (JniResult){.value = {.j = 0}, .exception = _exception};
  }
  return (JniResult){.value = {.z = _result}, .exception = NULL};
}

JniResult globalJniEnv_ToReflectedField(jclass cls,
                                        jfieldID fieldID,
                                        jboolean isStatic) {
  attach_thread();
  jobject _result = (*jniEnv)->ToReflectedField(jniEnv, cls, fieldID, isStatic);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return (JniResult){.value = {.j = 0}, .exception = _exception};
  }
  _result = to_global_ref(_result);
  return (JniResult){.value = {.l = _result}, .exception = NULL};
}

JniResult globalJniEnv_Throw(jthrowable obj) {
  attach_thread();
  jint _result = (*jniEnv)->Throw(jniEnv, obj);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return (JniResult){.value = {.j = 0}, .exception = _exception};
  }
  return (JniResult){.value = {.i = _result}, .exception = NULL};
}

JniResult globalJniEnv_ThrowNew(jclass clazz, char* message) {
  attach_thread();
  jint _result = (*jniEnv)->ThrowNew(jniEnv, clazz, message);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return (JniResult){.value = {.j = 0}, .exception = _exception};
  }
  return (JniResult){.value = {.i = _result}, .exception = NULL};
}

JniResult globalJniEnv_ExceptionOccurred() {
  attach_thread();
  jthrowable _result = (*jniEnv)->ExceptionOccurred(jniEnv);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return (JniResult){.value = {.j = 0}, .exception = _exception};
  }
  _result = to_global_ref(_result);
  return (JniResult){.value = {.l = _result}, .exception = NULL};
}

jthrowable globalJniEnv_ExceptionDescribe() {
  attach_thread();
  (*jniEnv)->ExceptionDescribe(jniEnv);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return _exception;
  }
  return NULL;
}

jthrowable globalJniEnv_ExceptionClear() {
  attach_thread();
  (*jniEnv)->ExceptionClear(jniEnv);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return _exception;
  }
  return NULL;
}

jthrowable globalJniEnv_FatalError(char* msg) {
  attach_thread();
  (*jniEnv)->FatalError(jniEnv, msg);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return _exception;
  }
  return NULL;
}

JniResult globalJniEnv_PushLocalFrame(jint capacity) {
  attach_thread();
  jint _result = (*jniEnv)->PushLocalFrame(jniEnv, capacity);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return (JniResult){.value = {.j = 0}, .exception = _exception};
  }
  return (JniResult){.value = {.i = _result}, .exception = NULL};
}

JniResult globalJniEnv_PopLocalFrame(jobject result) {
  attach_thread();
  jobject _result = (*jniEnv)->PopLocalFrame(jniEnv, result);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return (JniResult){.value = {.j = 0}, .exception = _exception};
  }
  _result = to_global_ref(_result);
  return (JniResult){.value = {.l = _result}, .exception = NULL};
}

JniResult globalJniEnv_NewGlobalRef(jobject obj) {
  attach_thread();
  jobject _result = (*jniEnv)->NewGlobalRef(jniEnv, obj);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return (JniResult){.value = {.j = 0}, .exception = _exception};
  }
  return (JniResult){.value = {.l = _result}, .exception = NULL};
}

jthrowable globalJniEnv_DeleteGlobalRef(jobject globalRef) {
  attach_thread();
  (*jniEnv)->DeleteGlobalRef(jniEnv, globalRef);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return _exception;
  }
  return NULL;
}

jthrowable globalJniEnv_DeleteLocalRef(jobject localRef) {
  attach_thread();
  (*jniEnv)->DeleteLocalRef(jniEnv, localRef);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return _exception;
  }
  return NULL;
}

JniResult globalJniEnv_IsSameObject(jobject ref1, jobject ref2) {
  attach_thread();
  jboolean _result = (*jniEnv)->IsSameObject(jniEnv, ref1, ref2);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return (JniResult){.value = {.j = 0}, .exception = _exception};
  }
  return (JniResult){.value = {.z = _result}, .exception = NULL};
}

JniResult globalJniEnv_NewLocalRef(jobject ref) {
  attach_thread();
  jobject _result = (*jniEnv)->NewLocalRef(jniEnv, ref);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return (JniResult){.value = {.j = 0}, .exception = _exception};
  }
  return (JniResult){.value = {.l = _result}, .exception = NULL};
}

JniResult globalJniEnv_EnsureLocalCapacity(jint capacity) {
  attach_thread();
  jint _result = (*jniEnv)->EnsureLocalCapacity(jniEnv, capacity);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return (JniResult){.value = {.j = 0}, .exception = _exception};
  }
  return (JniResult){.value = {.i = _result}, .exception = NULL};
}

JniResult globalJniEnv_AllocObject(jclass clazz) {
  attach_thread();
  jobject _result = (*jniEnv)->AllocObject(jniEnv, clazz);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return (JniResult){.value = {.j = 0}, .exception = _exception};
  }
  _result = to_global_ref(_result);
  return (JniResult){.value = {.l = _result}, .exception = NULL};
}

JniResult globalJniEnv_NewObjectA(jclass clazz,
                                  jmethodID methodID,
                                  jvalue* args) {
  attach_thread();
  jobject _result = (*jniEnv)->NewObjectA(jniEnv, clazz, methodID, args);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return (JniResult){.value = {.j = 0}, .exception = _exception};
  }
  _result = to_global_ref(_result);
  return (JniResult){.value = {.l = _result}, .exception = NULL};
}

JniClassLookupResult globalJniEnv_GetObjectClass(jobject obj) {
  attach_thread();
  jclass _result = (*jniEnv)->GetObjectClass(jniEnv, obj);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return (JniClassLookupResult){.value = NULL, .exception = _exception};
  }
  _result = to_global_ref(_result);
  return (JniClassLookupResult){.value = _result, .exception = NULL};
}

JniResult globalJniEnv_IsInstanceOf(jobject obj, jclass clazz) {
  attach_thread();
  jboolean _result = (*jniEnv)->IsInstanceOf(jniEnv, obj, clazz);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return (JniResult){.value = {.j = 0}, .exception = _exception};
  }
  return (JniResult){.value = {.z = _result}, .exception = NULL};
}

JniPointerResult globalJniEnv_GetMethodID(jclass clazz, char* name, char* sig) {
  attach_thread();
  jmethodID _result = (*jniEnv)->GetMethodID(jniEnv, clazz, name, sig);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return (JniPointerResult){.value = NULL, .exception = _exception};
  }
  return (JniPointerResult){.value = _result, .exception = NULL};
}

JniResult globalJniEnv_CallObjectMethodA(jobject obj,
                                         jmethodID methodID,
                                         jvalue* args) {
  attach_thread();
  jobject _result = (*jniEnv)->CallObjectMethodA(jniEnv, obj, methodID, args);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return (JniResult){.value = {.j = 0}, .exception = _exception};
  }
  _result = to_global_ref(_result);
  return (JniResult){.value = {.l = _result}, .exception = NULL};
}

JniResult globalJniEnv_CallBooleanMethodA(jobject obj,
                                          jmethodID methodId,
                                          jvalue* args) {
  attach_thread();
  jboolean _result = (*jniEnv)->CallBooleanMethodA(jniEnv, obj, methodId, args);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return (JniResult){.value = {.j = 0}, .exception = _exception};
  }
  return (JniResult){.value = {.z = _result}, .exception = NULL};
}

JniResult globalJniEnv_CallByteMethodA(jobject obj,
                                       jmethodID methodID,
                                       jvalue* args) {
  attach_thread();
  jbyte _result = (*jniEnv)->CallByteMethodA(jniEnv, obj, methodID, args);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return (JniResult){.value = {.j = 0}, .exception = _exception};
  }
  return (JniResult){.value = {.b = _result}, .exception = NULL};
}

JniResult globalJniEnv_CallCharMethodA(jobject obj,
                                       jmethodID methodID,
                                       jvalue* args) {
  attach_thread();
  jchar _result = (*jniEnv)->CallCharMethodA(jniEnv, obj, methodID, args);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return (JniResult){.value = {.j = 0}, .exception = _exception};
  }
  return (JniResult){.value = {.c = _result}, .exception = NULL};
}

JniResult globalJniEnv_CallShortMethodA(jobject obj,
                                        jmethodID methodID,
                                        jvalue* args) {
  attach_thread();
  jshort _result = (*jniEnv)->CallShortMethodA(jniEnv, obj, methodID, args);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return (JniResult){.value = {.j = 0}, .exception = _exception};
  }
  return (JniResult){.value = {.s = _result}, .exception = NULL};
}

JniResult globalJniEnv_CallIntMethodA(jobject obj,
                                      jmethodID methodID,
                                      jvalue* args) {
  attach_thread();
  jint _result = (*jniEnv)->CallIntMethodA(jniEnv, obj, methodID, args);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return (JniResult){.value = {.j = 0}, .exception = _exception};
  }
  return (JniResult){.value = {.i = _result}, .exception = NULL};
}

JniResult globalJniEnv_CallLongMethodA(jobject obj,
                                       jmethodID methodID,
                                       jvalue* args) {
  attach_thread();
  jlong _result = (*jniEnv)->CallLongMethodA(jniEnv, obj, methodID, args);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return (JniResult){.value = {.j = 0}, .exception = _exception};
  }
  return (JniResult){.value = {.j = _result}, .exception = NULL};
}

JniResult globalJniEnv_CallFloatMethodA(jobject obj,
                                        jmethodID methodID,
                                        jvalue* args) {
  attach_thread();
  jfloat _result = (*jniEnv)->CallFloatMethodA(jniEnv, obj, methodID, args);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return (JniResult){.value = {.j = 0}, .exception = _exception};
  }
  return (JniResult){.value = {.f = _result}, .exception = NULL};
}

JniResult globalJniEnv_CallDoubleMethodA(jobject obj,
                                         jmethodID methodID,
                                         jvalue* args) {
  attach_thread();
  jdouble _result = (*jniEnv)->CallDoubleMethodA(jniEnv, obj, methodID, args);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return (JniResult){.value = {.j = 0}, .exception = _exception};
  }
  return (JniResult){.value = {.d = _result}, .exception = NULL};
}

jthrowable globalJniEnv_CallVoidMethodA(jobject obj,
                                        jmethodID methodID,
                                        jvalue* args) {
  attach_thread();
  (*jniEnv)->CallVoidMethodA(jniEnv, obj, methodID, args);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return _exception;
  }
  return NULL;
}

JniResult globalJniEnv_CallNonvirtualObjectMethodA(jobject obj,
                                                   jclass clazz,
                                                   jmethodID methodID,
                                                   jvalue* args) {
  attach_thread();
  jobject _result = (*jniEnv)->CallNonvirtualObjectMethodA(jniEnv, obj, clazz,
                                                           methodID, args);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return (JniResult){.value = {.j = 0}, .exception = _exception};
  }
  _result = to_global_ref(_result);
  return (JniResult){.value = {.l = _result}, .exception = NULL};
}

JniResult globalJniEnv_CallNonvirtualBooleanMethodA(jobject obj,
                                                    jclass clazz,
                                                    jmethodID methodID,
                                                    jvalue* args) {
  attach_thread();
  jboolean _result = (*jniEnv)->CallNonvirtualBooleanMethodA(jniEnv, obj, clazz,
                                                             methodID, args);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return (JniResult){.value = {.j = 0}, .exception = _exception};
  }
  return (JniResult){.value = {.z = _result}, .exception = NULL};
}

JniResult globalJniEnv_CallNonvirtualByteMethodA(jobject obj,
                                                 jclass clazz,
                                                 jmethodID methodID,
                                                 jvalue* args) {
  attach_thread();
  jbyte _result =
      (*jniEnv)->CallNonvirtualByteMethodA(jniEnv, obj, clazz, methodID, args);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return (JniResult){.value = {.j = 0}, .exception = _exception};
  }
  return (JniResult){.value = {.b = _result}, .exception = NULL};
}

JniResult globalJniEnv_CallNonvirtualCharMethodA(jobject obj,
                                                 jclass clazz,
                                                 jmethodID methodID,
                                                 jvalue* args) {
  attach_thread();
  jchar _result =
      (*jniEnv)->CallNonvirtualCharMethodA(jniEnv, obj, clazz, methodID, args);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return (JniResult){.value = {.j = 0}, .exception = _exception};
  }
  return (JniResult){.value = {.c = _result}, .exception = NULL};
}

JniResult globalJniEnv_CallNonvirtualShortMethodA(jobject obj,
                                                  jclass clazz,
                                                  jmethodID methodID,
                                                  jvalue* args) {
  attach_thread();
  jshort _result =
      (*jniEnv)->CallNonvirtualShortMethodA(jniEnv, obj, clazz, methodID, args);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return (JniResult){.value = {.j = 0}, .exception = _exception};
  }
  return (JniResult){.value = {.s = _result}, .exception = NULL};
}

JniResult globalJniEnv_CallNonvirtualIntMethodA(jobject obj,
                                                jclass clazz,
                                                jmethodID methodID,
                                                jvalue* args) {
  attach_thread();
  jint _result =
      (*jniEnv)->CallNonvirtualIntMethodA(jniEnv, obj, clazz, methodID, args);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return (JniResult){.value = {.j = 0}, .exception = _exception};
  }
  return (JniResult){.value = {.i = _result}, .exception = NULL};
}

JniResult globalJniEnv_CallNonvirtualLongMethodA(jobject obj,
                                                 jclass clazz,
                                                 jmethodID methodID,
                                                 jvalue* args) {
  attach_thread();
  jlong _result =
      (*jniEnv)->CallNonvirtualLongMethodA(jniEnv, obj, clazz, methodID, args);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return (JniResult){.value = {.j = 0}, .exception = _exception};
  }
  return (JniResult){.value = {.j = _result}, .exception = NULL};
}

JniResult globalJniEnv_CallNonvirtualFloatMethodA(jobject obj,
                                                  jclass clazz,
                                                  jmethodID methodID,
                                                  jvalue* args) {
  attach_thread();
  jfloat _result =
      (*jniEnv)->CallNonvirtualFloatMethodA(jniEnv, obj, clazz, methodID, args);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return (JniResult){.value = {.j = 0}, .exception = _exception};
  }
  return (JniResult){.value = {.f = _result}, .exception = NULL};
}

JniResult globalJniEnv_CallNonvirtualDoubleMethodA(jobject obj,
                                                   jclass clazz,
                                                   jmethodID methodID,
                                                   jvalue* args) {
  attach_thread();
  jdouble _result = (*jniEnv)->CallNonvirtualDoubleMethodA(jniEnv, obj, clazz,
                                                           methodID, args);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return (JniResult){.value = {.j = 0}, .exception = _exception};
  }
  return (JniResult){.value = {.d = _result}, .exception = NULL};
}

jthrowable globalJniEnv_CallNonvirtualVoidMethodA(jobject obj,
                                                  jclass clazz,
                                                  jmethodID methodID,
                                                  jvalue* args) {
  attach_thread();
  (*jniEnv)->CallNonvirtualVoidMethodA(jniEnv, obj, clazz, methodID, args);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return _exception;
  }
  return NULL;
}

JniPointerResult globalJniEnv_GetFieldID(jclass clazz, char* name, char* sig) {
  attach_thread();
  jfieldID _result = (*jniEnv)->GetFieldID(jniEnv, clazz, name, sig);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return (JniPointerResult){.value = NULL, .exception = _exception};
  }
  return (JniPointerResult){.value = _result, .exception = NULL};
}

JniResult globalJniEnv_GetObjectField(jobject obj, jfieldID fieldID) {
  attach_thread();
  jobject _result = (*jniEnv)->GetObjectField(jniEnv, obj, fieldID);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return (JniResult){.value = {.j = 0}, .exception = _exception};
  }
  _result = to_global_ref(_result);
  return (JniResult){.value = {.l = _result}, .exception = NULL};
}

JniResult globalJniEnv_GetBooleanField(jobject obj, jfieldID fieldID) {
  attach_thread();
  jboolean _result = (*jniEnv)->GetBooleanField(jniEnv, obj, fieldID);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return (JniResult){.value = {.j = 0}, .exception = _exception};
  }
  return (JniResult){.value = {.z = _result}, .exception = NULL};
}

JniResult globalJniEnv_GetByteField(jobject obj, jfieldID fieldID) {
  attach_thread();
  jbyte _result = (*jniEnv)->GetByteField(jniEnv, obj, fieldID);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return (JniResult){.value = {.j = 0}, .exception = _exception};
  }
  return (JniResult){.value = {.b = _result}, .exception = NULL};
}

JniResult globalJniEnv_GetCharField(jobject obj, jfieldID fieldID) {
  attach_thread();
  jchar _result = (*jniEnv)->GetCharField(jniEnv, obj, fieldID);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return (JniResult){.value = {.j = 0}, .exception = _exception};
  }
  return (JniResult){.value = {.c = _result}, .exception = NULL};
}

JniResult globalJniEnv_GetShortField(jobject obj, jfieldID fieldID) {
  attach_thread();
  jshort _result = (*jniEnv)->GetShortField(jniEnv, obj, fieldID);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return (JniResult){.value = {.j = 0}, .exception = _exception};
  }
  return (JniResult){.value = {.s = _result}, .exception = NULL};
}

JniResult globalJniEnv_GetIntField(jobject obj, jfieldID fieldID) {
  attach_thread();
  jint _result = (*jniEnv)->GetIntField(jniEnv, obj, fieldID);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return (JniResult){.value = {.j = 0}, .exception = _exception};
  }
  return (JniResult){.value = {.i = _result}, .exception = NULL};
}

JniResult globalJniEnv_GetLongField(jobject obj, jfieldID fieldID) {
  attach_thread();
  jlong _result = (*jniEnv)->GetLongField(jniEnv, obj, fieldID);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return (JniResult){.value = {.j = 0}, .exception = _exception};
  }
  return (JniResult){.value = {.j = _result}, .exception = NULL};
}

JniResult globalJniEnv_GetFloatField(jobject obj, jfieldID fieldID) {
  attach_thread();
  jfloat _result = (*jniEnv)->GetFloatField(jniEnv, obj, fieldID);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return (JniResult){.value = {.j = 0}, .exception = _exception};
  }
  return (JniResult){.value = {.f = _result}, .exception = NULL};
}

JniResult globalJniEnv_GetDoubleField(jobject obj, jfieldID fieldID) {
  attach_thread();
  jdouble _result = (*jniEnv)->GetDoubleField(jniEnv, obj, fieldID);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return (JniResult){.value = {.j = 0}, .exception = _exception};
  }
  return (JniResult){.value = {.d = _result}, .exception = NULL};
}

jthrowable globalJniEnv_SetObjectField(jobject obj,
                                       jfieldID fieldID,
                                       jobject val) {
  attach_thread();
  (*jniEnv)->SetObjectField(jniEnv, obj, fieldID, val);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return _exception;
  }
  return NULL;
}

jthrowable globalJniEnv_SetBooleanField(jobject obj,
                                        jfieldID fieldID,
                                        jboolean val) {
  attach_thread();
  (*jniEnv)->SetBooleanField(jniEnv, obj, fieldID, val);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return _exception;
  }
  return NULL;
}

jthrowable globalJniEnv_SetByteField(jobject obj, jfieldID fieldID, jbyte val) {
  attach_thread();
  (*jniEnv)->SetByteField(jniEnv, obj, fieldID, val);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return _exception;
  }
  return NULL;
}

jthrowable globalJniEnv_SetCharField(jobject obj, jfieldID fieldID, jchar val) {
  attach_thread();
  (*jniEnv)->SetCharField(jniEnv, obj, fieldID, val);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return _exception;
  }
  return NULL;
}

jthrowable globalJniEnv_SetShortField(jobject obj,
                                      jfieldID fieldID,
                                      jshort val) {
  attach_thread();
  (*jniEnv)->SetShortField(jniEnv, obj, fieldID, val);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return _exception;
  }
  return NULL;
}

jthrowable globalJniEnv_SetIntField(jobject obj, jfieldID fieldID, jint val) {
  attach_thread();
  (*jniEnv)->SetIntField(jniEnv, obj, fieldID, val);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return _exception;
  }
  return NULL;
}

jthrowable globalJniEnv_SetLongField(jobject obj, jfieldID fieldID, jlong val) {
  attach_thread();
  (*jniEnv)->SetLongField(jniEnv, obj, fieldID, val);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return _exception;
  }
  return NULL;
}

jthrowable globalJniEnv_SetFloatField(jobject obj,
                                      jfieldID fieldID,
                                      jfloat val) {
  attach_thread();
  (*jniEnv)->SetFloatField(jniEnv, obj, fieldID, val);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return _exception;
  }
  return NULL;
}

jthrowable globalJniEnv_SetDoubleField(jobject obj,
                                       jfieldID fieldID,
                                       jdouble val) {
  attach_thread();
  (*jniEnv)->SetDoubleField(jniEnv, obj, fieldID, val);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return _exception;
  }
  return NULL;
}

JniPointerResult globalJniEnv_GetStaticMethodID(jclass clazz,
                                                char* name,
                                                char* sig) {
  attach_thread();
  jmethodID _result = (*jniEnv)->GetStaticMethodID(jniEnv, clazz, name, sig);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return (JniPointerResult){.value = NULL, .exception = _exception};
  }
  return (JniPointerResult){.value = _result, .exception = NULL};
}

JniResult globalJniEnv_CallStaticObjectMethodA(jclass clazz,
                                               jmethodID methodID,
                                               jvalue* args) {
  attach_thread();
  jobject _result =
      (*jniEnv)->CallStaticObjectMethodA(jniEnv, clazz, methodID, args);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return (JniResult){.value = {.j = 0}, .exception = _exception};
  }
  _result = to_global_ref(_result);
  return (JniResult){.value = {.l = _result}, .exception = NULL};
}

JniResult globalJniEnv_CallStaticBooleanMethodA(jclass clazz,
                                                jmethodID methodID,
                                                jvalue* args) {
  attach_thread();
  jboolean _result =
      (*jniEnv)->CallStaticBooleanMethodA(jniEnv, clazz, methodID, args);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return (JniResult){.value = {.j = 0}, .exception = _exception};
  }
  return (JniResult){.value = {.z = _result}, .exception = NULL};
}

JniResult globalJniEnv_CallStaticByteMethodA(jclass clazz,
                                             jmethodID methodID,
                                             jvalue* args) {
  attach_thread();
  jbyte _result =
      (*jniEnv)->CallStaticByteMethodA(jniEnv, clazz, methodID, args);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return (JniResult){.value = {.j = 0}, .exception = _exception};
  }
  return (JniResult){.value = {.b = _result}, .exception = NULL};
}

JniResult globalJniEnv_CallStaticCharMethodA(jclass clazz,
                                             jmethodID methodID,
                                             jvalue* args) {
  attach_thread();
  jchar _result =
      (*jniEnv)->CallStaticCharMethodA(jniEnv, clazz, methodID, args);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return (JniResult){.value = {.j = 0}, .exception = _exception};
  }
  return (JniResult){.value = {.c = _result}, .exception = NULL};
}

JniResult globalJniEnv_CallStaticShortMethodA(jclass clazz,
                                              jmethodID methodID,
                                              jvalue* args) {
  attach_thread();
  jshort _result =
      (*jniEnv)->CallStaticShortMethodA(jniEnv, clazz, methodID, args);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return (JniResult){.value = {.j = 0}, .exception = _exception};
  }
  return (JniResult){.value = {.s = _result}, .exception = NULL};
}

JniResult globalJniEnv_CallStaticIntMethodA(jclass clazz,
                                            jmethodID methodID,
                                            jvalue* args) {
  attach_thread();
  jint _result = (*jniEnv)->CallStaticIntMethodA(jniEnv, clazz, methodID, args);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return (JniResult){.value = {.j = 0}, .exception = _exception};
  }
  return (JniResult){.value = {.i = _result}, .exception = NULL};
}

JniResult globalJniEnv_CallStaticLongMethodA(jclass clazz,
                                             jmethodID methodID,
                                             jvalue* args) {
  attach_thread();
  jlong _result =
      (*jniEnv)->CallStaticLongMethodA(jniEnv, clazz, methodID, args);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return (JniResult){.value = {.j = 0}, .exception = _exception};
  }
  return (JniResult){.value = {.j = _result}, .exception = NULL};
}

JniResult globalJniEnv_CallStaticFloatMethodA(jclass clazz,
                                              jmethodID methodID,
                                              jvalue* args) {
  attach_thread();
  jfloat _result =
      (*jniEnv)->CallStaticFloatMethodA(jniEnv, clazz, methodID, args);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return (JniResult){.value = {.j = 0}, .exception = _exception};
  }
  return (JniResult){.value = {.f = _result}, .exception = NULL};
}

JniResult globalJniEnv_CallStaticDoubleMethodA(jclass clazz,
                                               jmethodID methodID,
                                               jvalue* args) {
  attach_thread();
  jdouble _result =
      (*jniEnv)->CallStaticDoubleMethodA(jniEnv, clazz, methodID, args);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return (JniResult){.value = {.j = 0}, .exception = _exception};
  }
  return (JniResult){.value = {.d = _result}, .exception = NULL};
}

jthrowable globalJniEnv_CallStaticVoidMethodA(jclass clazz,
                                              jmethodID methodID,
                                              jvalue* args) {
  attach_thread();
  (*jniEnv)->CallStaticVoidMethodA(jniEnv, clazz, methodID, args);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return _exception;
  }
  return NULL;
}

JniPointerResult globalJniEnv_GetStaticFieldID(jclass clazz,
                                               char* name,
                                               char* sig) {
  attach_thread();
  jfieldID _result = (*jniEnv)->GetStaticFieldID(jniEnv, clazz, name, sig);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return (JniPointerResult){.value = NULL, .exception = _exception};
  }
  return (JniPointerResult){.value = _result, .exception = NULL};
}

JniResult globalJniEnv_GetStaticObjectField(jclass clazz, jfieldID fieldID) {
  attach_thread();
  jobject _result = (*jniEnv)->GetStaticObjectField(jniEnv, clazz, fieldID);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return (JniResult){.value = {.j = 0}, .exception = _exception};
  }
  _result = to_global_ref(_result);
  return (JniResult){.value = {.l = _result}, .exception = NULL};
}

JniResult globalJniEnv_GetStaticBooleanField(jclass clazz, jfieldID fieldID) {
  attach_thread();
  jboolean _result = (*jniEnv)->GetStaticBooleanField(jniEnv, clazz, fieldID);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return (JniResult){.value = {.j = 0}, .exception = _exception};
  }
  return (JniResult){.value = {.z = _result}, .exception = NULL};
}

JniResult globalJniEnv_GetStaticByteField(jclass clazz, jfieldID fieldID) {
  attach_thread();
  jbyte _result = (*jniEnv)->GetStaticByteField(jniEnv, clazz, fieldID);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return (JniResult){.value = {.j = 0}, .exception = _exception};
  }
  return (JniResult){.value = {.b = _result}, .exception = NULL};
}

JniResult globalJniEnv_GetStaticCharField(jclass clazz, jfieldID fieldID) {
  attach_thread();
  jchar _result = (*jniEnv)->GetStaticCharField(jniEnv, clazz, fieldID);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return (JniResult){.value = {.j = 0}, .exception = _exception};
  }
  return (JniResult){.value = {.c = _result}, .exception = NULL};
}

JniResult globalJniEnv_GetStaticShortField(jclass clazz, jfieldID fieldID) {
  attach_thread();
  jshort _result = (*jniEnv)->GetStaticShortField(jniEnv, clazz, fieldID);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return (JniResult){.value = {.j = 0}, .exception = _exception};
  }
  return (JniResult){.value = {.s = _result}, .exception = NULL};
}

JniResult globalJniEnv_GetStaticIntField(jclass clazz, jfieldID fieldID) {
  attach_thread();
  jint _result = (*jniEnv)->GetStaticIntField(jniEnv, clazz, fieldID);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return (JniResult){.value = {.j = 0}, .exception = _exception};
  }
  return (JniResult){.value = {.i = _result}, .exception = NULL};
}

JniResult globalJniEnv_GetStaticLongField(jclass clazz, jfieldID fieldID) {
  attach_thread();
  jlong _result = (*jniEnv)->GetStaticLongField(jniEnv, clazz, fieldID);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return (JniResult){.value = {.j = 0}, .exception = _exception};
  }
  return (JniResult){.value = {.j = _result}, .exception = NULL};
}

JniResult globalJniEnv_GetStaticFloatField(jclass clazz, jfieldID fieldID) {
  attach_thread();
  jfloat _result = (*jniEnv)->GetStaticFloatField(jniEnv, clazz, fieldID);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return (JniResult){.value = {.j = 0}, .exception = _exception};
  }
  return (JniResult){.value = {.f = _result}, .exception = NULL};
}

JniResult globalJniEnv_GetStaticDoubleField(jclass clazz, jfieldID fieldID) {
  attach_thread();
  jdouble _result = (*jniEnv)->GetStaticDoubleField(jniEnv, clazz, fieldID);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return (JniResult){.value = {.j = 0}, .exception = _exception};
  }
  return (JniResult){.value = {.d = _result}, .exception = NULL};
}

jthrowable globalJniEnv_SetStaticObjectField(jclass clazz,
                                             jfieldID fieldID,
                                             jobject val) {
  attach_thread();
  (*jniEnv)->SetStaticObjectField(jniEnv, clazz, fieldID, val);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return _exception;
  }
  return NULL;
}

jthrowable globalJniEnv_SetStaticBooleanField(jclass clazz,
                                              jfieldID fieldID,
                                              jboolean val) {
  attach_thread();
  (*jniEnv)->SetStaticBooleanField(jniEnv, clazz, fieldID, val);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return _exception;
  }
  return NULL;
}

jthrowable globalJniEnv_SetStaticByteField(jclass clazz,
                                           jfieldID fieldID,
                                           jbyte val) {
  attach_thread();
  (*jniEnv)->SetStaticByteField(jniEnv, clazz, fieldID, val);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return _exception;
  }
  return NULL;
}

jthrowable globalJniEnv_SetStaticCharField(jclass clazz,
                                           jfieldID fieldID,
                                           jchar val) {
  attach_thread();
  (*jniEnv)->SetStaticCharField(jniEnv, clazz, fieldID, val);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return _exception;
  }
  return NULL;
}

jthrowable globalJniEnv_SetStaticShortField(jclass clazz,
                                            jfieldID fieldID,
                                            jshort val) {
  attach_thread();
  (*jniEnv)->SetStaticShortField(jniEnv, clazz, fieldID, val);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return _exception;
  }
  return NULL;
}

jthrowable globalJniEnv_SetStaticIntField(jclass clazz,
                                          jfieldID fieldID,
                                          jint val) {
  attach_thread();
  (*jniEnv)->SetStaticIntField(jniEnv, clazz, fieldID, val);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return _exception;
  }
  return NULL;
}

jthrowable globalJniEnv_SetStaticLongField(jclass clazz,
                                           jfieldID fieldID,
                                           jlong val) {
  attach_thread();
  (*jniEnv)->SetStaticLongField(jniEnv, clazz, fieldID, val);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return _exception;
  }
  return NULL;
}

jthrowable globalJniEnv_SetStaticFloatField(jclass clazz,
                                            jfieldID fieldID,
                                            jfloat val) {
  attach_thread();
  (*jniEnv)->SetStaticFloatField(jniEnv, clazz, fieldID, val);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return _exception;
  }
  return NULL;
}

jthrowable globalJniEnv_SetStaticDoubleField(jclass clazz,
                                             jfieldID fieldID,
                                             jdouble val) {
  attach_thread();
  (*jniEnv)->SetStaticDoubleField(jniEnv, clazz, fieldID, val);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return _exception;
  }
  return NULL;
}

JniResult globalJniEnv_NewString(jchar* unicodeChars, jsize len) {
  attach_thread();
  jstring _result = (*jniEnv)->NewString(jniEnv, unicodeChars, len);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return (JniResult){.value = {.j = 0}, .exception = _exception};
  }
  _result = to_global_ref(_result);
  return (JniResult){.value = {.l = _result}, .exception = NULL};
}

JniResult globalJniEnv_GetStringLength(jstring string) {
  attach_thread();
  jsize _result = (*jniEnv)->GetStringLength(jniEnv, string);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return (JniResult){.value = {.j = 0}, .exception = _exception};
  }
  return (JniResult){.value = {.i = _result}, .exception = NULL};
}

JniPointerResult globalJniEnv_GetStringChars(jstring string, jboolean* isCopy) {
  attach_thread();
  const jchar* _result = (*jniEnv)->GetStringChars(jniEnv, string, isCopy);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return (JniPointerResult){.value = NULL, .exception = _exception};
  }
  return (JniPointerResult){.value = _result, .exception = NULL};
}

jthrowable globalJniEnv_ReleaseStringChars(jstring string, jchar* isCopy) {
  attach_thread();
  (*jniEnv)->ReleaseStringChars(jniEnv, string, isCopy);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return _exception;
  }
  return NULL;
}

JniResult globalJniEnv_NewStringUTF(char* bytes) {
  attach_thread();
  jstring _result = (*jniEnv)->NewStringUTF(jniEnv, bytes);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return (JniResult){.value = {.j = 0}, .exception = _exception};
  }
  _result = to_global_ref(_result);
  return (JniResult){.value = {.l = _result}, .exception = NULL};
}

JniResult globalJniEnv_GetStringUTFLength(jstring string) {
  attach_thread();
  jsize _result = (*jniEnv)->GetStringUTFLength(jniEnv, string);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return (JniResult){.value = {.j = 0}, .exception = _exception};
  }
  return (JniResult){.value = {.i = _result}, .exception = NULL};
}

JniPointerResult globalJniEnv_GetStringUTFChars(jstring string,
                                                jboolean* isCopy) {
  attach_thread();
  const char* _result = (*jniEnv)->GetStringUTFChars(jniEnv, string, isCopy);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return (JniPointerResult){.value = NULL, .exception = _exception};
  }
  return (JniPointerResult){.value = _result, .exception = NULL};
}

jthrowable globalJniEnv_ReleaseStringUTFChars(jstring string, char* utf) {
  attach_thread();
  (*jniEnv)->ReleaseStringUTFChars(jniEnv, string, utf);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return _exception;
  }
  return NULL;
}

JniResult globalJniEnv_GetArrayLength(jarray array) {
  attach_thread();
  jsize _result = (*jniEnv)->GetArrayLength(jniEnv, array);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return (JniResult){.value = {.j = 0}, .exception = _exception};
  }
  return (JniResult){.value = {.i = _result}, .exception = NULL};
}

JniResult globalJniEnv_NewObjectArray(jsize length,
                                      jclass elementClass,
                                      jobject initialElement) {
  attach_thread();
  jobjectArray _result =
      (*jniEnv)->NewObjectArray(jniEnv, length, elementClass, initialElement);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return (JniResult){.value = {.j = 0}, .exception = _exception};
  }
  _result = to_global_ref(_result);
  return (JniResult){.value = {.l = _result}, .exception = NULL};
}

JniResult globalJniEnv_GetObjectArrayElement(jobjectArray array, jsize index) {
  attach_thread();
  jobject _result = (*jniEnv)->GetObjectArrayElement(jniEnv, array, index);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return (JniResult){.value = {.j = 0}, .exception = _exception};
  }
  _result = to_global_ref(_result);
  return (JniResult){.value = {.l = _result}, .exception = NULL};
}

jthrowable globalJniEnv_SetObjectArrayElement(jobjectArray array,
                                              jsize index,
                                              jobject val) {
  attach_thread();
  (*jniEnv)->SetObjectArrayElement(jniEnv, array, index, val);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return _exception;
  }
  return NULL;
}

JniResult globalJniEnv_NewBooleanArray(jsize length) {
  attach_thread();
  jbooleanArray _result = (*jniEnv)->NewBooleanArray(jniEnv, length);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return (JniResult){.value = {.j = 0}, .exception = _exception};
  }
  _result = to_global_ref(_result);
  return (JniResult){.value = {.l = _result}, .exception = NULL};
}

JniResult globalJniEnv_NewByteArray(jsize length) {
  attach_thread();
  jbyteArray _result = (*jniEnv)->NewByteArray(jniEnv, length);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return (JniResult){.value = {.j = 0}, .exception = _exception};
  }
  _result = to_global_ref(_result);
  return (JniResult){.value = {.l = _result}, .exception = NULL};
}

JniResult globalJniEnv_NewCharArray(jsize length) {
  attach_thread();
  jcharArray _result = (*jniEnv)->NewCharArray(jniEnv, length);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return (JniResult){.value = {.j = 0}, .exception = _exception};
  }
  _result = to_global_ref(_result);
  return (JniResult){.value = {.l = _result}, .exception = NULL};
}

JniResult globalJniEnv_NewShortArray(jsize length) {
  attach_thread();
  jshortArray _result = (*jniEnv)->NewShortArray(jniEnv, length);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return (JniResult){.value = {.j = 0}, .exception = _exception};
  }
  _result = to_global_ref(_result);
  return (JniResult){.value = {.l = _result}, .exception = NULL};
}

JniResult globalJniEnv_NewIntArray(jsize length) {
  attach_thread();
  jintArray _result = (*jniEnv)->NewIntArray(jniEnv, length);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return (JniResult){.value = {.j = 0}, .exception = _exception};
  }
  _result = to_global_ref(_result);
  return (JniResult){.value = {.l = _result}, .exception = NULL};
}

JniResult globalJniEnv_NewLongArray(jsize length) {
  attach_thread();
  jlongArray _result = (*jniEnv)->NewLongArray(jniEnv, length);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return (JniResult){.value = {.j = 0}, .exception = _exception};
  }
  _result = to_global_ref(_result);
  return (JniResult){.value = {.l = _result}, .exception = NULL};
}

JniResult globalJniEnv_NewFloatArray(jsize length) {
  attach_thread();
  jfloatArray _result = (*jniEnv)->NewFloatArray(jniEnv, length);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return (JniResult){.value = {.j = 0}, .exception = _exception};
  }
  _result = to_global_ref(_result);
  return (JniResult){.value = {.l = _result}, .exception = NULL};
}

JniResult globalJniEnv_NewDoubleArray(jsize length) {
  attach_thread();
  jdoubleArray _result = (*jniEnv)->NewDoubleArray(jniEnv, length);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return (JniResult){.value = {.j = 0}, .exception = _exception};
  }
  _result = to_global_ref(_result);
  return (JniResult){.value = {.l = _result}, .exception = NULL};
}

JniPointerResult globalJniEnv_GetBooleanArrayElements(jbooleanArray array,
                                                      jboolean* isCopy) {
  attach_thread();
  jboolean* _result = (*jniEnv)->GetBooleanArrayElements(jniEnv, array, isCopy);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return (JniPointerResult){.value = NULL, .exception = _exception};
  }
  return (JniPointerResult){.value = _result, .exception = NULL};
}

JniPointerResult globalJniEnv_GetByteArrayElements(jbyteArray array,
                                                   jboolean* isCopy) {
  attach_thread();
  jbyte* _result = (*jniEnv)->GetByteArrayElements(jniEnv, array, isCopy);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return (JniPointerResult){.value = NULL, .exception = _exception};
  }
  return (JniPointerResult){.value = _result, .exception = NULL};
}

JniPointerResult globalJniEnv_GetCharArrayElements(jcharArray array,
                                                   jboolean* isCopy) {
  attach_thread();
  jchar* _result = (*jniEnv)->GetCharArrayElements(jniEnv, array, isCopy);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return (JniPointerResult){.value = NULL, .exception = _exception};
  }
  return (JniPointerResult){.value = _result, .exception = NULL};
}

JniPointerResult globalJniEnv_GetShortArrayElements(jshortArray array,
                                                    jboolean* isCopy) {
  attach_thread();
  jshort* _result = (*jniEnv)->GetShortArrayElements(jniEnv, array, isCopy);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return (JniPointerResult){.value = NULL, .exception = _exception};
  }
  return (JniPointerResult){.value = _result, .exception = NULL};
}

JniPointerResult globalJniEnv_GetIntArrayElements(jintArray array,
                                                  jboolean* isCopy) {
  attach_thread();
  jint* _result = (*jniEnv)->GetIntArrayElements(jniEnv, array, isCopy);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return (JniPointerResult){.value = NULL, .exception = _exception};
  }
  return (JniPointerResult){.value = _result, .exception = NULL};
}

JniPointerResult globalJniEnv_GetLongArrayElements(jlongArray array,
                                                   jboolean* isCopy) {
  attach_thread();
  jlong* _result = (*jniEnv)->GetLongArrayElements(jniEnv, array, isCopy);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return (JniPointerResult){.value = NULL, .exception = _exception};
  }
  return (JniPointerResult){.value = _result, .exception = NULL};
}

JniPointerResult globalJniEnv_GetFloatArrayElements(jfloatArray array,
                                                    jboolean* isCopy) {
  attach_thread();
  jfloat* _result = (*jniEnv)->GetFloatArrayElements(jniEnv, array, isCopy);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return (JniPointerResult){.value = NULL, .exception = _exception};
  }
  return (JniPointerResult){.value = _result, .exception = NULL};
}

JniPointerResult globalJniEnv_GetDoubleArrayElements(jdoubleArray array,
                                                     jboolean* isCopy) {
  attach_thread();
  jdouble* _result = (*jniEnv)->GetDoubleArrayElements(jniEnv, array, isCopy);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return (JniPointerResult){.value = NULL, .exception = _exception};
  }
  return (JniPointerResult){.value = _result, .exception = NULL};
}

jthrowable globalJniEnv_ReleaseBooleanArrayElements(jbooleanArray array,
                                                    jboolean* elems,
                                                    jint mode) {
  attach_thread();
  (*jniEnv)->ReleaseBooleanArrayElements(jniEnv, array, elems, mode);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return _exception;
  }
  return NULL;
}

jthrowable globalJniEnv_ReleaseByteArrayElements(jbyteArray array,
                                                 jbyte* elems,
                                                 jint mode) {
  attach_thread();
  (*jniEnv)->ReleaseByteArrayElements(jniEnv, array, elems, mode);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return _exception;
  }
  return NULL;
}

jthrowable globalJniEnv_ReleaseCharArrayElements(jcharArray array,
                                                 jchar* elems,
                                                 jint mode) {
  attach_thread();
  (*jniEnv)->ReleaseCharArrayElements(jniEnv, array, elems, mode);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return _exception;
  }
  return NULL;
}

jthrowable globalJniEnv_ReleaseShortArrayElements(jshortArray array,
                                                  jshort* elems,
                                                  jint mode) {
  attach_thread();
  (*jniEnv)->ReleaseShortArrayElements(jniEnv, array, elems, mode);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return _exception;
  }
  return NULL;
}

jthrowable globalJniEnv_ReleaseIntArrayElements(jintArray array,
                                                jint* elems,
                                                jint mode) {
  attach_thread();
  (*jniEnv)->ReleaseIntArrayElements(jniEnv, array, elems, mode);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return _exception;
  }
  return NULL;
}

jthrowable globalJniEnv_ReleaseLongArrayElements(jlongArray array,
                                                 jlong* elems,
                                                 jint mode) {
  attach_thread();
  (*jniEnv)->ReleaseLongArrayElements(jniEnv, array, elems, mode);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return _exception;
  }
  return NULL;
}

jthrowable globalJniEnv_ReleaseFloatArrayElements(jfloatArray array,
                                                  jfloat* elems,
                                                  jint mode) {
  attach_thread();
  (*jniEnv)->ReleaseFloatArrayElements(jniEnv, array, elems, mode);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return _exception;
  }
  return NULL;
}

jthrowable globalJniEnv_ReleaseDoubleArrayElements(jdoubleArray array,
                                                   jdouble* elems,
                                                   jint mode) {
  attach_thread();
  (*jniEnv)->ReleaseDoubleArrayElements(jniEnv, array, elems, mode);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return _exception;
  }
  return NULL;
}

jthrowable globalJniEnv_GetBooleanArrayRegion(jbooleanArray array,
                                              jsize start,
                                              jsize len,
                                              jboolean* buf) {
  attach_thread();
  (*jniEnv)->GetBooleanArrayRegion(jniEnv, array, start, len, buf);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return _exception;
  }
  return NULL;
}

jthrowable globalJniEnv_GetByteArrayRegion(jbyteArray array,
                                           jsize start,
                                           jsize len,
                                           jbyte* buf) {
  attach_thread();
  (*jniEnv)->GetByteArrayRegion(jniEnv, array, start, len, buf);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return _exception;
  }
  return NULL;
}

jthrowable globalJniEnv_GetCharArrayRegion(jcharArray array,
                                           jsize start,
                                           jsize len,
                                           jchar* buf) {
  attach_thread();
  (*jniEnv)->GetCharArrayRegion(jniEnv, array, start, len, buf);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return _exception;
  }
  return NULL;
}

jthrowable globalJniEnv_GetShortArrayRegion(jshortArray array,
                                            jsize start,
                                            jsize len,
                                            jshort* buf) {
  attach_thread();
  (*jniEnv)->GetShortArrayRegion(jniEnv, array, start, len, buf);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return _exception;
  }
  return NULL;
}

jthrowable globalJniEnv_GetIntArrayRegion(jintArray array,
                                          jsize start,
                                          jsize len,
                                          jint* buf) {
  attach_thread();
  (*jniEnv)->GetIntArrayRegion(jniEnv, array, start, len, buf);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return _exception;
  }
  return NULL;
}

jthrowable globalJniEnv_GetLongArrayRegion(jlongArray array,
                                           jsize start,
                                           jsize len,
                                           jlong* buf) {
  attach_thread();
  (*jniEnv)->GetLongArrayRegion(jniEnv, array, start, len, buf);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return _exception;
  }
  return NULL;
}

jthrowable globalJniEnv_GetFloatArrayRegion(jfloatArray array,
                                            jsize start,
                                            jsize len,
                                            jfloat* buf) {
  attach_thread();
  (*jniEnv)->GetFloatArrayRegion(jniEnv, array, start, len, buf);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return _exception;
  }
  return NULL;
}

jthrowable globalJniEnv_GetDoubleArrayRegion(jdoubleArray array,
                                             jsize start,
                                             jsize len,
                                             jdouble* buf) {
  attach_thread();
  (*jniEnv)->GetDoubleArrayRegion(jniEnv, array, start, len, buf);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return _exception;
  }
  return NULL;
}

jthrowable globalJniEnv_SetBooleanArrayRegion(jbooleanArray array,
                                              jsize start,
                                              jsize len,
                                              jboolean* buf) {
  attach_thread();
  (*jniEnv)->SetBooleanArrayRegion(jniEnv, array, start, len, buf);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return _exception;
  }
  return NULL;
}

jthrowable globalJniEnv_SetByteArrayRegion(jbyteArray array,
                                           jsize start,
                                           jsize len,
                                           jbyte* buf) {
  attach_thread();
  (*jniEnv)->SetByteArrayRegion(jniEnv, array, start, len, buf);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return _exception;
  }
  return NULL;
}

jthrowable globalJniEnv_SetCharArrayRegion(jcharArray array,
                                           jsize start,
                                           jsize len,
                                           jchar* buf) {
  attach_thread();
  (*jniEnv)->SetCharArrayRegion(jniEnv, array, start, len, buf);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return _exception;
  }
  return NULL;
}

jthrowable globalJniEnv_SetShortArrayRegion(jshortArray array,
                                            jsize start,
                                            jsize len,
                                            jshort* buf) {
  attach_thread();
  (*jniEnv)->SetShortArrayRegion(jniEnv, array, start, len, buf);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return _exception;
  }
  return NULL;
}

jthrowable globalJniEnv_SetIntArrayRegion(jintArray array,
                                          jsize start,
                                          jsize len,
                                          jint* buf) {
  attach_thread();
  (*jniEnv)->SetIntArrayRegion(jniEnv, array, start, len, buf);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return _exception;
  }
  return NULL;
}

jthrowable globalJniEnv_SetLongArrayRegion(jlongArray array,
                                           jsize start,
                                           jsize len,
                                           jlong* buf) {
  attach_thread();
  (*jniEnv)->SetLongArrayRegion(jniEnv, array, start, len, buf);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return _exception;
  }
  return NULL;
}

jthrowable globalJniEnv_SetFloatArrayRegion(jfloatArray array,
                                            jsize start,
                                            jsize len,
                                            jfloat* buf) {
  attach_thread();
  (*jniEnv)->SetFloatArrayRegion(jniEnv, array, start, len, buf);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return _exception;
  }
  return NULL;
}

jthrowable globalJniEnv_SetDoubleArrayRegion(jdoubleArray array,
                                             jsize start,
                                             jsize len,
                                             jdouble* buf) {
  attach_thread();
  (*jniEnv)->SetDoubleArrayRegion(jniEnv, array, start, len, buf);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return _exception;
  }
  return NULL;
}

JniResult globalJniEnv_RegisterNatives(jclass clazz,
                                       JNINativeMethod* methods,
                                       jint nMethods) {
  attach_thread();
  jint _result = (*jniEnv)->RegisterNatives(jniEnv, clazz, methods, nMethods);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return (JniResult){.value = {.j = 0}, .exception = _exception};
  }
  return (JniResult){.value = {.i = _result}, .exception = NULL};
}

JniResult globalJniEnv_UnregisterNatives(jclass clazz) {
  attach_thread();
  jint _result = (*jniEnv)->UnregisterNatives(jniEnv, clazz);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return (JniResult){.value = {.j = 0}, .exception = _exception};
  }
  return (JniResult){.value = {.i = _result}, .exception = NULL};
}

JniResult globalJniEnv_MonitorEnter(jobject obj) {
  attach_thread();
  jint _result = (*jniEnv)->MonitorEnter(jniEnv, obj);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return (JniResult){.value = {.j = 0}, .exception = _exception};
  }
  return (JniResult){.value = {.i = _result}, .exception = NULL};
}

JniResult globalJniEnv_MonitorExit(jobject obj) {
  attach_thread();
  jint _result = (*jniEnv)->MonitorExit(jniEnv, obj);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return (JniResult){.value = {.j = 0}, .exception = _exception};
  }
  return (JniResult){.value = {.i = _result}, .exception = NULL};
}

JniResult globalJniEnv_GetJavaVM(JavaVM** vm) {
  attach_thread();
  jint _result = (*jniEnv)->GetJavaVM(jniEnv, vm);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return (JniResult){.value = {.j = 0}, .exception = _exception};
  }
  return (JniResult){.value = {.i = _result}, .exception = NULL};
}

jthrowable globalJniEnv_GetStringRegion(jstring str,
                                        jsize start,
                                        jsize len,
                                        jchar* buf) {
  attach_thread();
  (*jniEnv)->GetStringRegion(jniEnv, str, start, len, buf);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return _exception;
  }
  return NULL;
}

jthrowable globalJniEnv_GetStringUTFRegion(jstring str,
                                           jsize start,
                                           jsize len,
                                           char* buf) {
  attach_thread();
  (*jniEnv)->GetStringUTFRegion(jniEnv, str, start, len, buf);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return _exception;
  }
  return NULL;
}

JniPointerResult globalJniEnv_GetPrimitiveArrayCritical(jarray array,
                                                        jboolean* isCopy) {
  attach_thread();
  void* _result = (*jniEnv)->GetPrimitiveArrayCritical(jniEnv, array, isCopy);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return (JniPointerResult){.value = NULL, .exception = _exception};
  }
  return (JniPointerResult){.value = _result, .exception = NULL};
}

jthrowable globalJniEnv_ReleasePrimitiveArrayCritical(jarray array,
                                                      void* carray,
                                                      jint mode) {
  attach_thread();
  (*jniEnv)->ReleasePrimitiveArrayCritical(jniEnv, array, carray, mode);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return _exception;
  }
  return NULL;
}

JniPointerResult globalJniEnv_GetStringCritical(jstring str, jboolean* isCopy) {
  attach_thread();
  const jchar* _result = (*jniEnv)->GetStringCritical(jniEnv, str, isCopy);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return (JniPointerResult){.value = NULL, .exception = _exception};
  }
  return (JniPointerResult){.value = _result, .exception = NULL};
}

jthrowable globalJniEnv_ReleaseStringCritical(jstring str, jchar* carray) {
  attach_thread();
  (*jniEnv)->ReleaseStringCritical(jniEnv, str, carray);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return _exception;
  }
  return NULL;
}

JniResult globalJniEnv_NewWeakGlobalRef(jobject obj) {
  attach_thread();
  jweak _result = (*jniEnv)->NewWeakGlobalRef(jniEnv, obj);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return (JniResult){.value = {.j = 0}, .exception = _exception};
  }
  return (JniResult){.value = {.l = _result}, .exception = NULL};
}

jthrowable globalJniEnv_DeleteWeakGlobalRef(jweak obj) {
  attach_thread();
  (*jniEnv)->DeleteWeakGlobalRef(jniEnv, obj);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return _exception;
  }
  return NULL;
}

JniResult globalJniEnv_ExceptionCheck() {
  attach_thread();
  jboolean _result = (*jniEnv)->ExceptionCheck(jniEnv);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return (JniResult){.value = {.j = 0}, .exception = _exception};
  }
  return (JniResult){.value = {.z = _result}, .exception = NULL};
}

JniResult globalJniEnv_NewDirectByteBuffer(void* address, jlong capacity) {
  attach_thread();
  jobject _result = (*jniEnv)->NewDirectByteBuffer(jniEnv, address, capacity);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return (JniResult){.value = {.j = 0}, .exception = _exception};
  }
  _result = to_global_ref(_result);
  return (JniResult){.value = {.l = _result}, .exception = NULL};
}

JniPointerResult globalJniEnv_GetDirectBufferAddress(jobject buf) {
  attach_thread();
  void* _result = (*jniEnv)->GetDirectBufferAddress(jniEnv, buf);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return (JniPointerResult){.value = NULL, .exception = _exception};
  }
  return (JniPointerResult){.value = _result, .exception = NULL};
}

JniResult globalJniEnv_GetDirectBufferCapacity(jobject buf) {
  attach_thread();
  jlong _result = (*jniEnv)->GetDirectBufferCapacity(jniEnv, buf);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return (JniResult){.value = {.j = 0}, .exception = _exception};
  }
  return (JniResult){.value = {.j = _result}, .exception = NULL};
}

JniResult globalJniEnv_GetObjectRefType(jobject obj) {
  attach_thread();
  int32_t _result = (*jniEnv)->GetObjectRefType(jniEnv, obj);
  jthrowable _exception = check_exception();
  if (_exception != NULL) {
    return (JniResult){.value = {.j = 0}, .exception = _exception};
  }
  return (JniResult){.value = {.i = _result}, .exception = NULL};
}

GlobalJniEnv globalJniEnv = {
    .reserved0 = NULL,
    .reserved1 = NULL,
    .reserved2 = NULL,
    .reserved3 = NULL,
    .GetVersion = globalJniEnv_GetVersion,
    .DefineClass = globalJniEnv_DefineClass,
    .FindClass = globalJniEnv_FindClass,
    .FromReflectedMethod = globalJniEnv_FromReflectedMethod,
    .FromReflectedField = globalJniEnv_FromReflectedField,
    .ToReflectedMethod = globalJniEnv_ToReflectedMethod,
    .GetSuperclass = globalJniEnv_GetSuperclass,
    .IsAssignableFrom = globalJniEnv_IsAssignableFrom,
    .ToReflectedField = globalJniEnv_ToReflectedField,
    .Throw = globalJniEnv_Throw,
    .ThrowNew = globalJniEnv_ThrowNew,
    .ExceptionOccurred = globalJniEnv_ExceptionOccurred,
    .ExceptionDescribe = globalJniEnv_ExceptionDescribe,
    .ExceptionClear = globalJniEnv_ExceptionClear,
    .FatalError = globalJniEnv_FatalError,
    .PushLocalFrame = globalJniEnv_PushLocalFrame,
    .PopLocalFrame = globalJniEnv_PopLocalFrame,
    .NewGlobalRef = globalJniEnv_NewGlobalRef,
    .DeleteGlobalRef = globalJniEnv_DeleteGlobalRef,
    .DeleteLocalRef = globalJniEnv_DeleteLocalRef,
    .IsSameObject = globalJniEnv_IsSameObject,
    .NewLocalRef = globalJniEnv_NewLocalRef,
    .EnsureLocalCapacity = globalJniEnv_EnsureLocalCapacity,
    .AllocObject = globalJniEnv_AllocObject,
    .NewObject = NULL,
    .NewObjectV = NULL,
    .NewObjectA = globalJniEnv_NewObjectA,
    .GetObjectClass = globalJniEnv_GetObjectClass,
    .IsInstanceOf = globalJniEnv_IsInstanceOf,
    .GetMethodID = globalJniEnv_GetMethodID,
    .CallObjectMethod = NULL,
    .CallObjectMethodV = NULL,
    .CallObjectMethodA = globalJniEnv_CallObjectMethodA,
    .CallBooleanMethod = NULL,
    .CallBooleanMethodV = NULL,
    .CallBooleanMethodA = globalJniEnv_CallBooleanMethodA,
    .CallByteMethod = NULL,
    .CallByteMethodV = NULL,
    .CallByteMethodA = globalJniEnv_CallByteMethodA,
    .CallCharMethod = NULL,
    .CallCharMethodV = NULL,
    .CallCharMethodA = globalJniEnv_CallCharMethodA,
    .CallShortMethod = NULL,
    .CallShortMethodV = NULL,
    .CallShortMethodA = globalJniEnv_CallShortMethodA,
    .CallIntMethod = NULL,
    .CallIntMethodV = NULL,
    .CallIntMethodA = globalJniEnv_CallIntMethodA,
    .CallLongMethod = NULL,
    .CallLongMethodV = NULL,
    .CallLongMethodA = globalJniEnv_CallLongMethodA,
    .CallFloatMethod = NULL,
    .CallFloatMethodV = NULL,
    .CallFloatMethodA = globalJniEnv_CallFloatMethodA,
    .CallDoubleMethod = NULL,
    .CallDoubleMethodV = NULL,
    .CallDoubleMethodA = globalJniEnv_CallDoubleMethodA,
    .CallVoidMethod = NULL,
    .CallVoidMethodV = NULL,
    .CallVoidMethodA = globalJniEnv_CallVoidMethodA,
    .CallNonvirtualObjectMethod = NULL,
    .CallNonvirtualObjectMethodV = NULL,
    .CallNonvirtualObjectMethodA = globalJniEnv_CallNonvirtualObjectMethodA,
    .CallNonvirtualBooleanMethod = NULL,
    .CallNonvirtualBooleanMethodV = NULL,
    .CallNonvirtualBooleanMethodA = globalJniEnv_CallNonvirtualBooleanMethodA,
    .CallNonvirtualByteMethod = NULL,
    .CallNonvirtualByteMethodV = NULL,
    .CallNonvirtualByteMethodA = globalJniEnv_CallNonvirtualByteMethodA,
    .CallNonvirtualCharMethod = NULL,
    .CallNonvirtualCharMethodV = NULL,
    .CallNonvirtualCharMethodA = globalJniEnv_CallNonvirtualCharMethodA,
    .CallNonvirtualShortMethod = NULL,
    .CallNonvirtualShortMethodV = NULL,
    .CallNonvirtualShortMethodA = globalJniEnv_CallNonvirtualShortMethodA,
    .CallNonvirtualIntMethod = NULL,
    .CallNonvirtualIntMethodV = NULL,
    .CallNonvirtualIntMethodA = globalJniEnv_CallNonvirtualIntMethodA,
    .CallNonvirtualLongMethod = NULL,
    .CallNonvirtualLongMethodV = NULL,
    .CallNonvirtualLongMethodA = globalJniEnv_CallNonvirtualLongMethodA,
    .CallNonvirtualFloatMethod = NULL,
    .CallNonvirtualFloatMethodV = NULL,
    .CallNonvirtualFloatMethodA = globalJniEnv_CallNonvirtualFloatMethodA,
    .CallNonvirtualDoubleMethod = NULL,
    .CallNonvirtualDoubleMethodV = NULL,
    .CallNonvirtualDoubleMethodA = globalJniEnv_CallNonvirtualDoubleMethodA,
    .CallNonvirtualVoidMethod = NULL,
    .CallNonvirtualVoidMethodV = NULL,
    .CallNonvirtualVoidMethodA = globalJniEnv_CallNonvirtualVoidMethodA,
    .GetFieldID = globalJniEnv_GetFieldID,
    .GetObjectField = globalJniEnv_GetObjectField,
    .GetBooleanField = globalJniEnv_GetBooleanField,
    .GetByteField = globalJniEnv_GetByteField,
    .GetCharField = globalJniEnv_GetCharField,
    .GetShortField = globalJniEnv_GetShortField,
    .GetIntField = globalJniEnv_GetIntField,
    .GetLongField = globalJniEnv_GetLongField,
    .GetFloatField = globalJniEnv_GetFloatField,
    .GetDoubleField = globalJniEnv_GetDoubleField,
    .SetObjectField = globalJniEnv_SetObjectField,
    .SetBooleanField = globalJniEnv_SetBooleanField,
    .SetByteField = globalJniEnv_SetByteField,
    .SetCharField = globalJniEnv_SetCharField,
    .SetShortField = globalJniEnv_SetShortField,
    .SetIntField = globalJniEnv_SetIntField,
    .SetLongField = globalJniEnv_SetLongField,
    .SetFloatField = globalJniEnv_SetFloatField,
    .SetDoubleField = globalJniEnv_SetDoubleField,
    .GetStaticMethodID = globalJniEnv_GetStaticMethodID,
    .CallStaticObjectMethod = NULL,
    .CallStaticObjectMethodV = NULL,
    .CallStaticObjectMethodA = globalJniEnv_CallStaticObjectMethodA,
    .CallStaticBooleanMethod = NULL,
    .CallStaticBooleanMethodV = NULL,
    .CallStaticBooleanMethodA = globalJniEnv_CallStaticBooleanMethodA,
    .CallStaticByteMethod = NULL,
    .CallStaticByteMethodV = NULL,
    .CallStaticByteMethodA = globalJniEnv_CallStaticByteMethodA,
    .CallStaticCharMethod = NULL,
    .CallStaticCharMethodV = NULL,
    .CallStaticCharMethodA = globalJniEnv_CallStaticCharMethodA,
    .CallStaticShortMethod = NULL,
    .CallStaticShortMethodV = NULL,
    .CallStaticShortMethodA = globalJniEnv_CallStaticShortMethodA,
    .CallStaticIntMethod = NULL,
    .CallStaticIntMethodV = NULL,
    .CallStaticIntMethodA = globalJniEnv_CallStaticIntMethodA,
    .CallStaticLongMethod = NULL,
    .CallStaticLongMethodV = NULL,
    .CallStaticLongMethodA = globalJniEnv_CallStaticLongMethodA,
    .CallStaticFloatMethod = NULL,
    .CallStaticFloatMethodV = NULL,
    .CallStaticFloatMethodA = globalJniEnv_CallStaticFloatMethodA,
    .CallStaticDoubleMethod = NULL,
    .CallStaticDoubleMethodV = NULL,
    .CallStaticDoubleMethodA = globalJniEnv_CallStaticDoubleMethodA,
    .CallStaticVoidMethod = NULL,
    .CallStaticVoidMethodV = NULL,
    .CallStaticVoidMethodA = globalJniEnv_CallStaticVoidMethodA,
    .GetStaticFieldID = globalJniEnv_GetStaticFieldID,
    .GetStaticObjectField = globalJniEnv_GetStaticObjectField,
    .GetStaticBooleanField = globalJniEnv_GetStaticBooleanField,
    .GetStaticByteField = globalJniEnv_GetStaticByteField,
    .GetStaticCharField = globalJniEnv_GetStaticCharField,
    .GetStaticShortField = globalJniEnv_GetStaticShortField,
    .GetStaticIntField = globalJniEnv_GetStaticIntField,
    .GetStaticLongField = globalJniEnv_GetStaticLongField,
    .GetStaticFloatField = globalJniEnv_GetStaticFloatField,
    .GetStaticDoubleField = globalJniEnv_GetStaticDoubleField,
    .SetStaticObjectField = globalJniEnv_SetStaticObjectField,
    .SetStaticBooleanField = globalJniEnv_SetStaticBooleanField,
    .SetStaticByteField = globalJniEnv_SetStaticByteField,
    .SetStaticCharField = globalJniEnv_SetStaticCharField,
    .SetStaticShortField = globalJniEnv_SetStaticShortField,
    .SetStaticIntField = globalJniEnv_SetStaticIntField,
    .SetStaticLongField = globalJniEnv_SetStaticLongField,
    .SetStaticFloatField = globalJniEnv_SetStaticFloatField,
    .SetStaticDoubleField = globalJniEnv_SetStaticDoubleField,
    .NewString = globalJniEnv_NewString,
    .GetStringLength = globalJniEnv_GetStringLength,
    .GetStringChars = globalJniEnv_GetStringChars,
    .ReleaseStringChars = globalJniEnv_ReleaseStringChars,
    .NewStringUTF = globalJniEnv_NewStringUTF,
    .GetStringUTFLength = globalJniEnv_GetStringUTFLength,
    .GetStringUTFChars = globalJniEnv_GetStringUTFChars,
    .ReleaseStringUTFChars = globalJniEnv_ReleaseStringUTFChars,
    .GetArrayLength = globalJniEnv_GetArrayLength,
    .NewObjectArray = globalJniEnv_NewObjectArray,
    .GetObjectArrayElement = globalJniEnv_GetObjectArrayElement,
    .SetObjectArrayElement = globalJniEnv_SetObjectArrayElement,
    .NewBooleanArray = globalJniEnv_NewBooleanArray,
    .NewByteArray = globalJniEnv_NewByteArray,
    .NewCharArray = globalJniEnv_NewCharArray,
    .NewShortArray = globalJniEnv_NewShortArray,
    .NewIntArray = globalJniEnv_NewIntArray,
    .NewLongArray = globalJniEnv_NewLongArray,
    .NewFloatArray = globalJniEnv_NewFloatArray,
    .NewDoubleArray = globalJniEnv_NewDoubleArray,
    .GetBooleanArrayElements = globalJniEnv_GetBooleanArrayElements,
    .GetByteArrayElements = globalJniEnv_GetByteArrayElements,
    .GetCharArrayElements = globalJniEnv_GetCharArrayElements,
    .GetShortArrayElements = globalJniEnv_GetShortArrayElements,
    .GetIntArrayElements = globalJniEnv_GetIntArrayElements,
    .GetLongArrayElements = globalJniEnv_GetLongArrayElements,
    .GetFloatArrayElements = globalJniEnv_GetFloatArrayElements,
    .GetDoubleArrayElements = globalJniEnv_GetDoubleArrayElements,
    .ReleaseBooleanArrayElements = globalJniEnv_ReleaseBooleanArrayElements,
    .ReleaseByteArrayElements = globalJniEnv_ReleaseByteArrayElements,
    .ReleaseCharArrayElements = globalJniEnv_ReleaseCharArrayElements,
    .ReleaseShortArrayElements = globalJniEnv_ReleaseShortArrayElements,
    .ReleaseIntArrayElements = globalJniEnv_ReleaseIntArrayElements,
    .ReleaseLongArrayElements = globalJniEnv_ReleaseLongArrayElements,
    .ReleaseFloatArrayElements = globalJniEnv_ReleaseFloatArrayElements,
    .ReleaseDoubleArrayElements = globalJniEnv_ReleaseDoubleArrayElements,
    .GetBooleanArrayRegion = globalJniEnv_GetBooleanArrayRegion,
    .GetByteArrayRegion = globalJniEnv_GetByteArrayRegion,
    .GetCharArrayRegion = globalJniEnv_GetCharArrayRegion,
    .GetShortArrayRegion = globalJniEnv_GetShortArrayRegion,
    .GetIntArrayRegion = globalJniEnv_GetIntArrayRegion,
    .GetLongArrayRegion = globalJniEnv_GetLongArrayRegion,
    .GetFloatArrayRegion = globalJniEnv_GetFloatArrayRegion,
    .GetDoubleArrayRegion = globalJniEnv_GetDoubleArrayRegion,
    .SetBooleanArrayRegion = globalJniEnv_SetBooleanArrayRegion,
    .SetByteArrayRegion = globalJniEnv_SetByteArrayRegion,
    .SetCharArrayRegion = globalJniEnv_SetCharArrayRegion,
    .SetShortArrayRegion = globalJniEnv_SetShortArrayRegion,
    .SetIntArrayRegion = globalJniEnv_SetIntArrayRegion,
    .SetLongArrayRegion = globalJniEnv_SetLongArrayRegion,
    .SetFloatArrayRegion = globalJniEnv_SetFloatArrayRegion,
    .SetDoubleArrayRegion = globalJniEnv_SetDoubleArrayRegion,
    .RegisterNatives = globalJniEnv_RegisterNatives,
    .UnregisterNatives = globalJniEnv_UnregisterNatives,
    .MonitorEnter = globalJniEnv_MonitorEnter,
    .MonitorExit = globalJniEnv_MonitorExit,
    .GetJavaVM = globalJniEnv_GetJavaVM,
    .GetStringRegion = globalJniEnv_GetStringRegion,
    .GetStringUTFRegion = globalJniEnv_GetStringUTFRegion,
    .GetPrimitiveArrayCritical = globalJniEnv_GetPrimitiveArrayCritical,
    .ReleasePrimitiveArrayCritical = globalJniEnv_ReleasePrimitiveArrayCritical,
    .GetStringCritical = globalJniEnv_GetStringCritical,
    .ReleaseStringCritical = globalJniEnv_ReleaseStringCritical,
    .NewWeakGlobalRef = globalJniEnv_NewWeakGlobalRef,
    .DeleteWeakGlobalRef = globalJniEnv_DeleteWeakGlobalRef,
    .ExceptionCheck = globalJniEnv_ExceptionCheck,
    .NewDirectByteBuffer = globalJniEnv_NewDirectByteBuffer,
    .GetDirectBufferAddress = globalJniEnv_GetDirectBufferAddress,
    .GetDirectBufferCapacity = globalJniEnv_GetDirectBufferCapacity,
    .GetObjectRefType = globalJniEnv_GetObjectRefType,
};
FFI_PLUGIN_EXPORT
GlobalJniEnv* GetGlobalEnv() {
  if (jni.jvm == NULL) {
    return NULL;
  }
  return &globalJniEnv;
}
