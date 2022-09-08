// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

#include "indir.h"
jint Jei_GetVersion() {
    attach_thread();
    return (*jniEnv)->GetVersion(jniEnv);
}

jclass Jei_DefineClass(const char * name, jobject loader, const jbyte * buf, jsize bufLen) {
    attach_thread();
    return to_global_ref((*jniEnv)->DefineClass(jniEnv, name, loader, buf, bufLen));
}

jclass Jei_FindClass(const char * name) {
    attach_thread();
    return to_global_ref((*jniEnv)->FindClass(jniEnv, name));
}

jmethodID Jei_FromReflectedMethod(jobject method) {
    attach_thread();
    return (*jniEnv)->FromReflectedMethod(jniEnv, method);
}

jfieldID Jei_FromReflectedField(jobject field) {
    attach_thread();
    return (*jniEnv)->FromReflectedField(jniEnv, field);
}

jobject Jei_ToReflectedMethod(jclass cls, jmethodID methodId, jboolean isStatic) {
    attach_thread();
    return to_global_ref((*jniEnv)->ToReflectedMethod(jniEnv, cls, methodId, isStatic));
}

jclass Jei_GetSuperclass(jclass clazz) {
    attach_thread();
    return to_global_ref((*jniEnv)->GetSuperclass(jniEnv, clazz));
}

jboolean Jei_IsAssignableFrom(jclass clazz1, jclass clazz2) {
    attach_thread();
    return (*jniEnv)->IsAssignableFrom(jniEnv, clazz1, clazz2);
}

jobject Jei_ToReflectedField(jclass cls, jfieldID fieldID, jboolean isStatic) {
    attach_thread();
    return to_global_ref((*jniEnv)->ToReflectedField(jniEnv, cls, fieldID, isStatic));
}

jint Jei_Throw(jthrowable obj) {
    attach_thread();
    return (*jniEnv)->Throw(jniEnv, obj);
}

jint Jei_ThrowNew(jclass clazz, const char * message) {
    attach_thread();
    return (*jniEnv)->ThrowNew(jniEnv, clazz, message);
}

jthrowable Jei_ExceptionOccurred() {
    attach_thread();
    return to_global_ref((*jniEnv)->ExceptionOccurred(jniEnv));
}

void Jei_ExceptionDescribe() {
    attach_thread();
    (*jniEnv)->ExceptionDescribe(jniEnv);
}

void Jei_ExceptionClear() {
    attach_thread();
    (*jniEnv)->ExceptionClear(jniEnv);
}

void Jei_FatalError(const char * msg) {
    attach_thread();
    (*jniEnv)->FatalError(jniEnv, msg);
}

jint Jei_PushLocalFrame(jint capacity) {
    attach_thread();
    return (*jniEnv)->PushLocalFrame(jniEnv, capacity);
}

jobject Jei_PopLocalFrame(jobject result) {
    attach_thread();
    return to_global_ref((*jniEnv)->PopLocalFrame(jniEnv, result));
}

jobject Jei_NewGlobalRef(jobject obj) {
    attach_thread();
    return to_global_ref((*jniEnv)->NewGlobalRef(jniEnv, obj));
}

void Jei_DeleteGlobalRef(jobject globalRef) {
    attach_thread();
    (*jniEnv)->DeleteGlobalRef(jniEnv, globalRef);
}

jboolean Jei_IsSameObject(jobject ref1, jobject ref2) {
    attach_thread();
    return (*jniEnv)->IsSameObject(jniEnv, ref1, ref2);
}

jint Jei_EnsureLocalCapacity(jint capacity) {
    attach_thread();
    return (*jniEnv)->EnsureLocalCapacity(jniEnv, capacity);
}

jobject Jei_AllocObject(jclass clazz) {
    attach_thread();
    return to_global_ref((*jniEnv)->AllocObject(jniEnv, clazz));
}

jobject Jei_NewObject(jclass arg1, jmethodID arg2) {
    attach_thread();
    return to_global_ref((*jniEnv)->NewObject(jniEnv, arg1, arg2));
}

jobject Jei_NewObjectA(jclass clazz, jmethodID methodID, const jvalue * args) {
    attach_thread();
    return to_global_ref((*jniEnv)->NewObjectA(jniEnv, clazz, methodID, args));
}

jclass Jei_GetObjectClass(jobject obj) {
    attach_thread();
    return to_global_ref((*jniEnv)->GetObjectClass(jniEnv, obj));
}

jboolean Jei_IsInstanceOf(jobject obj, jclass clazz) {
    attach_thread();
    return (*jniEnv)->IsInstanceOf(jniEnv, obj, clazz);
}

jmethodID Jei_GetMethodID(jclass clazz, const char * name, const char * sig) {
    attach_thread();
    return (*jniEnv)->GetMethodID(jniEnv, clazz, name, sig);
}

jobject Jei_CallObjectMethod(jobject arg1, jmethodID arg2) {
    attach_thread();
    return to_global_ref((*jniEnv)->CallObjectMethod(jniEnv, arg1, arg2));
}

jobject Jei_CallObjectMethodA(jobject obj, jmethodID methodID, const jvalue * args) {
    attach_thread();
    return to_global_ref((*jniEnv)->CallObjectMethodA(jniEnv, obj, methodID, args));
}

jboolean Jei_CallBooleanMethod(jobject arg1, jmethodID arg2) {
    attach_thread();
    return (*jniEnv)->CallBooleanMethod(jniEnv, arg1, arg2);
}

jboolean Jei_CallBooleanMethodA(jobject obj, jmethodID methodId, const jvalue * args) {
    attach_thread();
    return (*jniEnv)->CallBooleanMethodA(jniEnv, obj, methodId, args);
}

jbyte Jei_CallByteMethod(jobject arg1, jmethodID arg2) {
    attach_thread();
    return (*jniEnv)->CallByteMethod(jniEnv, arg1, arg2);
}

jbyte Jei_CallByteMethodA(jobject obj, jmethodID methodID, const jvalue * args) {
    attach_thread();
    return (*jniEnv)->CallByteMethodA(jniEnv, obj, methodID, args);
}

jchar Jei_CallCharMethod(jobject arg1, jmethodID arg2) {
    attach_thread();
    return (*jniEnv)->CallCharMethod(jniEnv, arg1, arg2);
}

jchar Jei_CallCharMethodA(jobject obj, jmethodID methodID, const jvalue * args) {
    attach_thread();
    return (*jniEnv)->CallCharMethodA(jniEnv, obj, methodID, args);
}

jshort Jei_CallShortMethod(jobject arg1, jmethodID arg2) {
    attach_thread();
    return (*jniEnv)->CallShortMethod(jniEnv, arg1, arg2);
}

jshort Jei_CallShortMethodA(jobject obj, jmethodID methodID, const jvalue * args) {
    attach_thread();
    return (*jniEnv)->CallShortMethodA(jniEnv, obj, methodID, args);
}

jint Jei_CallIntMethod(jobject arg1, jmethodID arg2) {
    attach_thread();
    return (*jniEnv)->CallIntMethod(jniEnv, arg1, arg2);
}

jint Jei_CallIntMethodA(jobject obj, jmethodID methodID, const jvalue * args) {
    attach_thread();
    return (*jniEnv)->CallIntMethodA(jniEnv, obj, methodID, args);
}

jlong Jei_CallLongMethod(jobject arg1, jmethodID arg2) {
    attach_thread();
    return (*jniEnv)->CallLongMethod(jniEnv, arg1, arg2);
}

jlong Jei_CallLongMethodA(jobject obj, jmethodID methodID, const jvalue * args) {
    attach_thread();
    return (*jniEnv)->CallLongMethodA(jniEnv, obj, methodID, args);
}

jfloat Jei_CallFloatMethod(jobject arg1, jmethodID arg2) {
    attach_thread();
    return (*jniEnv)->CallFloatMethod(jniEnv, arg1, arg2);
}

jfloat Jei_CallFloatMethodA(jobject obj, jmethodID methodID, const jvalue * args) {
    attach_thread();
    return (*jniEnv)->CallFloatMethodA(jniEnv, obj, methodID, args);
}

jdouble Jei_CallDoubleMethod(jobject arg1, jmethodID arg2) {
    attach_thread();
    return (*jniEnv)->CallDoubleMethod(jniEnv, arg1, arg2);
}

jdouble Jei_CallDoubleMethodA(jobject obj, jmethodID methodID, const jvalue * args) {
    attach_thread();
    return (*jniEnv)->CallDoubleMethodA(jniEnv, obj, methodID, args);
}

void Jei_CallVoidMethod(jobject arg1, jmethodID arg2) {
    attach_thread();
    (*jniEnv)->CallVoidMethod(jniEnv, arg1, arg2);
}

void Jei_CallVoidMethodA(jobject obj, jmethodID methodID, const jvalue * args) {
    attach_thread();
    (*jniEnv)->CallVoidMethodA(jniEnv, obj, methodID, args);
}

jobject Jei_CallNonvirtualObjectMethod(jobject arg1, jclass arg2, jmethodID arg3) {
    attach_thread();
    return to_global_ref((*jniEnv)->CallNonvirtualObjectMethod(jniEnv, arg1, arg2, arg3));
}

jobject Jei_CallNonvirtualObjectMethodA(jobject obj, jclass clazz, jmethodID methodID, const jvalue * args) {
    attach_thread();
    return to_global_ref((*jniEnv)->CallNonvirtualObjectMethodA(jniEnv, obj, clazz, methodID, args));
}

jboolean Jei_CallNonvirtualBooleanMethod(jobject arg1, jclass arg2, jmethodID arg3) {
    attach_thread();
    return (*jniEnv)->CallNonvirtualBooleanMethod(jniEnv, arg1, arg2, arg3);
}

jboolean Jei_CallNonvirtualBooleanMethodA(jobject obj, jclass clazz, jmethodID methodID, const jvalue * args) {
    attach_thread();
    return (*jniEnv)->CallNonvirtualBooleanMethodA(jniEnv, obj, clazz, methodID, args);
}

jbyte Jei_CallNonvirtualByteMethod(jobject arg1, jclass arg2, jmethodID arg3) {
    attach_thread();
    return (*jniEnv)->CallNonvirtualByteMethod(jniEnv, arg1, arg2, arg3);
}

jbyte Jei_CallNonvirtualByteMethodA(jobject obj, jclass clazz, jmethodID methodID, const jvalue * args) {
    attach_thread();
    return (*jniEnv)->CallNonvirtualByteMethodA(jniEnv, obj, clazz, methodID, args);
}

jchar Jei_CallNonvirtualCharMethod(jobject arg1, jclass arg2, jmethodID arg3) {
    attach_thread();
    return (*jniEnv)->CallNonvirtualCharMethod(jniEnv, arg1, arg2, arg3);
}

jchar Jei_CallNonvirtualCharMethodA(jobject obj, jclass clazz, jmethodID methodID, const jvalue * args) {
    attach_thread();
    return (*jniEnv)->CallNonvirtualCharMethodA(jniEnv, obj, clazz, methodID, args);
}

jshort Jei_CallNonvirtualShortMethod(jobject arg1, jclass arg2, jmethodID arg3) {
    attach_thread();
    return (*jniEnv)->CallNonvirtualShortMethod(jniEnv, arg1, arg2, arg3);
}

jshort Jei_CallNonvirtualShortMethodA(jobject obj, jclass clazz, jmethodID methodID, const jvalue * args) {
    attach_thread();
    return (*jniEnv)->CallNonvirtualShortMethodA(jniEnv, obj, clazz, methodID, args);
}

jint Jei_CallNonvirtualIntMethod(jobject arg1, jclass arg2, jmethodID arg3) {
    attach_thread();
    return (*jniEnv)->CallNonvirtualIntMethod(jniEnv, arg1, arg2, arg3);
}

jint Jei_CallNonvirtualIntMethodA(jobject obj, jclass clazz, jmethodID methodID, const jvalue * args) {
    attach_thread();
    return (*jniEnv)->CallNonvirtualIntMethodA(jniEnv, obj, clazz, methodID, args);
}

jlong Jei_CallNonvirtualLongMethod(jobject arg1, jclass arg2, jmethodID arg3) {
    attach_thread();
    return (*jniEnv)->CallNonvirtualLongMethod(jniEnv, arg1, arg2, arg3);
}

jlong Jei_CallNonvirtualLongMethodA(jobject obj, jclass clazz, jmethodID methodID, const jvalue * args) {
    attach_thread();
    return (*jniEnv)->CallNonvirtualLongMethodA(jniEnv, obj, clazz, methodID, args);
}

jfloat Jei_CallNonvirtualFloatMethod(jobject arg1, jclass arg2, jmethodID arg3) {
    attach_thread();
    return (*jniEnv)->CallNonvirtualFloatMethod(jniEnv, arg1, arg2, arg3);
}

jfloat Jei_CallNonvirtualFloatMethodA(jobject obj, jclass clazz, jmethodID methodID, const jvalue * args) {
    attach_thread();
    return (*jniEnv)->CallNonvirtualFloatMethodA(jniEnv, obj, clazz, methodID, args);
}

jdouble Jei_CallNonvirtualDoubleMethod(jobject arg1, jclass arg2, jmethodID arg3) {
    attach_thread();
    return (*jniEnv)->CallNonvirtualDoubleMethod(jniEnv, arg1, arg2, arg3);
}

jdouble Jei_CallNonvirtualDoubleMethodA(jobject obj, jclass clazz, jmethodID methodID, const jvalue * args) {
    attach_thread();
    return (*jniEnv)->CallNonvirtualDoubleMethodA(jniEnv, obj, clazz, methodID, args);
}

void Jei_CallNonvirtualVoidMethod(jobject arg1, jclass arg2, jmethodID arg3) {
    attach_thread();
    (*jniEnv)->CallNonvirtualVoidMethod(jniEnv, arg1, arg2, arg3);
}

void Jei_CallNonvirtualVoidMethodA(jobject obj, jclass clazz, jmethodID methodID, const jvalue * args) {
    attach_thread();
    (*jniEnv)->CallNonvirtualVoidMethodA(jniEnv, obj, clazz, methodID, args);
}

jfieldID Jei_GetFieldID(jclass clazz, const char * name, const char * sig) {
    attach_thread();
    return (*jniEnv)->GetFieldID(jniEnv, clazz, name, sig);
}

jobject Jei_GetObjectField(jobject obj, jfieldID fieldID) {
    attach_thread();
    return to_global_ref((*jniEnv)->GetObjectField(jniEnv, obj, fieldID));
}

jboolean Jei_GetBooleanField(jobject obj, jfieldID fieldID) {
    attach_thread();
    return (*jniEnv)->GetBooleanField(jniEnv, obj, fieldID);
}

jbyte Jei_GetByteField(jobject obj, jfieldID fieldID) {
    attach_thread();
    return (*jniEnv)->GetByteField(jniEnv, obj, fieldID);
}

jchar Jei_GetCharField(jobject obj, jfieldID fieldID) {
    attach_thread();
    return (*jniEnv)->GetCharField(jniEnv, obj, fieldID);
}

jshort Jei_GetShortField(jobject obj, jfieldID fieldID) {
    attach_thread();
    return (*jniEnv)->GetShortField(jniEnv, obj, fieldID);
}

jint Jei_GetIntField(jobject obj, jfieldID fieldID) {
    attach_thread();
    return (*jniEnv)->GetIntField(jniEnv, obj, fieldID);
}

jlong Jei_GetLongField(jobject obj, jfieldID fieldID) {
    attach_thread();
    return (*jniEnv)->GetLongField(jniEnv, obj, fieldID);
}

jfloat Jei_GetFloatField(jobject obj, jfieldID fieldID) {
    attach_thread();
    return (*jniEnv)->GetFloatField(jniEnv, obj, fieldID);
}

jdouble Jei_GetDoubleField(jobject obj, jfieldID fieldID) {
    attach_thread();
    return (*jniEnv)->GetDoubleField(jniEnv, obj, fieldID);
}

void Jei_SetObjectField(jobject obj, jfieldID fieldID, jobject val) {
    attach_thread();
    (*jniEnv)->SetObjectField(jniEnv, obj, fieldID, val);
}

void Jei_SetBooleanField(jobject obj, jfieldID fieldID, jboolean val) {
    attach_thread();
    (*jniEnv)->SetBooleanField(jniEnv, obj, fieldID, val);
}

void Jei_SetByteField(jobject obj, jfieldID fieldID, jbyte val) {
    attach_thread();
    (*jniEnv)->SetByteField(jniEnv, obj, fieldID, val);
}

void Jei_SetCharField(jobject obj, jfieldID fieldID, jchar val) {
    attach_thread();
    (*jniEnv)->SetCharField(jniEnv, obj, fieldID, val);
}

void Jei_SetShortField(jobject obj, jfieldID fieldID, jshort val) {
    attach_thread();
    (*jniEnv)->SetShortField(jniEnv, obj, fieldID, val);
}

void Jei_SetIntField(jobject obj, jfieldID fieldID, jint val) {
    attach_thread();
    (*jniEnv)->SetIntField(jniEnv, obj, fieldID, val);
}

void Jei_SetLongField(jobject obj, jfieldID fieldID, jlong val) {
    attach_thread();
    (*jniEnv)->SetLongField(jniEnv, obj, fieldID, val);
}

void Jei_SetFloatField(jobject obj, jfieldID fieldID, jfloat val) {
    attach_thread();
    (*jniEnv)->SetFloatField(jniEnv, obj, fieldID, val);
}

void Jei_SetDoubleField(jobject obj, jfieldID fieldID, jdouble val) {
    attach_thread();
    (*jniEnv)->SetDoubleField(jniEnv, obj, fieldID, val);
}

jmethodID Jei_GetStaticMethodID(jclass clazz, const char * name, const char * sig) {
    attach_thread();
    return (*jniEnv)->GetStaticMethodID(jniEnv, clazz, name, sig);
}

jobject Jei_CallStaticObjectMethod(jclass arg1, jmethodID arg2) {
    attach_thread();
    return to_global_ref((*jniEnv)->CallStaticObjectMethod(jniEnv, arg1, arg2));
}

jobject Jei_CallStaticObjectMethodA(jclass clazz, jmethodID methodID, const jvalue * args) {
    attach_thread();
    return to_global_ref((*jniEnv)->CallStaticObjectMethodA(jniEnv, clazz, methodID, args));
}

jboolean Jei_CallStaticBooleanMethod(jclass arg1, jmethodID arg2) {
    attach_thread();
    return (*jniEnv)->CallStaticBooleanMethod(jniEnv, arg1, arg2);
}

jboolean Jei_CallStaticBooleanMethodA(jclass clazz, jmethodID methodID, const jvalue * args) {
    attach_thread();
    return (*jniEnv)->CallStaticBooleanMethodA(jniEnv, clazz, methodID, args);
}

jbyte Jei_CallStaticByteMethod(jclass arg1, jmethodID arg2) {
    attach_thread();
    return (*jniEnv)->CallStaticByteMethod(jniEnv, arg1, arg2);
}

jbyte Jei_CallStaticByteMethodA(jclass clazz, jmethodID methodID, const jvalue * args) {
    attach_thread();
    return (*jniEnv)->CallStaticByteMethodA(jniEnv, clazz, methodID, args);
}

jchar Jei_CallStaticCharMethod(jclass arg1, jmethodID arg2) {
    attach_thread();
    return (*jniEnv)->CallStaticCharMethod(jniEnv, arg1, arg2);
}

jchar Jei_CallStaticCharMethodA(jclass clazz, jmethodID methodID, const jvalue * args) {
    attach_thread();
    return (*jniEnv)->CallStaticCharMethodA(jniEnv, clazz, methodID, args);
}

jshort Jei_CallStaticShortMethod(jclass arg1, jmethodID arg2) {
    attach_thread();
    return (*jniEnv)->CallStaticShortMethod(jniEnv, arg1, arg2);
}

jshort Jei_CallStaticShortMethodA(jclass clazz, jmethodID methodID, const jvalue * args) {
    attach_thread();
    return (*jniEnv)->CallStaticShortMethodA(jniEnv, clazz, methodID, args);
}

jint Jei_CallStaticIntMethod(jclass arg1, jmethodID arg2) {
    attach_thread();
    return (*jniEnv)->CallStaticIntMethod(jniEnv, arg1, arg2);
}

jint Jei_CallStaticIntMethodA(jclass clazz, jmethodID methodID, const jvalue * args) {
    attach_thread();
    return (*jniEnv)->CallStaticIntMethodA(jniEnv, clazz, methodID, args);
}

jlong Jei_CallStaticLongMethod(jclass arg1, jmethodID arg2) {
    attach_thread();
    return (*jniEnv)->CallStaticLongMethod(jniEnv, arg1, arg2);
}

jlong Jei_CallStaticLongMethodA(jclass clazz, jmethodID methodID, const jvalue * args) {
    attach_thread();
    return (*jniEnv)->CallStaticLongMethodA(jniEnv, clazz, methodID, args);
}

jfloat Jei_CallStaticFloatMethod(jclass arg1, jmethodID arg2) {
    attach_thread();
    return (*jniEnv)->CallStaticFloatMethod(jniEnv, arg1, arg2);
}

jfloat Jei_CallStaticFloatMethodA(jclass clazz, jmethodID methodID, const jvalue * args) {
    attach_thread();
    return (*jniEnv)->CallStaticFloatMethodA(jniEnv, clazz, methodID, args);
}

jdouble Jei_CallStaticDoubleMethod(jclass arg1, jmethodID arg2) {
    attach_thread();
    return (*jniEnv)->CallStaticDoubleMethod(jniEnv, arg1, arg2);
}

jdouble Jei_CallStaticDoubleMethodA(jclass clazz, jmethodID methodID, const jvalue * args) {
    attach_thread();
    return (*jniEnv)->CallStaticDoubleMethodA(jniEnv, clazz, methodID, args);
}

void Jei_CallStaticVoidMethod(jclass arg1, jmethodID arg2) {
    attach_thread();
    (*jniEnv)->CallStaticVoidMethod(jniEnv, arg1, arg2);
}

void Jei_CallStaticVoidMethodA(jclass clazz, jmethodID methodID, const jvalue * args) {
    attach_thread();
    (*jniEnv)->CallStaticVoidMethodA(jniEnv, clazz, methodID, args);
}

jfieldID Jei_GetStaticFieldID(jclass clazz, const char * name, const char * sig) {
    attach_thread();
    return (*jniEnv)->GetStaticFieldID(jniEnv, clazz, name, sig);
}

jobject Jei_GetStaticObjectField(jclass clazz, jfieldID fieldID) {
    attach_thread();
    return to_global_ref((*jniEnv)->GetStaticObjectField(jniEnv, clazz, fieldID));
}

jboolean Jei_GetStaticBooleanField(jclass clazz, jfieldID fieldID) {
    attach_thread();
    return (*jniEnv)->GetStaticBooleanField(jniEnv, clazz, fieldID);
}

jbyte Jei_GetStaticByteField(jclass clazz, jfieldID fieldID) {
    attach_thread();
    return (*jniEnv)->GetStaticByteField(jniEnv, clazz, fieldID);
}

jchar Jei_GetStaticCharField(jclass clazz, jfieldID fieldID) {
    attach_thread();
    return (*jniEnv)->GetStaticCharField(jniEnv, clazz, fieldID);
}

jshort Jei_GetStaticShortField(jclass clazz, jfieldID fieldID) {
    attach_thread();
    return (*jniEnv)->GetStaticShortField(jniEnv, clazz, fieldID);
}

jint Jei_GetStaticIntField(jclass clazz, jfieldID fieldID) {
    attach_thread();
    return (*jniEnv)->GetStaticIntField(jniEnv, clazz, fieldID);
}

jlong Jei_GetStaticLongField(jclass clazz, jfieldID fieldID) {
    attach_thread();
    return (*jniEnv)->GetStaticLongField(jniEnv, clazz, fieldID);
}

jfloat Jei_GetStaticFloatField(jclass clazz, jfieldID fieldID) {
    attach_thread();
    return (*jniEnv)->GetStaticFloatField(jniEnv, clazz, fieldID);
}

jdouble Jei_GetStaticDoubleField(jclass clazz, jfieldID fieldID) {
    attach_thread();
    return (*jniEnv)->GetStaticDoubleField(jniEnv, clazz, fieldID);
}

void Jei_SetStaticObjectField(jclass clazz, jfieldID fieldID, jobject val) {
    attach_thread();
    (*jniEnv)->SetStaticObjectField(jniEnv, clazz, fieldID, val);
}

void Jei_SetStaticBooleanField(jclass clazz, jfieldID fieldID, jboolean val) {
    attach_thread();
    (*jniEnv)->SetStaticBooleanField(jniEnv, clazz, fieldID, val);
}

void Jei_SetStaticByteField(jclass clazz, jfieldID fieldID, jbyte val) {
    attach_thread();
    (*jniEnv)->SetStaticByteField(jniEnv, clazz, fieldID, val);
}

void Jei_SetStaticCharField(jclass clazz, jfieldID fieldID, jchar val) {
    attach_thread();
    (*jniEnv)->SetStaticCharField(jniEnv, clazz, fieldID, val);
}

void Jei_SetStaticShortField(jclass clazz, jfieldID fieldID, jshort val) {
    attach_thread();
    (*jniEnv)->SetStaticShortField(jniEnv, clazz, fieldID, val);
}

void Jei_SetStaticIntField(jclass clazz, jfieldID fieldID, jint val) {
    attach_thread();
    (*jniEnv)->SetStaticIntField(jniEnv, clazz, fieldID, val);
}

void Jei_SetStaticLongField(jclass clazz, jfieldID fieldID, jlong val) {
    attach_thread();
    (*jniEnv)->SetStaticLongField(jniEnv, clazz, fieldID, val);
}

void Jei_SetStaticFloatField(jclass clazz, jfieldID fieldID, jfloat val) {
    attach_thread();
    (*jniEnv)->SetStaticFloatField(jniEnv, clazz, fieldID, val);
}

void Jei_SetStaticDoubleField(jclass clazz, jfieldID fieldID, jdouble val) {
    attach_thread();
    (*jniEnv)->SetStaticDoubleField(jniEnv, clazz, fieldID, val);
}

jstring Jei_NewString(const jchar * unicodeChars, jsize len) {
    attach_thread();
    return to_global_ref((*jniEnv)->NewString(jniEnv, unicodeChars, len));
}

jsize Jei_GetStringLength(jstring string) {
    attach_thread();
    return (*jniEnv)->GetStringLength(jniEnv, string);
}

const jchar * Jei_GetStringChars(jstring string, jboolean * isCopy) {
    attach_thread();
    return (*jniEnv)->GetStringChars(jniEnv, string, isCopy);
}

void Jei_ReleaseStringChars(jstring string, const jchar * isCopy) {
    attach_thread();
    (*jniEnv)->ReleaseStringChars(jniEnv, string, isCopy);
}

jstring Jei_NewStringUTF(const char * bytes) {
    attach_thread();
    return to_global_ref((*jniEnv)->NewStringUTF(jniEnv, bytes));
}

jsize Jei_GetStringUTFLength(jstring string) {
    attach_thread();
    return (*jniEnv)->GetStringUTFLength(jniEnv, string);
}

const char * Jei_GetStringUTFChars(jstring string, jboolean * isCopy) {
    attach_thread();
    return (*jniEnv)->GetStringUTFChars(jniEnv, string, isCopy);
}

void Jei_ReleaseStringUTFChars(jstring string, const char * utf) {
    attach_thread();
    (*jniEnv)->ReleaseStringUTFChars(jniEnv, string, utf);
}

jsize Jei_GetArrayLength(jarray array) {
    attach_thread();
    return (*jniEnv)->GetArrayLength(jniEnv, array);
}

jobjectArray Jei_NewObjectArray(jsize length, jclass elementClass, jobject initialElement) {
    attach_thread();
    return to_global_ref((*jniEnv)->NewObjectArray(jniEnv, length, elementClass, initialElement));
}

jobject Jei_GetObjectArrayElement(jobjectArray array, jsize index) {
    attach_thread();
    return to_global_ref((*jniEnv)->GetObjectArrayElement(jniEnv, array, index));
}

void Jei_SetObjectArrayElement(jobjectArray array, jsize index, jobject val) {
    attach_thread();
    (*jniEnv)->SetObjectArrayElement(jniEnv, array, index, val);
}

jbooleanArray Jei_NewBooleanArray(jsize length) {
    attach_thread();
    return to_global_ref((*jniEnv)->NewBooleanArray(jniEnv, length));
}

jbyteArray Jei_NewByteArray(jsize length) {
    attach_thread();
    return to_global_ref((*jniEnv)->NewByteArray(jniEnv, length));
}

jcharArray Jei_NewCharArray(jsize length) {
    attach_thread();
    return to_global_ref((*jniEnv)->NewCharArray(jniEnv, length));
}

jshortArray Jei_NewShortArray(jsize length) {
    attach_thread();
    return to_global_ref((*jniEnv)->NewShortArray(jniEnv, length));
}

jintArray Jei_NewIntArray(jsize length) {
    attach_thread();
    return to_global_ref((*jniEnv)->NewIntArray(jniEnv, length));
}

jlongArray Jei_NewLongArray(jsize length) {
    attach_thread();
    return to_global_ref((*jniEnv)->NewLongArray(jniEnv, length));
}

jfloatArray Jei_NewFloatArray(jsize length) {
    attach_thread();
    return to_global_ref((*jniEnv)->NewFloatArray(jniEnv, length));
}

jdoubleArray Jei_NewDoubleArray(jsize length) {
    attach_thread();
    return to_global_ref((*jniEnv)->NewDoubleArray(jniEnv, length));
}

jboolean * Jei_GetBooleanArrayElements(jbooleanArray array, jboolean * isCopy) {
    attach_thread();
    return (*jniEnv)->GetBooleanArrayElements(jniEnv, array, isCopy);
}

jbyte * Jei_GetByteArrayElements(jbyteArray array, jboolean * isCopy) {
    attach_thread();
    return (*jniEnv)->GetByteArrayElements(jniEnv, array, isCopy);
}

jchar * Jei_GetCharArrayElements(jcharArray array, jboolean * isCopy) {
    attach_thread();
    return (*jniEnv)->GetCharArrayElements(jniEnv, array, isCopy);
}

jshort * Jei_GetShortArrayElements(jshortArray array, jboolean * isCopy) {
    attach_thread();
    return (*jniEnv)->GetShortArrayElements(jniEnv, array, isCopy);
}

jint * Jei_GetIntArrayElements(jintArray array, jboolean * isCopy) {
    attach_thread();
    return (*jniEnv)->GetIntArrayElements(jniEnv, array, isCopy);
}

jlong * Jei_GetLongArrayElements(jlongArray array, jboolean * isCopy) {
    attach_thread();
    return (*jniEnv)->GetLongArrayElements(jniEnv, array, isCopy);
}

jfloat * Jei_GetFloatArrayElements(jfloatArray array, jboolean * isCopy) {
    attach_thread();
    return (*jniEnv)->GetFloatArrayElements(jniEnv, array, isCopy);
}

jdouble * Jei_GetDoubleArrayElements(jdoubleArray array, jboolean * isCopy) {
    attach_thread();
    return (*jniEnv)->GetDoubleArrayElements(jniEnv, array, isCopy);
}

void Jei_ReleaseBooleanArrayElements(jbooleanArray array, jboolean * elems, jint mode) {
    attach_thread();
    (*jniEnv)->ReleaseBooleanArrayElements(jniEnv, array, elems, mode);
}

void Jei_ReleaseByteArrayElements(jbyteArray array, jbyte * elems, jint mode) {
    attach_thread();
    (*jniEnv)->ReleaseByteArrayElements(jniEnv, array, elems, mode);
}

void Jei_ReleaseCharArrayElements(jcharArray array, jchar * elems, jint mode) {
    attach_thread();
    (*jniEnv)->ReleaseCharArrayElements(jniEnv, array, elems, mode);
}

void Jei_ReleaseShortArrayElements(jshortArray array, jshort * elems, jint mode) {
    attach_thread();
    (*jniEnv)->ReleaseShortArrayElements(jniEnv, array, elems, mode);
}

void Jei_ReleaseIntArrayElements(jintArray array, jint * elems, jint mode) {
    attach_thread();
    (*jniEnv)->ReleaseIntArrayElements(jniEnv, array, elems, mode);
}

void Jei_ReleaseLongArrayElements(jlongArray array, jlong * elems, jint mode) {
    attach_thread();
    (*jniEnv)->ReleaseLongArrayElements(jniEnv, array, elems, mode);
}

void Jei_ReleaseFloatArrayElements(jfloatArray array, jfloat * elems, jint mode) {
    attach_thread();
    (*jniEnv)->ReleaseFloatArrayElements(jniEnv, array, elems, mode);
}

void Jei_ReleaseDoubleArrayElements(jdoubleArray array, jdouble * elems, jint mode) {
    attach_thread();
    (*jniEnv)->ReleaseDoubleArrayElements(jniEnv, array, elems, mode);
}

void Jei_GetBooleanArrayRegion(jbooleanArray array, jsize start, jsize len, jboolean * buf) {
    attach_thread();
    (*jniEnv)->GetBooleanArrayRegion(jniEnv, array, start, len, buf);
}

void Jei_GetByteArrayRegion(jbyteArray array, jsize start, jsize len, jbyte * buf) {
    attach_thread();
    (*jniEnv)->GetByteArrayRegion(jniEnv, array, start, len, buf);
}

void Jei_GetCharArrayRegion(jcharArray array, jsize start, jsize len, jchar * buf) {
    attach_thread();
    (*jniEnv)->GetCharArrayRegion(jniEnv, array, start, len, buf);
}

void Jei_GetShortArrayRegion(jshortArray array, jsize start, jsize len, jshort * buf) {
    attach_thread();
    (*jniEnv)->GetShortArrayRegion(jniEnv, array, start, len, buf);
}

void Jei_GetIntArrayRegion(jintArray array, jsize start, jsize len, jint * buf) {
    attach_thread();
    (*jniEnv)->GetIntArrayRegion(jniEnv, array, start, len, buf);
}

void Jei_GetLongArrayRegion(jlongArray array, jsize start, jsize len, jlong * buf) {
    attach_thread();
    (*jniEnv)->GetLongArrayRegion(jniEnv, array, start, len, buf);
}

void Jei_GetFloatArrayRegion(jfloatArray array, jsize start, jsize len, jfloat * buf) {
    attach_thread();
    (*jniEnv)->GetFloatArrayRegion(jniEnv, array, start, len, buf);
}

void Jei_GetDoubleArrayRegion(jdoubleArray array, jsize start, jsize len, jdouble * buf) {
    attach_thread();
    (*jniEnv)->GetDoubleArrayRegion(jniEnv, array, start, len, buf);
}

void Jei_SetBooleanArrayRegion(jbooleanArray array, jsize start, jsize len, const jboolean * buf) {
    attach_thread();
    (*jniEnv)->SetBooleanArrayRegion(jniEnv, array, start, len, buf);
}

void Jei_SetByteArrayRegion(jbyteArray array, jsize start, jsize len, const jbyte * buf) {
    attach_thread();
    (*jniEnv)->SetByteArrayRegion(jniEnv, array, start, len, buf);
}

void Jei_SetCharArrayRegion(jcharArray array, jsize start, jsize len, const jchar * buf) {
    attach_thread();
    (*jniEnv)->SetCharArrayRegion(jniEnv, array, start, len, buf);
}

void Jei_SetShortArrayRegion(jshortArray array, jsize start, jsize len, const jshort * buf) {
    attach_thread();
    (*jniEnv)->SetShortArrayRegion(jniEnv, array, start, len, buf);
}

void Jei_SetIntArrayRegion(jintArray array, jsize start, jsize len, const jint * buf) {
    attach_thread();
    (*jniEnv)->SetIntArrayRegion(jniEnv, array, start, len, buf);
}

void Jei_SetLongArrayRegion(jlongArray array, jsize start, jsize len, const jlong * buf) {
    attach_thread();
    (*jniEnv)->SetLongArrayRegion(jniEnv, array, start, len, buf);
}

void Jei_SetFloatArrayRegion(jfloatArray array, jsize start, jsize len, const jfloat * buf) {
    attach_thread();
    (*jniEnv)->SetFloatArrayRegion(jniEnv, array, start, len, buf);
}

void Jei_SetDoubleArrayRegion(jdoubleArray array, jsize start, jsize len, const jdouble * buf) {
    attach_thread();
    (*jniEnv)->SetDoubleArrayRegion(jniEnv, array, start, len, buf);
}

jint Jei_RegisterNatives(jclass clazz, const JNINativeMethod * methods, jint nMethods) {
    attach_thread();
    return (*jniEnv)->RegisterNatives(jniEnv, clazz, methods, nMethods);
}

jint Jei_UnregisterNatives(jclass clazz) {
    attach_thread();
    return (*jniEnv)->UnregisterNatives(jniEnv, clazz);
}

jint Jei_MonitorEnter(jobject obj) {
    attach_thread();
    return (*jniEnv)->MonitorEnter(jniEnv, obj);
}

jint Jei_MonitorExit(jobject obj) {
    attach_thread();
    return (*jniEnv)->MonitorExit(jniEnv, obj);
}

jint Jei_GetJavaVM(JavaVM ** vm) {
    attach_thread();
    return (*jniEnv)->GetJavaVM(jniEnv, vm);
}

void Jei_GetStringRegion(jstring str, jsize start, jsize len, jchar * buf) {
    attach_thread();
    (*jniEnv)->GetStringRegion(jniEnv, str, start, len, buf);
}

void Jei_GetStringUTFRegion(jstring str, jsize start, jsize len, char * buf) {
    attach_thread();
    (*jniEnv)->GetStringUTFRegion(jniEnv, str, start, len, buf);
}

void * Jei_GetPrimitiveArrayCritical(jarray array, jboolean * isCopy) {
    attach_thread();
    return (*jniEnv)->GetPrimitiveArrayCritical(jniEnv, array, isCopy);
}

void Jei_ReleasePrimitiveArrayCritical(jarray array, void * carray, jint mode) {
    attach_thread();
    (*jniEnv)->ReleasePrimitiveArrayCritical(jniEnv, array, carray, mode);
}

const jchar * Jei_GetStringCritical(jstring str, jboolean * isCopy) {
    attach_thread();
    return (*jniEnv)->GetStringCritical(jniEnv, str, isCopy);
}

void Jei_ReleaseStringCritical(jstring str, const jchar * carray) {
    attach_thread();
    (*jniEnv)->ReleaseStringCritical(jniEnv, str, carray);
}

jweak Jei_NewWeakGlobalRef(jobject obj) {
    attach_thread();
    return to_global_ref((*jniEnv)->NewWeakGlobalRef(jniEnv, obj));
}

void Jei_DeleteWeakGlobalRef(jweak obj) {
    attach_thread();
    (*jniEnv)->DeleteWeakGlobalRef(jniEnv, obj);
}

jboolean Jei_ExceptionCheck() {
    attach_thread();
    return (*jniEnv)->ExceptionCheck(jniEnv);
}

jobject Jei_NewDirectByteBuffer(void * address, jlong capacity) {
    attach_thread();
    return to_global_ref((*jniEnv)->NewDirectByteBuffer(jniEnv, address, capacity));
}

void * Jei_GetDirectBufferAddress(jobject buf) {
    attach_thread();
    return (*jniEnv)->GetDirectBufferAddress(jniEnv, buf);
}

jlong Jei_GetDirectBufferCapacity(jobject buf) {
    attach_thread();
    return (*jniEnv)->GetDirectBufferCapacity(jniEnv, buf);
}

jobjectRefType Jei_GetObjectRefType(jobject obj) {
    attach_thread();
    return (*jniEnv)->GetObjectRefType(jniEnv, obj);
}

struct JniEnvIndir indir = {
    .GetVersion = Jei_GetVersion,
    .DefineClass = Jei_DefineClass,
    .FindClass = Jei_FindClass,
    .FromReflectedMethod = Jei_FromReflectedMethod,
    .FromReflectedField = Jei_FromReflectedField,
    .ToReflectedMethod = Jei_ToReflectedMethod,
    .GetSuperclass = Jei_GetSuperclass,
    .IsAssignableFrom = Jei_IsAssignableFrom,
    .ToReflectedField = Jei_ToReflectedField,
    .Throw = Jei_Throw,
    .ThrowNew = Jei_ThrowNew,
    .ExceptionOccurred = Jei_ExceptionOccurred,
    .ExceptionDescribe = Jei_ExceptionDescribe,
    .ExceptionClear = Jei_ExceptionClear,
    .FatalError = Jei_FatalError,
    .PushLocalFrame = Jei_PushLocalFrame,
    .PopLocalFrame = Jei_PopLocalFrame,
    .NewGlobalRef = Jei_NewGlobalRef,
    .DeleteGlobalRef = Jei_DeleteGlobalRef,
    .IsSameObject = Jei_IsSameObject,
    .EnsureLocalCapacity = Jei_EnsureLocalCapacity,
    .AllocObject = Jei_AllocObject,
    .NewObject = Jei_NewObject,
    .NewObjectA = Jei_NewObjectA,
    .GetObjectClass = Jei_GetObjectClass,
    .IsInstanceOf = Jei_IsInstanceOf,
    .GetMethodID = Jei_GetMethodID,
    .CallObjectMethod = Jei_CallObjectMethod,
    .CallObjectMethodA = Jei_CallObjectMethodA,
    .CallBooleanMethod = Jei_CallBooleanMethod,
    .CallBooleanMethodA = Jei_CallBooleanMethodA,
    .CallByteMethod = Jei_CallByteMethod,
    .CallByteMethodA = Jei_CallByteMethodA,
    .CallCharMethod = Jei_CallCharMethod,
    .CallCharMethodA = Jei_CallCharMethodA,
    .CallShortMethod = Jei_CallShortMethod,
    .CallShortMethodA = Jei_CallShortMethodA,
    .CallIntMethod = Jei_CallIntMethod,
    .CallIntMethodA = Jei_CallIntMethodA,
    .CallLongMethod = Jei_CallLongMethod,
    .CallLongMethodA = Jei_CallLongMethodA,
    .CallFloatMethod = Jei_CallFloatMethod,
    .CallFloatMethodA = Jei_CallFloatMethodA,
    .CallDoubleMethod = Jei_CallDoubleMethod,
    .CallDoubleMethodA = Jei_CallDoubleMethodA,
    .CallVoidMethod = Jei_CallVoidMethod,
    .CallVoidMethodA = Jei_CallVoidMethodA,
    .CallNonvirtualObjectMethod = Jei_CallNonvirtualObjectMethod,
    .CallNonvirtualObjectMethodA = Jei_CallNonvirtualObjectMethodA,
    .CallNonvirtualBooleanMethod = Jei_CallNonvirtualBooleanMethod,
    .CallNonvirtualBooleanMethodA = Jei_CallNonvirtualBooleanMethodA,
    .CallNonvirtualByteMethod = Jei_CallNonvirtualByteMethod,
    .CallNonvirtualByteMethodA = Jei_CallNonvirtualByteMethodA,
    .CallNonvirtualCharMethod = Jei_CallNonvirtualCharMethod,
    .CallNonvirtualCharMethodA = Jei_CallNonvirtualCharMethodA,
    .CallNonvirtualShortMethod = Jei_CallNonvirtualShortMethod,
    .CallNonvirtualShortMethodA = Jei_CallNonvirtualShortMethodA,
    .CallNonvirtualIntMethod = Jei_CallNonvirtualIntMethod,
    .CallNonvirtualIntMethodA = Jei_CallNonvirtualIntMethodA,
    .CallNonvirtualLongMethod = Jei_CallNonvirtualLongMethod,
    .CallNonvirtualLongMethodA = Jei_CallNonvirtualLongMethodA,
    .CallNonvirtualFloatMethod = Jei_CallNonvirtualFloatMethod,
    .CallNonvirtualFloatMethodA = Jei_CallNonvirtualFloatMethodA,
    .CallNonvirtualDoubleMethod = Jei_CallNonvirtualDoubleMethod,
    .CallNonvirtualDoubleMethodA = Jei_CallNonvirtualDoubleMethodA,
    .CallNonvirtualVoidMethod = Jei_CallNonvirtualVoidMethod,
    .CallNonvirtualVoidMethodA = Jei_CallNonvirtualVoidMethodA,
    .GetFieldID = Jei_GetFieldID,
    .GetObjectField = Jei_GetObjectField,
    .GetBooleanField = Jei_GetBooleanField,
    .GetByteField = Jei_GetByteField,
    .GetCharField = Jei_GetCharField,
    .GetShortField = Jei_GetShortField,
    .GetIntField = Jei_GetIntField,
    .GetLongField = Jei_GetLongField,
    .GetFloatField = Jei_GetFloatField,
    .GetDoubleField = Jei_GetDoubleField,
    .SetObjectField = Jei_SetObjectField,
    .SetBooleanField = Jei_SetBooleanField,
    .SetByteField = Jei_SetByteField,
    .SetCharField = Jei_SetCharField,
    .SetShortField = Jei_SetShortField,
    .SetIntField = Jei_SetIntField,
    .SetLongField = Jei_SetLongField,
    .SetFloatField = Jei_SetFloatField,
    .SetDoubleField = Jei_SetDoubleField,
    .GetStaticMethodID = Jei_GetStaticMethodID,
    .CallStaticObjectMethod = Jei_CallStaticObjectMethod,
    .CallStaticObjectMethodA = Jei_CallStaticObjectMethodA,
    .CallStaticBooleanMethod = Jei_CallStaticBooleanMethod,
    .CallStaticBooleanMethodA = Jei_CallStaticBooleanMethodA,
    .CallStaticByteMethod = Jei_CallStaticByteMethod,
    .CallStaticByteMethodA = Jei_CallStaticByteMethodA,
    .CallStaticCharMethod = Jei_CallStaticCharMethod,
    .CallStaticCharMethodA = Jei_CallStaticCharMethodA,
    .CallStaticShortMethod = Jei_CallStaticShortMethod,
    .CallStaticShortMethodA = Jei_CallStaticShortMethodA,
    .CallStaticIntMethod = Jei_CallStaticIntMethod,
    .CallStaticIntMethodA = Jei_CallStaticIntMethodA,
    .CallStaticLongMethod = Jei_CallStaticLongMethod,
    .CallStaticLongMethodA = Jei_CallStaticLongMethodA,
    .CallStaticFloatMethod = Jei_CallStaticFloatMethod,
    .CallStaticFloatMethodA = Jei_CallStaticFloatMethodA,
    .CallStaticDoubleMethod = Jei_CallStaticDoubleMethod,
    .CallStaticDoubleMethodA = Jei_CallStaticDoubleMethodA,
    .CallStaticVoidMethod = Jei_CallStaticVoidMethod,
    .CallStaticVoidMethodA = Jei_CallStaticVoidMethodA,
    .GetStaticFieldID = Jei_GetStaticFieldID,
    .GetStaticObjectField = Jei_GetStaticObjectField,
    .GetStaticBooleanField = Jei_GetStaticBooleanField,
    .GetStaticByteField = Jei_GetStaticByteField,
    .GetStaticCharField = Jei_GetStaticCharField,
    .GetStaticShortField = Jei_GetStaticShortField,
    .GetStaticIntField = Jei_GetStaticIntField,
    .GetStaticLongField = Jei_GetStaticLongField,
    .GetStaticFloatField = Jei_GetStaticFloatField,
    .GetStaticDoubleField = Jei_GetStaticDoubleField,
    .SetStaticObjectField = Jei_SetStaticObjectField,
    .SetStaticBooleanField = Jei_SetStaticBooleanField,
    .SetStaticByteField = Jei_SetStaticByteField,
    .SetStaticCharField = Jei_SetStaticCharField,
    .SetStaticShortField = Jei_SetStaticShortField,
    .SetStaticIntField = Jei_SetStaticIntField,
    .SetStaticLongField = Jei_SetStaticLongField,
    .SetStaticFloatField = Jei_SetStaticFloatField,
    .SetStaticDoubleField = Jei_SetStaticDoubleField,
    .NewString = Jei_NewString,
    .GetStringLength = Jei_GetStringLength,
    .GetStringChars = Jei_GetStringChars,
    .ReleaseStringChars = Jei_ReleaseStringChars,
    .NewStringUTF = Jei_NewStringUTF,
    .GetStringUTFLength = Jei_GetStringUTFLength,
    .GetStringUTFChars = Jei_GetStringUTFChars,
    .ReleaseStringUTFChars = Jei_ReleaseStringUTFChars,
    .GetArrayLength = Jei_GetArrayLength,
    .NewObjectArray = Jei_NewObjectArray,
    .GetObjectArrayElement = Jei_GetObjectArrayElement,
    .SetObjectArrayElement = Jei_SetObjectArrayElement,
    .NewBooleanArray = Jei_NewBooleanArray,
    .NewByteArray = Jei_NewByteArray,
    .NewCharArray = Jei_NewCharArray,
    .NewShortArray = Jei_NewShortArray,
    .NewIntArray = Jei_NewIntArray,
    .NewLongArray = Jei_NewLongArray,
    .NewFloatArray = Jei_NewFloatArray,
    .NewDoubleArray = Jei_NewDoubleArray,
    .GetBooleanArrayElements = Jei_GetBooleanArrayElements,
    .GetByteArrayElements = Jei_GetByteArrayElements,
    .GetCharArrayElements = Jei_GetCharArrayElements,
    .GetShortArrayElements = Jei_GetShortArrayElements,
    .GetIntArrayElements = Jei_GetIntArrayElements,
    .GetLongArrayElements = Jei_GetLongArrayElements,
    .GetFloatArrayElements = Jei_GetFloatArrayElements,
    .GetDoubleArrayElements = Jei_GetDoubleArrayElements,
    .ReleaseBooleanArrayElements = Jei_ReleaseBooleanArrayElements,
    .ReleaseByteArrayElements = Jei_ReleaseByteArrayElements,
    .ReleaseCharArrayElements = Jei_ReleaseCharArrayElements,
    .ReleaseShortArrayElements = Jei_ReleaseShortArrayElements,
    .ReleaseIntArrayElements = Jei_ReleaseIntArrayElements,
    .ReleaseLongArrayElements = Jei_ReleaseLongArrayElements,
    .ReleaseFloatArrayElements = Jei_ReleaseFloatArrayElements,
    .ReleaseDoubleArrayElements = Jei_ReleaseDoubleArrayElements,
    .GetBooleanArrayRegion = Jei_GetBooleanArrayRegion,
    .GetByteArrayRegion = Jei_GetByteArrayRegion,
    .GetCharArrayRegion = Jei_GetCharArrayRegion,
    .GetShortArrayRegion = Jei_GetShortArrayRegion,
    .GetIntArrayRegion = Jei_GetIntArrayRegion,
    .GetLongArrayRegion = Jei_GetLongArrayRegion,
    .GetFloatArrayRegion = Jei_GetFloatArrayRegion,
    .GetDoubleArrayRegion = Jei_GetDoubleArrayRegion,
    .SetBooleanArrayRegion = Jei_SetBooleanArrayRegion,
    .SetByteArrayRegion = Jei_SetByteArrayRegion,
    .SetCharArrayRegion = Jei_SetCharArrayRegion,
    .SetShortArrayRegion = Jei_SetShortArrayRegion,
    .SetIntArrayRegion = Jei_SetIntArrayRegion,
    .SetLongArrayRegion = Jei_SetLongArrayRegion,
    .SetFloatArrayRegion = Jei_SetFloatArrayRegion,
    .SetDoubleArrayRegion = Jei_SetDoubleArrayRegion,
    .RegisterNatives = Jei_RegisterNatives,
    .UnregisterNatives = Jei_UnregisterNatives,
    .MonitorEnter = Jei_MonitorEnter,
    .MonitorExit = Jei_MonitorExit,
    .GetJavaVM = Jei_GetJavaVM,
    .GetStringRegion = Jei_GetStringRegion,
    .GetStringUTFRegion = Jei_GetStringUTFRegion,
    .GetPrimitiveArrayCritical = Jei_GetPrimitiveArrayCritical,
    .ReleasePrimitiveArrayCritical = Jei_ReleasePrimitiveArrayCritical,
    .GetStringCritical = Jei_GetStringCritical,
    .ReleaseStringCritical = Jei_ReleaseStringCritical,
    .NewWeakGlobalRef = Jei_NewWeakGlobalRef,
    .DeleteWeakGlobalRef = Jei_DeleteWeakGlobalRef,
    .ExceptionCheck = Jei_ExceptionCheck,
    .NewDirectByteBuffer = Jei_NewDirectByteBuffer,
    .GetDirectBufferAddress = Jei_GetDirectBufferAddress,
    .GetDirectBufferCapacity = Jei_GetDirectBufferCapacity,
    .GetObjectRefType = Jei_GetObjectRefType,
};

FFI_PLUGIN_EXPORT struct JniEnvIndir *GetIndir(void) {
    if (jni.jvm == NULL) return NULL;
    return &indir;
}
