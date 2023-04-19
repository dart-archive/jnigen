// Auto generated file. Do not edit.

// This is generated from JNI header in Android NDK. License for the same is
// provided below.

/*
 * Copyright (C) 2006 The Android Open Source Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

/*
 * JNI specification, as defined by Sun:
 * http://java.sun.com/javase/6/docs/technotes/guides/jni/spec/jniTOC.html
 *
 * Everything here is expected to be VM-neutral.
 */

// ignore_for_file: non_constant_identifier_names
// coverage:ignore-file

import "dart:ffi" as ffi;

import "jni_bindings_generated.dart";

/// Wraps over the function pointers in JniEnv and exposes them as methods.
class LocalJniEnv {
  final ffi.Pointer<JniEnv> ptr;
  LocalJniEnv(this.ptr);

  late final _GetVersion = ptr.value.ref.GetVersion
      .asFunction<int Function(ffi.Pointer<JniEnv1> env)>();
  int GetVersion() => _GetVersion(ptr);

  late final _DefineClass = ptr.value.ref.DefineClass.asFunction<
      JClassPtr Function(ffi.Pointer<JniEnv1> env, ffi.Pointer<ffi.Char> name,
          JObjectPtr loader, ffi.Pointer<JByteMarker> buf, int bufLen)>();
  JClassPtr DefineClass(ffi.Pointer<ffi.Char> name, JObjectPtr loader,
          ffi.Pointer<JByteMarker> buf, int bufLen) =>
      _DefineClass(ptr, name, loader, buf, bufLen);

  late final _FindClass = ptr.value.ref.FindClass.asFunction<
      JClassPtr Function(
          ffi.Pointer<JniEnv1> env, ffi.Pointer<ffi.Char> name)>();
  JClassPtr FindClass(ffi.Pointer<ffi.Char> name) => _FindClass(ptr, name);

  late final _FromReflectedMethod = ptr.value.ref.FromReflectedMethod
      .asFunction<
          JMethodIDPtr Function(ffi.Pointer<JniEnv1> env, JObjectPtr method)>();
  JMethodIDPtr FromReflectedMethod(JObjectPtr method) =>
      _FromReflectedMethod(ptr, method);

  late final _FromReflectedField = ptr.value.ref.FromReflectedField.asFunction<
      JFieldIDPtr Function(ffi.Pointer<JniEnv1> env, JObjectPtr field)>();
  JFieldIDPtr FromReflectedField(JObjectPtr field) =>
      _FromReflectedField(ptr, field);

  late final _ToReflectedMethod = ptr.value.ref.ToReflectedMethod.asFunction<
      JObjectPtr Function(ffi.Pointer<JniEnv1> env, JClassPtr cls,
          JMethodIDPtr methodId, int isStatic)>();
  JObjectPtr ToReflectedMethod(
          JClassPtr cls, JMethodIDPtr methodId, int isStatic) =>
      _ToReflectedMethod(ptr, cls, methodId, isStatic);

  late final _GetSuperclass = ptr.value.ref.GetSuperclass.asFunction<
      JClassPtr Function(ffi.Pointer<JniEnv1> env, JClassPtr clazz)>();
  JClassPtr GetSuperclass(JClassPtr clazz) => _GetSuperclass(ptr, clazz);

  late final _IsAssignableFrom = ptr.value.ref.IsAssignableFrom.asFunction<
      int Function(
          ffi.Pointer<JniEnv1> env, JClassPtr clazz1, JClassPtr clazz2)>();
  int IsAssignableFrom(JClassPtr clazz1, JClassPtr clazz2) =>
      _IsAssignableFrom(ptr, clazz1, clazz2);

  late final _ToReflectedField = ptr.value.ref.ToReflectedField.asFunction<
      JObjectPtr Function(ffi.Pointer<JniEnv1> env, JClassPtr cls,
          JFieldIDPtr fieldID, int isStatic)>();
  JObjectPtr ToReflectedField(
          JClassPtr cls, JFieldIDPtr fieldID, int isStatic) =>
      _ToReflectedField(ptr, cls, fieldID, isStatic);

  late final _Throw = ptr.value.ref.Throw
      .asFunction<int Function(ffi.Pointer<JniEnv1> env, JThrowablePtr obj)>();
  int Throw(JThrowablePtr obj) => _Throw(ptr, obj);

  late final _ThrowNew = ptr.value.ref.ThrowNew.asFunction<
      int Function(ffi.Pointer<JniEnv1> env, JClassPtr clazz,
          ffi.Pointer<ffi.Char> message)>();
  int ThrowNew(JClassPtr clazz, ffi.Pointer<ffi.Char> message) =>
      _ThrowNew(ptr, clazz, message);

  late final _ExceptionOccurred = ptr.value.ref.ExceptionOccurred
      .asFunction<JThrowablePtr Function(ffi.Pointer<JniEnv1> env)>();
  JThrowablePtr ExceptionOccurred() => _ExceptionOccurred(ptr);

  late final _ExceptionDescribe = ptr.value.ref.ExceptionDescribe
      .asFunction<void Function(ffi.Pointer<JniEnv1> env)>();
  void ExceptionDescribe() => _ExceptionDescribe(ptr);

  late final _ExceptionClear = ptr.value.ref.ExceptionClear
      .asFunction<void Function(ffi.Pointer<JniEnv1> env)>();
  void ExceptionClear() => _ExceptionClear(ptr);

  late final _FatalError = ptr.value.ref.FatalError.asFunction<
      void Function(ffi.Pointer<JniEnv1> env, ffi.Pointer<ffi.Char> msg)>();
  void FatalError(ffi.Pointer<ffi.Char> msg) => _FatalError(ptr, msg);

  late final _PushLocalFrame = ptr.value.ref.PushLocalFrame
      .asFunction<int Function(ffi.Pointer<JniEnv1> env, int capacity)>();
  int PushLocalFrame(int capacity) => _PushLocalFrame(ptr, capacity);

  late final _PopLocalFrame = ptr.value.ref.PopLocalFrame.asFunction<
      JObjectPtr Function(ffi.Pointer<JniEnv1> env, JObjectPtr result)>();
  JObjectPtr PopLocalFrame(JObjectPtr result) => _PopLocalFrame(ptr, result);

  late final _NewGlobalRef = ptr.value.ref.NewGlobalRef.asFunction<
      JObjectPtr Function(ffi.Pointer<JniEnv1> env, JObjectPtr obj)>();
  JObjectPtr NewGlobalRef(JObjectPtr obj) => _NewGlobalRef(ptr, obj);

  late final _DeleteGlobalRef = ptr.value.ref.DeleteGlobalRef.asFunction<
      void Function(ffi.Pointer<JniEnv1> env, JObjectPtr globalRef)>();
  void DeleteGlobalRef(JObjectPtr globalRef) =>
      _DeleteGlobalRef(ptr, globalRef);

  late final _DeleteLocalRef = ptr.value.ref.DeleteLocalRef.asFunction<
      void Function(ffi.Pointer<JniEnv1> env, JObjectPtr localRef)>();
  void DeleteLocalRef(JObjectPtr localRef) => _DeleteLocalRef(ptr, localRef);

  late final _IsSameObject = ptr.value.ref.IsSameObject.asFunction<
      int Function(
          ffi.Pointer<JniEnv1> env, JObjectPtr ref1, JObjectPtr ref2)>();
  int IsSameObject(JObjectPtr ref1, JObjectPtr ref2) =>
      _IsSameObject(ptr, ref1, ref2);

  late final _NewLocalRef = ptr.value.ref.NewLocalRef.asFunction<
      JObjectPtr Function(ffi.Pointer<JniEnv1> env, JObjectPtr obj)>();
  JObjectPtr NewLocalRef(JObjectPtr obj) => _NewLocalRef(ptr, obj);

  late final _EnsureLocalCapacity = ptr.value.ref.EnsureLocalCapacity
      .asFunction<int Function(ffi.Pointer<JniEnv1> env, int capacity)>();
  int EnsureLocalCapacity(int capacity) => _EnsureLocalCapacity(ptr, capacity);

  late final _AllocObject = ptr.value.ref.AllocObject.asFunction<
      JObjectPtr Function(ffi.Pointer<JniEnv1> env, JClassPtr clazz)>();
  JObjectPtr AllocObject(JClassPtr clazz) => _AllocObject(ptr, clazz);

  late final _NewObject = ptr.value.ref.NewObject.asFunction<
      JObjectPtr Function(
          ffi.Pointer<JniEnv1> env, JClassPtr clazz, JMethodIDPtr methodID)>();
  JObjectPtr NewObject(JClassPtr clazz, JMethodIDPtr methodID) =>
      _NewObject(ptr, clazz, methodID);

  late final _NewObjectA = ptr.value.ref.NewObjectA.asFunction<
      JObjectPtr Function(ffi.Pointer<JniEnv1> env, JClassPtr clazz,
          JMethodIDPtr methodID, ffi.Pointer<JValue> args)>();
  JObjectPtr NewObjectA(
          JClassPtr clazz, JMethodIDPtr methodID, ffi.Pointer<JValue> args) =>
      _NewObjectA(ptr, clazz, methodID, args);

  late final _GetObjectClass = ptr.value.ref.GetObjectClass.asFunction<
      JClassPtr Function(ffi.Pointer<JniEnv1> env, JObjectPtr obj)>();
  JClassPtr GetObjectClass(JObjectPtr obj) => _GetObjectClass(ptr, obj);

  late final _IsInstanceOf = ptr.value.ref.IsInstanceOf.asFunction<
      int Function(
          ffi.Pointer<JniEnv1> env, JObjectPtr obj, JClassPtr clazz)>();
  int IsInstanceOf(JObjectPtr obj, JClassPtr clazz) =>
      _IsInstanceOf(ptr, obj, clazz);

  late final _GetMethodID = ptr.value.ref.GetMethodID.asFunction<
      JMethodIDPtr Function(ffi.Pointer<JniEnv1> env, JClassPtr clazz,
          ffi.Pointer<ffi.Char> name, ffi.Pointer<ffi.Char> sig)>();
  JMethodIDPtr GetMethodID(JClassPtr clazz, ffi.Pointer<ffi.Char> name,
          ffi.Pointer<ffi.Char> sig) =>
      _GetMethodID(ptr, clazz, name, sig);

  late final _CallObjectMethod = ptr.value.ref.CallObjectMethod.asFunction<
      JObjectPtr Function(
          ffi.Pointer<JniEnv1> env, JObjectPtr obj, JMethodIDPtr methodID)>();
  JObjectPtr CallObjectMethod(JObjectPtr obj, JMethodIDPtr methodID) =>
      _CallObjectMethod(ptr, obj, methodID);

  late final _CallObjectMethodA = ptr.value.ref.CallObjectMethodA.asFunction<
      JObjectPtr Function(ffi.Pointer<JniEnv1> env, JObjectPtr obj,
          JMethodIDPtr methodID, ffi.Pointer<JValue> args)>();
  JObjectPtr CallObjectMethodA(
          JObjectPtr obj, JMethodIDPtr methodID, ffi.Pointer<JValue> args) =>
      _CallObjectMethodA(ptr, obj, methodID, args);

  late final _CallBooleanMethod = ptr.value.ref.CallBooleanMethod.asFunction<
      int Function(
          ffi.Pointer<JniEnv1> env, JObjectPtr obj, JMethodIDPtr methodID)>();
  int CallBooleanMethod(JObjectPtr obj, JMethodIDPtr methodID) =>
      _CallBooleanMethod(ptr, obj, methodID);

  late final _CallBooleanMethodA = ptr.value.ref.CallBooleanMethodA.asFunction<
      int Function(ffi.Pointer<JniEnv1> env, JObjectPtr obj,
          JMethodIDPtr methodId, ffi.Pointer<JValue> args)>();
  int CallBooleanMethodA(
          JObjectPtr obj, JMethodIDPtr methodId, ffi.Pointer<JValue> args) =>
      _CallBooleanMethodA(ptr, obj, methodId, args);

  late final _CallByteMethod = ptr.value.ref.CallByteMethod.asFunction<
      int Function(
          ffi.Pointer<JniEnv1> env, JObjectPtr obj, JMethodIDPtr methodID)>();
  int CallByteMethod(JObjectPtr obj, JMethodIDPtr methodID) =>
      _CallByteMethod(ptr, obj, methodID);

  late final _CallByteMethodA = ptr.value.ref.CallByteMethodA.asFunction<
      int Function(ffi.Pointer<JniEnv1> env, JObjectPtr obj,
          JMethodIDPtr methodID, ffi.Pointer<JValue> args)>();
  int CallByteMethodA(
          JObjectPtr obj, JMethodIDPtr methodID, ffi.Pointer<JValue> args) =>
      _CallByteMethodA(ptr, obj, methodID, args);

  late final _CallCharMethod = ptr.value.ref.CallCharMethod.asFunction<
      int Function(
          ffi.Pointer<JniEnv1> env, JObjectPtr obj, JMethodIDPtr methodID)>();
  int CallCharMethod(JObjectPtr obj, JMethodIDPtr methodID) =>
      _CallCharMethod(ptr, obj, methodID);

  late final _CallCharMethodA = ptr.value.ref.CallCharMethodA.asFunction<
      int Function(ffi.Pointer<JniEnv1> env, JObjectPtr obj,
          JMethodIDPtr methodID, ffi.Pointer<JValue> args)>();
  int CallCharMethodA(
          JObjectPtr obj, JMethodIDPtr methodID, ffi.Pointer<JValue> args) =>
      _CallCharMethodA(ptr, obj, methodID, args);

  late final _CallShortMethod = ptr.value.ref.CallShortMethod.asFunction<
      int Function(
          ffi.Pointer<JniEnv1> env, JObjectPtr obj, JMethodIDPtr methodID)>();
  int CallShortMethod(JObjectPtr obj, JMethodIDPtr methodID) =>
      _CallShortMethod(ptr, obj, methodID);

  late final _CallShortMethodA = ptr.value.ref.CallShortMethodA.asFunction<
      int Function(ffi.Pointer<JniEnv1> env, JObjectPtr obj,
          JMethodIDPtr methodID, ffi.Pointer<JValue> args)>();
  int CallShortMethodA(
          JObjectPtr obj, JMethodIDPtr methodID, ffi.Pointer<JValue> args) =>
      _CallShortMethodA(ptr, obj, methodID, args);

  late final _CallIntMethod = ptr.value.ref.CallIntMethod.asFunction<
      int Function(
          ffi.Pointer<JniEnv1> env, JObjectPtr obj, JMethodIDPtr methodID)>();
  int CallIntMethod(JObjectPtr obj, JMethodIDPtr methodID) =>
      _CallIntMethod(ptr, obj, methodID);

  late final _CallIntMethodA = ptr.value.ref.CallIntMethodA.asFunction<
      int Function(ffi.Pointer<JniEnv1> env, JObjectPtr obj,
          JMethodIDPtr methodID, ffi.Pointer<JValue> args)>();
  int CallIntMethodA(
          JObjectPtr obj, JMethodIDPtr methodID, ffi.Pointer<JValue> args) =>
      _CallIntMethodA(ptr, obj, methodID, args);

  late final _CallLongMethod = ptr.value.ref.CallLongMethod.asFunction<
      int Function(
          ffi.Pointer<JniEnv1> env, JObjectPtr obj, JMethodIDPtr methodID)>();
  int CallLongMethod(JObjectPtr obj, JMethodIDPtr methodID) =>
      _CallLongMethod(ptr, obj, methodID);

  late final _CallLongMethodA = ptr.value.ref.CallLongMethodA.asFunction<
      int Function(ffi.Pointer<JniEnv1> env, JObjectPtr obj,
          JMethodIDPtr methodID, ffi.Pointer<JValue> args)>();
  int CallLongMethodA(
          JObjectPtr obj, JMethodIDPtr methodID, ffi.Pointer<JValue> args) =>
      _CallLongMethodA(ptr, obj, methodID, args);

  late final _CallFloatMethod = ptr.value.ref.CallFloatMethod.asFunction<
      double Function(
          ffi.Pointer<JniEnv1> env, JObjectPtr obj, JMethodIDPtr methodID)>();
  double CallFloatMethod(JObjectPtr obj, JMethodIDPtr methodID) =>
      _CallFloatMethod(ptr, obj, methodID);

  late final _CallFloatMethodA = ptr.value.ref.CallFloatMethodA.asFunction<
      double Function(ffi.Pointer<JniEnv1> env, JObjectPtr obj,
          JMethodIDPtr methodID, ffi.Pointer<JValue> args)>();
  double CallFloatMethodA(
          JObjectPtr obj, JMethodIDPtr methodID, ffi.Pointer<JValue> args) =>
      _CallFloatMethodA(ptr, obj, methodID, args);

  late final _CallDoubleMethod = ptr.value.ref.CallDoubleMethod.asFunction<
      double Function(
          ffi.Pointer<JniEnv1> env, JObjectPtr obj, JMethodIDPtr methodID)>();
  double CallDoubleMethod(JObjectPtr obj, JMethodIDPtr methodID) =>
      _CallDoubleMethod(ptr, obj, methodID);

  late final _CallDoubleMethodA = ptr.value.ref.CallDoubleMethodA.asFunction<
      double Function(ffi.Pointer<JniEnv1> env, JObjectPtr obj,
          JMethodIDPtr methodID, ffi.Pointer<JValue> args)>();
  double CallDoubleMethodA(
          JObjectPtr obj, JMethodIDPtr methodID, ffi.Pointer<JValue> args) =>
      _CallDoubleMethodA(ptr, obj, methodID, args);

  late final _CallVoidMethod = ptr.value.ref.CallVoidMethod.asFunction<
      void Function(
          ffi.Pointer<JniEnv1> env, JObjectPtr obj, JMethodIDPtr methodID)>();
  void CallVoidMethod(JObjectPtr obj, JMethodIDPtr methodID) =>
      _CallVoidMethod(ptr, obj, methodID);

  late final _CallVoidMethodA = ptr.value.ref.CallVoidMethodA.asFunction<
      void Function(ffi.Pointer<JniEnv1> env, JObjectPtr obj,
          JMethodIDPtr methodID, ffi.Pointer<JValue> args)>();
  void CallVoidMethodA(
          JObjectPtr obj, JMethodIDPtr methodID, ffi.Pointer<JValue> args) =>
      _CallVoidMethodA(ptr, obj, methodID, args);

  late final _CallNonvirtualObjectMethod =
      ptr.value.ref.CallNonvirtualObjectMethod.asFunction<
          JObjectPtr Function(ffi.Pointer<JniEnv1> env, JObjectPtr obj,
              JClassPtr clazz, JMethodIDPtr methodID)>();
  JObjectPtr CallNonvirtualObjectMethod(
          JObjectPtr obj, JClassPtr clazz, JMethodIDPtr methodID) =>
      _CallNonvirtualObjectMethod(ptr, obj, clazz, methodID);

  late final _CallNonvirtualObjectMethodA =
      ptr.value.ref.CallNonvirtualObjectMethodA.asFunction<
          JObjectPtr Function(
              ffi.Pointer<JniEnv1> env,
              JObjectPtr obj,
              JClassPtr clazz,
              JMethodIDPtr methodID,
              ffi.Pointer<JValue> args)>();
  JObjectPtr CallNonvirtualObjectMethodA(JObjectPtr obj, JClassPtr clazz,
          JMethodIDPtr methodID, ffi.Pointer<JValue> args) =>
      _CallNonvirtualObjectMethodA(ptr, obj, clazz, methodID, args);

  late final _CallNonvirtualBooleanMethod =
      ptr.value.ref.CallNonvirtualBooleanMethod.asFunction<
          int Function(ffi.Pointer<JniEnv1> env, JObjectPtr obj,
              JClassPtr clazz, JMethodIDPtr methodID)>();
  int CallNonvirtualBooleanMethod(
          JObjectPtr obj, JClassPtr clazz, JMethodIDPtr methodID) =>
      _CallNonvirtualBooleanMethod(ptr, obj, clazz, methodID);

  late final _CallNonvirtualBooleanMethodA =
      ptr.value.ref.CallNonvirtualBooleanMethodA.asFunction<
          int Function(
              ffi.Pointer<JniEnv1> env,
              JObjectPtr obj,
              JClassPtr clazz,
              JMethodIDPtr methodID,
              ffi.Pointer<JValue> args)>();
  int CallNonvirtualBooleanMethodA(JObjectPtr obj, JClassPtr clazz,
          JMethodIDPtr methodID, ffi.Pointer<JValue> args) =>
      _CallNonvirtualBooleanMethodA(ptr, obj, clazz, methodID, args);

  late final _CallNonvirtualByteMethod = ptr.value.ref.CallNonvirtualByteMethod
      .asFunction<
          int Function(ffi.Pointer<JniEnv1> env, JObjectPtr obj,
              JClassPtr clazz, JMethodIDPtr methodID)>();
  int CallNonvirtualByteMethod(
          JObjectPtr obj, JClassPtr clazz, JMethodIDPtr methodID) =>
      _CallNonvirtualByteMethod(ptr, obj, clazz, methodID);

  late final _CallNonvirtualByteMethodA =
      ptr.value.ref.CallNonvirtualByteMethodA.asFunction<
          int Function(
              ffi.Pointer<JniEnv1> env,
              JObjectPtr obj,
              JClassPtr clazz,
              JMethodIDPtr methodID,
              ffi.Pointer<JValue> args)>();
  int CallNonvirtualByteMethodA(JObjectPtr obj, JClassPtr clazz,
          JMethodIDPtr methodID, ffi.Pointer<JValue> args) =>
      _CallNonvirtualByteMethodA(ptr, obj, clazz, methodID, args);

  late final _CallNonvirtualCharMethod = ptr.value.ref.CallNonvirtualCharMethod
      .asFunction<
          int Function(ffi.Pointer<JniEnv1> env, JObjectPtr obj,
              JClassPtr clazz, JMethodIDPtr methodID)>();
  int CallNonvirtualCharMethod(
          JObjectPtr obj, JClassPtr clazz, JMethodIDPtr methodID) =>
      _CallNonvirtualCharMethod(ptr, obj, clazz, methodID);

  late final _CallNonvirtualCharMethodA =
      ptr.value.ref.CallNonvirtualCharMethodA.asFunction<
          int Function(
              ffi.Pointer<JniEnv1> env,
              JObjectPtr obj,
              JClassPtr clazz,
              JMethodIDPtr methodID,
              ffi.Pointer<JValue> args)>();
  int CallNonvirtualCharMethodA(JObjectPtr obj, JClassPtr clazz,
          JMethodIDPtr methodID, ffi.Pointer<JValue> args) =>
      _CallNonvirtualCharMethodA(ptr, obj, clazz, methodID, args);

  late final _CallNonvirtualShortMethod =
      ptr.value.ref.CallNonvirtualShortMethod.asFunction<
          int Function(ffi.Pointer<JniEnv1> env, JObjectPtr obj,
              JClassPtr clazz, JMethodIDPtr methodID)>();
  int CallNonvirtualShortMethod(
          JObjectPtr obj, JClassPtr clazz, JMethodIDPtr methodID) =>
      _CallNonvirtualShortMethod(ptr, obj, clazz, methodID);

  late final _CallNonvirtualShortMethodA =
      ptr.value.ref.CallNonvirtualShortMethodA.asFunction<
          int Function(
              ffi.Pointer<JniEnv1> env,
              JObjectPtr obj,
              JClassPtr clazz,
              JMethodIDPtr methodID,
              ffi.Pointer<JValue> args)>();
  int CallNonvirtualShortMethodA(JObjectPtr obj, JClassPtr clazz,
          JMethodIDPtr methodID, ffi.Pointer<JValue> args) =>
      _CallNonvirtualShortMethodA(ptr, obj, clazz, methodID, args);

  late final _CallNonvirtualIntMethod = ptr.value.ref.CallNonvirtualIntMethod
      .asFunction<
          int Function(ffi.Pointer<JniEnv1> env, JObjectPtr obj,
              JClassPtr clazz, JMethodIDPtr methodID)>();
  int CallNonvirtualIntMethod(
          JObjectPtr obj, JClassPtr clazz, JMethodIDPtr methodID) =>
      _CallNonvirtualIntMethod(ptr, obj, clazz, methodID);

  late final _CallNonvirtualIntMethodA = ptr.value.ref.CallNonvirtualIntMethodA
      .asFunction<
          int Function(
              ffi.Pointer<JniEnv1> env,
              JObjectPtr obj,
              JClassPtr clazz,
              JMethodIDPtr methodID,
              ffi.Pointer<JValue> args)>();
  int CallNonvirtualIntMethodA(JObjectPtr obj, JClassPtr clazz,
          JMethodIDPtr methodID, ffi.Pointer<JValue> args) =>
      _CallNonvirtualIntMethodA(ptr, obj, clazz, methodID, args);

  late final _CallNonvirtualLongMethod = ptr.value.ref.CallNonvirtualLongMethod
      .asFunction<
          int Function(ffi.Pointer<JniEnv1> env, JObjectPtr obj,
              JClassPtr clazz, JMethodIDPtr methodID)>();
  int CallNonvirtualLongMethod(
          JObjectPtr obj, JClassPtr clazz, JMethodIDPtr methodID) =>
      _CallNonvirtualLongMethod(ptr, obj, clazz, methodID);

  late final _CallNonvirtualLongMethodA =
      ptr.value.ref.CallNonvirtualLongMethodA.asFunction<
          int Function(
              ffi.Pointer<JniEnv1> env,
              JObjectPtr obj,
              JClassPtr clazz,
              JMethodIDPtr methodID,
              ffi.Pointer<JValue> args)>();
  int CallNonvirtualLongMethodA(JObjectPtr obj, JClassPtr clazz,
          JMethodIDPtr methodID, ffi.Pointer<JValue> args) =>
      _CallNonvirtualLongMethodA(ptr, obj, clazz, methodID, args);

  late final _CallNonvirtualFloatMethod =
      ptr.value.ref.CallNonvirtualFloatMethod.asFunction<
          double Function(ffi.Pointer<JniEnv1> env, JObjectPtr obj,
              JClassPtr clazz, JMethodIDPtr methodID)>();
  double CallNonvirtualFloatMethod(
          JObjectPtr obj, JClassPtr clazz, JMethodIDPtr methodID) =>
      _CallNonvirtualFloatMethod(ptr, obj, clazz, methodID);

  late final _CallNonvirtualFloatMethodA =
      ptr.value.ref.CallNonvirtualFloatMethodA.asFunction<
          double Function(
              ffi.Pointer<JniEnv1> env,
              JObjectPtr obj,
              JClassPtr clazz,
              JMethodIDPtr methodID,
              ffi.Pointer<JValue> args)>();
  double CallNonvirtualFloatMethodA(JObjectPtr obj, JClassPtr clazz,
          JMethodIDPtr methodID, ffi.Pointer<JValue> args) =>
      _CallNonvirtualFloatMethodA(ptr, obj, clazz, methodID, args);

  late final _CallNonvirtualDoubleMethod =
      ptr.value.ref.CallNonvirtualDoubleMethod.asFunction<
          double Function(ffi.Pointer<JniEnv1> env, JObjectPtr obj,
              JClassPtr clazz, JMethodIDPtr methodID)>();
  double CallNonvirtualDoubleMethod(
          JObjectPtr obj, JClassPtr clazz, JMethodIDPtr methodID) =>
      _CallNonvirtualDoubleMethod(ptr, obj, clazz, methodID);

  late final _CallNonvirtualDoubleMethodA =
      ptr.value.ref.CallNonvirtualDoubleMethodA.asFunction<
          double Function(
              ffi.Pointer<JniEnv1> env,
              JObjectPtr obj,
              JClassPtr clazz,
              JMethodIDPtr methodID,
              ffi.Pointer<JValue> args)>();
  double CallNonvirtualDoubleMethodA(JObjectPtr obj, JClassPtr clazz,
          JMethodIDPtr methodID, ffi.Pointer<JValue> args) =>
      _CallNonvirtualDoubleMethodA(ptr, obj, clazz, methodID, args);

  late final _CallNonvirtualVoidMethod = ptr.value.ref.CallNonvirtualVoidMethod
      .asFunction<
          void Function(ffi.Pointer<JniEnv1> env, JObjectPtr obj,
              JClassPtr clazz, JMethodIDPtr methodID)>();
  void CallNonvirtualVoidMethod(
          JObjectPtr obj, JClassPtr clazz, JMethodIDPtr methodID) =>
      _CallNonvirtualVoidMethod(ptr, obj, clazz, methodID);

  late final _CallNonvirtualVoidMethodA =
      ptr.value.ref.CallNonvirtualVoidMethodA.asFunction<
          void Function(
              ffi.Pointer<JniEnv1> env,
              JObjectPtr obj,
              JClassPtr clazz,
              JMethodIDPtr methodID,
              ffi.Pointer<JValue> args)>();
  void CallNonvirtualVoidMethodA(JObjectPtr obj, JClassPtr clazz,
          JMethodIDPtr methodID, ffi.Pointer<JValue> args) =>
      _CallNonvirtualVoidMethodA(ptr, obj, clazz, methodID, args);

  late final _GetFieldID = ptr.value.ref.GetFieldID.asFunction<
      JFieldIDPtr Function(ffi.Pointer<JniEnv1> env, JClassPtr clazz,
          ffi.Pointer<ffi.Char> name, ffi.Pointer<ffi.Char> sig)>();
  JFieldIDPtr GetFieldID(JClassPtr clazz, ffi.Pointer<ffi.Char> name,
          ffi.Pointer<ffi.Char> sig) =>
      _GetFieldID(ptr, clazz, name, sig);

  late final _GetObjectField = ptr.value.ref.GetObjectField.asFunction<
      JObjectPtr Function(
          ffi.Pointer<JniEnv1> env, JObjectPtr obj, JFieldIDPtr fieldID)>();
  JObjectPtr GetObjectField(JObjectPtr obj, JFieldIDPtr fieldID) =>
      _GetObjectField(ptr, obj, fieldID);

  late final _GetBooleanField = ptr.value.ref.GetBooleanField.asFunction<
      int Function(
          ffi.Pointer<JniEnv1> env, JObjectPtr obj, JFieldIDPtr fieldID)>();
  int GetBooleanField(JObjectPtr obj, JFieldIDPtr fieldID) =>
      _GetBooleanField(ptr, obj, fieldID);

  late final _GetByteField = ptr.value.ref.GetByteField.asFunction<
      int Function(
          ffi.Pointer<JniEnv1> env, JObjectPtr obj, JFieldIDPtr fieldID)>();
  int GetByteField(JObjectPtr obj, JFieldIDPtr fieldID) =>
      _GetByteField(ptr, obj, fieldID);

  late final _GetCharField = ptr.value.ref.GetCharField.asFunction<
      int Function(
          ffi.Pointer<JniEnv1> env, JObjectPtr obj, JFieldIDPtr fieldID)>();
  int GetCharField(JObjectPtr obj, JFieldIDPtr fieldID) =>
      _GetCharField(ptr, obj, fieldID);

  late final _GetShortField = ptr.value.ref.GetShortField.asFunction<
      int Function(
          ffi.Pointer<JniEnv1> env, JObjectPtr obj, JFieldIDPtr fieldID)>();
  int GetShortField(JObjectPtr obj, JFieldIDPtr fieldID) =>
      _GetShortField(ptr, obj, fieldID);

  late final _GetIntField = ptr.value.ref.GetIntField.asFunction<
      int Function(
          ffi.Pointer<JniEnv1> env, JObjectPtr obj, JFieldIDPtr fieldID)>();
  int GetIntField(JObjectPtr obj, JFieldIDPtr fieldID) =>
      _GetIntField(ptr, obj, fieldID);

  late final _GetLongField = ptr.value.ref.GetLongField.asFunction<
      int Function(
          ffi.Pointer<JniEnv1> env, JObjectPtr obj, JFieldIDPtr fieldID)>();
  int GetLongField(JObjectPtr obj, JFieldIDPtr fieldID) =>
      _GetLongField(ptr, obj, fieldID);

  late final _GetFloatField = ptr.value.ref.GetFloatField.asFunction<
      double Function(
          ffi.Pointer<JniEnv1> env, JObjectPtr obj, JFieldIDPtr fieldID)>();
  double GetFloatField(JObjectPtr obj, JFieldIDPtr fieldID) =>
      _GetFloatField(ptr, obj, fieldID);

  late final _GetDoubleField = ptr.value.ref.GetDoubleField.asFunction<
      double Function(
          ffi.Pointer<JniEnv1> env, JObjectPtr obj, JFieldIDPtr fieldID)>();
  double GetDoubleField(JObjectPtr obj, JFieldIDPtr fieldID) =>
      _GetDoubleField(ptr, obj, fieldID);

  late final _SetObjectField = ptr.value.ref.SetObjectField.asFunction<
      void Function(ffi.Pointer<JniEnv1> env, JObjectPtr obj,
          JFieldIDPtr fieldID, JObjectPtr val)>();
  void SetObjectField(JObjectPtr obj, JFieldIDPtr fieldID, JObjectPtr val) =>
      _SetObjectField(ptr, obj, fieldID, val);

  late final _SetBooleanField = ptr.value.ref.SetBooleanField.asFunction<
      void Function(ffi.Pointer<JniEnv1> env, JObjectPtr obj,
          JFieldIDPtr fieldID, int val)>();
  void SetBooleanField(JObjectPtr obj, JFieldIDPtr fieldID, int val) =>
      _SetBooleanField(ptr, obj, fieldID, val);

  late final _SetByteField = ptr.value.ref.SetByteField.asFunction<
      void Function(ffi.Pointer<JniEnv1> env, JObjectPtr obj,
          JFieldIDPtr fieldID, int val)>();
  void SetByteField(JObjectPtr obj, JFieldIDPtr fieldID, int val) =>
      _SetByteField(ptr, obj, fieldID, val);

  late final _SetCharField = ptr.value.ref.SetCharField.asFunction<
      void Function(ffi.Pointer<JniEnv1> env, JObjectPtr obj,
          JFieldIDPtr fieldID, int val)>();
  void SetCharField(JObjectPtr obj, JFieldIDPtr fieldID, int val) =>
      _SetCharField(ptr, obj, fieldID, val);

  late final _SetShortField = ptr.value.ref.SetShortField.asFunction<
      void Function(ffi.Pointer<JniEnv1> env, JObjectPtr obj,
          JFieldIDPtr fieldID, int val)>();
  void SetShortField(JObjectPtr obj, JFieldIDPtr fieldID, int val) =>
      _SetShortField(ptr, obj, fieldID, val);

  late final _SetIntField = ptr.value.ref.SetIntField.asFunction<
      void Function(ffi.Pointer<JniEnv1> env, JObjectPtr obj,
          JFieldIDPtr fieldID, int val)>();
  void SetIntField(JObjectPtr obj, JFieldIDPtr fieldID, int val) =>
      _SetIntField(ptr, obj, fieldID, val);

  late final _SetLongField = ptr.value.ref.SetLongField.asFunction<
      void Function(ffi.Pointer<JniEnv1> env, JObjectPtr obj,
          JFieldIDPtr fieldID, int val)>();
  void SetLongField(JObjectPtr obj, JFieldIDPtr fieldID, int val) =>
      _SetLongField(ptr, obj, fieldID, val);

  late final _SetFloatField = ptr.value.ref.SetFloatField.asFunction<
      void Function(ffi.Pointer<JniEnv1> env, JObjectPtr obj,
          JFieldIDPtr fieldID, double val)>();
  void SetFloatField(JObjectPtr obj, JFieldIDPtr fieldID, double val) =>
      _SetFloatField(ptr, obj, fieldID, val);

  late final _SetDoubleField = ptr.value.ref.SetDoubleField.asFunction<
      void Function(ffi.Pointer<JniEnv1> env, JObjectPtr obj,
          JFieldIDPtr fieldID, double val)>();
  void SetDoubleField(JObjectPtr obj, JFieldIDPtr fieldID, double val) =>
      _SetDoubleField(ptr, obj, fieldID, val);

  late final _GetStaticMethodID = ptr.value.ref.GetStaticMethodID.asFunction<
      JMethodIDPtr Function(ffi.Pointer<JniEnv1> env, JClassPtr clazz,
          ffi.Pointer<ffi.Char> name, ffi.Pointer<ffi.Char> sig)>();
  JMethodIDPtr GetStaticMethodID(JClassPtr clazz, ffi.Pointer<ffi.Char> name,
          ffi.Pointer<ffi.Char> sig) =>
      _GetStaticMethodID(ptr, clazz, name, sig);

  late final _CallStaticObjectMethod = ptr.value.ref.CallStaticObjectMethod
      .asFunction<
          JObjectPtr Function(ffi.Pointer<JniEnv1> env, JClassPtr clazz,
              JMethodIDPtr methodID)>();
  JObjectPtr CallStaticObjectMethod(JClassPtr clazz, JMethodIDPtr methodID) =>
      _CallStaticObjectMethod(ptr, clazz, methodID);

  late final _CallStaticObjectMethodA = ptr.value.ref.CallStaticObjectMethodA
      .asFunction<
          JObjectPtr Function(ffi.Pointer<JniEnv1> env, JClassPtr clazz,
              JMethodIDPtr methodID, ffi.Pointer<JValue> args)>();
  JObjectPtr CallStaticObjectMethodA(
          JClassPtr clazz, JMethodIDPtr methodID, ffi.Pointer<JValue> args) =>
      _CallStaticObjectMethodA(ptr, clazz, methodID, args);

  late final _CallStaticBooleanMethod = ptr.value.ref.CallStaticBooleanMethod
      .asFunction<
          int Function(ffi.Pointer<JniEnv1> env, JClassPtr clazz,
              JMethodIDPtr methodID)>();
  int CallStaticBooleanMethod(JClassPtr clazz, JMethodIDPtr methodID) =>
      _CallStaticBooleanMethod(ptr, clazz, methodID);

  late final _CallStaticBooleanMethodA = ptr.value.ref.CallStaticBooleanMethodA
      .asFunction<
          int Function(ffi.Pointer<JniEnv1> env, JClassPtr clazz,
              JMethodIDPtr methodID, ffi.Pointer<JValue> args)>();
  int CallStaticBooleanMethodA(
          JClassPtr clazz, JMethodIDPtr methodID, ffi.Pointer<JValue> args) =>
      _CallStaticBooleanMethodA(ptr, clazz, methodID, args);

  late final _CallStaticByteMethod = ptr.value.ref.CallStaticByteMethod
      .asFunction<
          int Function(ffi.Pointer<JniEnv1> env, JClassPtr clazz,
              JMethodIDPtr methodID)>();
  int CallStaticByteMethod(JClassPtr clazz, JMethodIDPtr methodID) =>
      _CallStaticByteMethod(ptr, clazz, methodID);

  late final _CallStaticByteMethodA = ptr.value.ref.CallStaticByteMethodA
      .asFunction<
          int Function(ffi.Pointer<JniEnv1> env, JClassPtr clazz,
              JMethodIDPtr methodID, ffi.Pointer<JValue> args)>();
  int CallStaticByteMethodA(
          JClassPtr clazz, JMethodIDPtr methodID, ffi.Pointer<JValue> args) =>
      _CallStaticByteMethodA(ptr, clazz, methodID, args);

  late final _CallStaticCharMethod = ptr.value.ref.CallStaticCharMethod
      .asFunction<
          int Function(ffi.Pointer<JniEnv1> env, JClassPtr clazz,
              JMethodIDPtr methodID)>();
  int CallStaticCharMethod(JClassPtr clazz, JMethodIDPtr methodID) =>
      _CallStaticCharMethod(ptr, clazz, methodID);

  late final _CallStaticCharMethodA = ptr.value.ref.CallStaticCharMethodA
      .asFunction<
          int Function(ffi.Pointer<JniEnv1> env, JClassPtr clazz,
              JMethodIDPtr methodID, ffi.Pointer<JValue> args)>();
  int CallStaticCharMethodA(
          JClassPtr clazz, JMethodIDPtr methodID, ffi.Pointer<JValue> args) =>
      _CallStaticCharMethodA(ptr, clazz, methodID, args);

  late final _CallStaticShortMethod = ptr.value.ref.CallStaticShortMethod
      .asFunction<
          int Function(ffi.Pointer<JniEnv1> env, JClassPtr clazz,
              JMethodIDPtr methodID)>();
  int CallStaticShortMethod(JClassPtr clazz, JMethodIDPtr methodID) =>
      _CallStaticShortMethod(ptr, clazz, methodID);

  late final _CallStaticShortMethodA = ptr.value.ref.CallStaticShortMethodA
      .asFunction<
          int Function(ffi.Pointer<JniEnv1> env, JClassPtr clazz,
              JMethodIDPtr methodID, ffi.Pointer<JValue> args)>();
  int CallStaticShortMethodA(
          JClassPtr clazz, JMethodIDPtr methodID, ffi.Pointer<JValue> args) =>
      _CallStaticShortMethodA(ptr, clazz, methodID, args);

  late final _CallStaticIntMethod = ptr.value.ref.CallStaticIntMethod
      .asFunction<
          int Function(ffi.Pointer<JniEnv1> env, JClassPtr clazz,
              JMethodIDPtr methodID)>();
  int CallStaticIntMethod(JClassPtr clazz, JMethodIDPtr methodID) =>
      _CallStaticIntMethod(ptr, clazz, methodID);

  late final _CallStaticIntMethodA = ptr.value.ref.CallStaticIntMethodA
      .asFunction<
          int Function(ffi.Pointer<JniEnv1> env, JClassPtr clazz,
              JMethodIDPtr methodID, ffi.Pointer<JValue> args)>();
  int CallStaticIntMethodA(
          JClassPtr clazz, JMethodIDPtr methodID, ffi.Pointer<JValue> args) =>
      _CallStaticIntMethodA(ptr, clazz, methodID, args);

  late final _CallStaticLongMethod = ptr.value.ref.CallStaticLongMethod
      .asFunction<
          int Function(ffi.Pointer<JniEnv1> env, JClassPtr clazz,
              JMethodIDPtr methodID)>();
  int CallStaticLongMethod(JClassPtr clazz, JMethodIDPtr methodID) =>
      _CallStaticLongMethod(ptr, clazz, methodID);

  late final _CallStaticLongMethodA = ptr.value.ref.CallStaticLongMethodA
      .asFunction<
          int Function(ffi.Pointer<JniEnv1> env, JClassPtr clazz,
              JMethodIDPtr methodID, ffi.Pointer<JValue> args)>();
  int CallStaticLongMethodA(
          JClassPtr clazz, JMethodIDPtr methodID, ffi.Pointer<JValue> args) =>
      _CallStaticLongMethodA(ptr, clazz, methodID, args);

  late final _CallStaticFloatMethod = ptr.value.ref.CallStaticFloatMethod
      .asFunction<
          double Function(ffi.Pointer<JniEnv1> env, JClassPtr clazz,
              JMethodIDPtr methodID)>();
  double CallStaticFloatMethod(JClassPtr clazz, JMethodIDPtr methodID) =>
      _CallStaticFloatMethod(ptr, clazz, methodID);

  late final _CallStaticFloatMethodA = ptr.value.ref.CallStaticFloatMethodA
      .asFunction<
          double Function(ffi.Pointer<JniEnv1> env, JClassPtr clazz,
              JMethodIDPtr methodID, ffi.Pointer<JValue> args)>();
  double CallStaticFloatMethodA(
          JClassPtr clazz, JMethodIDPtr methodID, ffi.Pointer<JValue> args) =>
      _CallStaticFloatMethodA(ptr, clazz, methodID, args);

  late final _CallStaticDoubleMethod = ptr.value.ref.CallStaticDoubleMethod
      .asFunction<
          double Function(ffi.Pointer<JniEnv1> env, JClassPtr clazz,
              JMethodIDPtr methodID)>();
  double CallStaticDoubleMethod(JClassPtr clazz, JMethodIDPtr methodID) =>
      _CallStaticDoubleMethod(ptr, clazz, methodID);

  late final _CallStaticDoubleMethodA = ptr.value.ref.CallStaticDoubleMethodA
      .asFunction<
          double Function(ffi.Pointer<JniEnv1> env, JClassPtr clazz,
              JMethodIDPtr methodID, ffi.Pointer<JValue> args)>();
  double CallStaticDoubleMethodA(
          JClassPtr clazz, JMethodIDPtr methodID, ffi.Pointer<JValue> args) =>
      _CallStaticDoubleMethodA(ptr, clazz, methodID, args);

  late final _CallStaticVoidMethod = ptr.value.ref.CallStaticVoidMethod
      .asFunction<
          void Function(ffi.Pointer<JniEnv1> env, JClassPtr clazz,
              JMethodIDPtr methodID)>();
  void CallStaticVoidMethod(JClassPtr clazz, JMethodIDPtr methodID) =>
      _CallStaticVoidMethod(ptr, clazz, methodID);

  late final _CallStaticVoidMethodA = ptr.value.ref.CallStaticVoidMethodA
      .asFunction<
          void Function(ffi.Pointer<JniEnv1> env, JClassPtr clazz,
              JMethodIDPtr methodID, ffi.Pointer<JValue> args)>();
  void CallStaticVoidMethodA(
          JClassPtr clazz, JMethodIDPtr methodID, ffi.Pointer<JValue> args) =>
      _CallStaticVoidMethodA(ptr, clazz, methodID, args);

  late final _GetStaticFieldID = ptr.value.ref.GetStaticFieldID.asFunction<
      JFieldIDPtr Function(ffi.Pointer<JniEnv1> env, JClassPtr clazz,
          ffi.Pointer<ffi.Char> name, ffi.Pointer<ffi.Char> sig)>();
  JFieldIDPtr GetStaticFieldID(JClassPtr clazz, ffi.Pointer<ffi.Char> name,
          ffi.Pointer<ffi.Char> sig) =>
      _GetStaticFieldID(ptr, clazz, name, sig);

  late final _GetStaticObjectField = ptr.value.ref.GetStaticObjectField
      .asFunction<
          JObjectPtr Function(ffi.Pointer<JniEnv1> env, JClassPtr clazz,
              JFieldIDPtr fieldID)>();
  JObjectPtr GetStaticObjectField(JClassPtr clazz, JFieldIDPtr fieldID) =>
      _GetStaticObjectField(ptr, clazz, fieldID);

  late final _GetStaticBooleanField = ptr.value.ref.GetStaticBooleanField
      .asFunction<
          int Function(ffi.Pointer<JniEnv1> env, JClassPtr clazz,
              JFieldIDPtr fieldID)>();
  int GetStaticBooleanField(JClassPtr clazz, JFieldIDPtr fieldID) =>
      _GetStaticBooleanField(ptr, clazz, fieldID);

  late final _GetStaticByteField = ptr.value.ref.GetStaticByteField.asFunction<
      int Function(
          ffi.Pointer<JniEnv1> env, JClassPtr clazz, JFieldIDPtr fieldID)>();
  int GetStaticByteField(JClassPtr clazz, JFieldIDPtr fieldID) =>
      _GetStaticByteField(ptr, clazz, fieldID);

  late final _GetStaticCharField = ptr.value.ref.GetStaticCharField.asFunction<
      int Function(
          ffi.Pointer<JniEnv1> env, JClassPtr clazz, JFieldIDPtr fieldID)>();
  int GetStaticCharField(JClassPtr clazz, JFieldIDPtr fieldID) =>
      _GetStaticCharField(ptr, clazz, fieldID);

  late final _GetStaticShortField = ptr.value.ref.GetStaticShortField
      .asFunction<
          int Function(ffi.Pointer<JniEnv1> env, JClassPtr clazz,
              JFieldIDPtr fieldID)>();
  int GetStaticShortField(JClassPtr clazz, JFieldIDPtr fieldID) =>
      _GetStaticShortField(ptr, clazz, fieldID);

  late final _GetStaticIntField = ptr.value.ref.GetStaticIntField.asFunction<
      int Function(
          ffi.Pointer<JniEnv1> env, JClassPtr clazz, JFieldIDPtr fieldID)>();
  int GetStaticIntField(JClassPtr clazz, JFieldIDPtr fieldID) =>
      _GetStaticIntField(ptr, clazz, fieldID);

  late final _GetStaticLongField = ptr.value.ref.GetStaticLongField.asFunction<
      int Function(
          ffi.Pointer<JniEnv1> env, JClassPtr clazz, JFieldIDPtr fieldID)>();
  int GetStaticLongField(JClassPtr clazz, JFieldIDPtr fieldID) =>
      _GetStaticLongField(ptr, clazz, fieldID);

  late final _GetStaticFloatField = ptr.value.ref.GetStaticFloatField
      .asFunction<
          double Function(ffi.Pointer<JniEnv1> env, JClassPtr clazz,
              JFieldIDPtr fieldID)>();
  double GetStaticFloatField(JClassPtr clazz, JFieldIDPtr fieldID) =>
      _GetStaticFloatField(ptr, clazz, fieldID);

  late final _GetStaticDoubleField = ptr.value.ref.GetStaticDoubleField
      .asFunction<
          double Function(ffi.Pointer<JniEnv1> env, JClassPtr clazz,
              JFieldIDPtr fieldID)>();
  double GetStaticDoubleField(JClassPtr clazz, JFieldIDPtr fieldID) =>
      _GetStaticDoubleField(ptr, clazz, fieldID);

  late final _SetStaticObjectField = ptr.value.ref.SetStaticObjectField
      .asFunction<
          void Function(ffi.Pointer<JniEnv1> env, JClassPtr clazz,
              JFieldIDPtr fieldID, JObjectPtr val)>();
  void SetStaticObjectField(
          JClassPtr clazz, JFieldIDPtr fieldID, JObjectPtr val) =>
      _SetStaticObjectField(ptr, clazz, fieldID, val);

  late final _SetStaticBooleanField = ptr.value.ref.SetStaticBooleanField
      .asFunction<
          void Function(ffi.Pointer<JniEnv1> env, JClassPtr clazz,
              JFieldIDPtr fieldID, int val)>();
  void SetStaticBooleanField(JClassPtr clazz, JFieldIDPtr fieldID, int val) =>
      _SetStaticBooleanField(ptr, clazz, fieldID, val);

  late final _SetStaticByteField = ptr.value.ref.SetStaticByteField.asFunction<
      void Function(ffi.Pointer<JniEnv1> env, JClassPtr clazz,
          JFieldIDPtr fieldID, int val)>();
  void SetStaticByteField(JClassPtr clazz, JFieldIDPtr fieldID, int val) =>
      _SetStaticByteField(ptr, clazz, fieldID, val);

  late final _SetStaticCharField = ptr.value.ref.SetStaticCharField.asFunction<
      void Function(ffi.Pointer<JniEnv1> env, JClassPtr clazz,
          JFieldIDPtr fieldID, int val)>();
  void SetStaticCharField(JClassPtr clazz, JFieldIDPtr fieldID, int val) =>
      _SetStaticCharField(ptr, clazz, fieldID, val);

  late final _SetStaticShortField = ptr.value.ref.SetStaticShortField
      .asFunction<
          void Function(ffi.Pointer<JniEnv1> env, JClassPtr clazz,
              JFieldIDPtr fieldID, int val)>();
  void SetStaticShortField(JClassPtr clazz, JFieldIDPtr fieldID, int val) =>
      _SetStaticShortField(ptr, clazz, fieldID, val);

  late final _SetStaticIntField = ptr.value.ref.SetStaticIntField.asFunction<
      void Function(ffi.Pointer<JniEnv1> env, JClassPtr clazz,
          JFieldIDPtr fieldID, int val)>();
  void SetStaticIntField(JClassPtr clazz, JFieldIDPtr fieldID, int val) =>
      _SetStaticIntField(ptr, clazz, fieldID, val);

  late final _SetStaticLongField = ptr.value.ref.SetStaticLongField.asFunction<
      void Function(ffi.Pointer<JniEnv1> env, JClassPtr clazz,
          JFieldIDPtr fieldID, int val)>();
  void SetStaticLongField(JClassPtr clazz, JFieldIDPtr fieldID, int val) =>
      _SetStaticLongField(ptr, clazz, fieldID, val);

  late final _SetStaticFloatField = ptr.value.ref.SetStaticFloatField
      .asFunction<
          void Function(ffi.Pointer<JniEnv1> env, JClassPtr clazz,
              JFieldIDPtr fieldID, double val)>();
  void SetStaticFloatField(JClassPtr clazz, JFieldIDPtr fieldID, double val) =>
      _SetStaticFloatField(ptr, clazz, fieldID, val);

  late final _SetStaticDoubleField = ptr.value.ref.SetStaticDoubleField
      .asFunction<
          void Function(ffi.Pointer<JniEnv1> env, JClassPtr clazz,
              JFieldIDPtr fieldID, double val)>();
  void SetStaticDoubleField(JClassPtr clazz, JFieldIDPtr fieldID, double val) =>
      _SetStaticDoubleField(ptr, clazz, fieldID, val);

  late final _NewString = ptr.value.ref.NewString.asFunction<
      JStringPtr Function(ffi.Pointer<JniEnv1> env,
          ffi.Pointer<JCharMarker> unicodeChars, int len)>();
  JStringPtr NewString(ffi.Pointer<JCharMarker> unicodeChars, int len) =>
      _NewString(ptr, unicodeChars, len);

  late final _GetStringLength = ptr.value.ref.GetStringLength
      .asFunction<int Function(ffi.Pointer<JniEnv1> env, JStringPtr string)>();
  int GetStringLength(JStringPtr string) => _GetStringLength(ptr, string);

  late final _GetStringChars = ptr.value.ref.GetStringChars.asFunction<
      ffi.Pointer<JCharMarker> Function(ffi.Pointer<JniEnv1> env,
          JStringPtr string, ffi.Pointer<JBooleanMarker> isCopy)>();
  ffi.Pointer<JCharMarker> GetStringChars(
          JStringPtr string, ffi.Pointer<JBooleanMarker> isCopy) =>
      _GetStringChars(ptr, string, isCopy);

  late final _ReleaseStringChars = ptr.value.ref.ReleaseStringChars.asFunction<
      void Function(ffi.Pointer<JniEnv1> env, JStringPtr string,
          ffi.Pointer<JCharMarker> isCopy)>();
  void ReleaseStringChars(JStringPtr string, ffi.Pointer<JCharMarker> isCopy) =>
      _ReleaseStringChars(ptr, string, isCopy);

  late final _NewStringUTF = ptr.value.ref.NewStringUTF.asFunction<
      JStringPtr Function(
          ffi.Pointer<JniEnv1> env, ffi.Pointer<ffi.Char> bytes)>();
  JStringPtr NewStringUTF(ffi.Pointer<ffi.Char> bytes) =>
      _NewStringUTF(ptr, bytes);

  late final _GetStringUTFLength = ptr.value.ref.GetStringUTFLength
      .asFunction<int Function(ffi.Pointer<JniEnv1> env, JStringPtr string)>();
  int GetStringUTFLength(JStringPtr string) => _GetStringUTFLength(ptr, string);

  late final _GetStringUTFChars = ptr.value.ref.GetStringUTFChars.asFunction<
      ffi.Pointer<ffi.Char> Function(ffi.Pointer<JniEnv1> env,
          JStringPtr string, ffi.Pointer<JBooleanMarker> isCopy)>();
  ffi.Pointer<ffi.Char> GetStringUTFChars(
          JStringPtr string, ffi.Pointer<JBooleanMarker> isCopy) =>
      _GetStringUTFChars(ptr, string, isCopy);

  late final _ReleaseStringUTFChars = ptr.value.ref.ReleaseStringUTFChars
      .asFunction<
          void Function(ffi.Pointer<JniEnv1> env, JStringPtr string,
              ffi.Pointer<ffi.Char> utf)>();
  void ReleaseStringUTFChars(JStringPtr string, ffi.Pointer<ffi.Char> utf) =>
      _ReleaseStringUTFChars(ptr, string, utf);

  late final _GetArrayLength = ptr.value.ref.GetArrayLength
      .asFunction<int Function(ffi.Pointer<JniEnv1> env, JArrayPtr array)>();
  int GetArrayLength(JArrayPtr array) => _GetArrayLength(ptr, array);

  late final _NewObjectArray = ptr.value.ref.NewObjectArray.asFunction<
      JObjectArrayPtr Function(ffi.Pointer<JniEnv1> env, int length,
          JClassPtr elementClass, JObjectPtr initialElement)>();
  JObjectArrayPtr NewObjectArray(
          int length, JClassPtr elementClass, JObjectPtr initialElement) =>
      _NewObjectArray(ptr, length, elementClass, initialElement);

  late final _GetObjectArrayElement = ptr.value.ref.GetObjectArrayElement
      .asFunction<
          JObjectPtr Function(
              ffi.Pointer<JniEnv1> env, JObjectArrayPtr array, int index)>();
  JObjectPtr GetObjectArrayElement(JObjectArrayPtr array, int index) =>
      _GetObjectArrayElement(ptr, array, index);

  late final _SetObjectArrayElement = ptr.value.ref.SetObjectArrayElement
      .asFunction<
          void Function(ffi.Pointer<JniEnv1> env, JObjectArrayPtr array,
              int index, JObjectPtr val)>();
  void SetObjectArrayElement(
          JObjectArrayPtr array, int index, JObjectPtr val) =>
      _SetObjectArrayElement(ptr, array, index, val);

  late final _NewBooleanArray = ptr.value.ref.NewBooleanArray.asFunction<
      JBooleanArrayPtr Function(ffi.Pointer<JniEnv1> env, int length)>();
  JBooleanArrayPtr NewBooleanArray(int length) => _NewBooleanArray(ptr, length);

  late final _NewByteArray = ptr.value.ref.NewByteArray.asFunction<
      JByteArrayPtr Function(ffi.Pointer<JniEnv1> env, int length)>();
  JByteArrayPtr NewByteArray(int length) => _NewByteArray(ptr, length);

  late final _NewCharArray = ptr.value.ref.NewCharArray.asFunction<
      JCharArrayPtr Function(ffi.Pointer<JniEnv1> env, int length)>();
  JCharArrayPtr NewCharArray(int length) => _NewCharArray(ptr, length);

  late final _NewShortArray = ptr.value.ref.NewShortArray.asFunction<
      JShortArrayPtr Function(ffi.Pointer<JniEnv1> env, int length)>();
  JShortArrayPtr NewShortArray(int length) => _NewShortArray(ptr, length);

  late final _NewIntArray = ptr.value.ref.NewIntArray.asFunction<
      JIntArrayPtr Function(ffi.Pointer<JniEnv1> env, int length)>();
  JIntArrayPtr NewIntArray(int length) => _NewIntArray(ptr, length);

  late final _NewLongArray = ptr.value.ref.NewLongArray.asFunction<
      JLongArrayPtr Function(ffi.Pointer<JniEnv1> env, int length)>();
  JLongArrayPtr NewLongArray(int length) => _NewLongArray(ptr, length);

  late final _NewFloatArray = ptr.value.ref.NewFloatArray.asFunction<
      JFloatArrayPtr Function(ffi.Pointer<JniEnv1> env, int length)>();
  JFloatArrayPtr NewFloatArray(int length) => _NewFloatArray(ptr, length);

  late final _NewDoubleArray = ptr.value.ref.NewDoubleArray.asFunction<
      JDoubleArrayPtr Function(ffi.Pointer<JniEnv1> env, int length)>();
  JDoubleArrayPtr NewDoubleArray(int length) => _NewDoubleArray(ptr, length);

  late final _GetBooleanArrayElements = ptr.value.ref.GetBooleanArrayElements
      .asFunction<
          ffi.Pointer<JBooleanMarker> Function(ffi.Pointer<JniEnv1> env,
              JBooleanArrayPtr array, ffi.Pointer<JBooleanMarker> isCopy)>();
  ffi.Pointer<JBooleanMarker> GetBooleanArrayElements(
          JBooleanArrayPtr array, ffi.Pointer<JBooleanMarker> isCopy) =>
      _GetBooleanArrayElements(ptr, array, isCopy);

  late final _GetByteArrayElements = ptr.value.ref.GetByteArrayElements
      .asFunction<
          ffi.Pointer<JByteMarker> Function(ffi.Pointer<JniEnv1> env,
              JByteArrayPtr array, ffi.Pointer<JBooleanMarker> isCopy)>();
  ffi.Pointer<JByteMarker> GetByteArrayElements(
          JByteArrayPtr array, ffi.Pointer<JBooleanMarker> isCopy) =>
      _GetByteArrayElements(ptr, array, isCopy);

  late final _GetCharArrayElements = ptr.value.ref.GetCharArrayElements
      .asFunction<
          ffi.Pointer<JCharMarker> Function(ffi.Pointer<JniEnv1> env,
              JCharArrayPtr array, ffi.Pointer<JBooleanMarker> isCopy)>();
  ffi.Pointer<JCharMarker> GetCharArrayElements(
          JCharArrayPtr array, ffi.Pointer<JBooleanMarker> isCopy) =>
      _GetCharArrayElements(ptr, array, isCopy);

  late final _GetShortArrayElements = ptr.value.ref.GetShortArrayElements
      .asFunction<
          ffi.Pointer<JShortMarker> Function(ffi.Pointer<JniEnv1> env,
              JShortArrayPtr array, ffi.Pointer<JBooleanMarker> isCopy)>();
  ffi.Pointer<JShortMarker> GetShortArrayElements(
          JShortArrayPtr array, ffi.Pointer<JBooleanMarker> isCopy) =>
      _GetShortArrayElements(ptr, array, isCopy);

  late final _GetIntArrayElements = ptr.value.ref.GetIntArrayElements
      .asFunction<
          ffi.Pointer<JIntMarker> Function(ffi.Pointer<JniEnv1> env,
              JIntArrayPtr array, ffi.Pointer<JBooleanMarker> isCopy)>();
  ffi.Pointer<JIntMarker> GetIntArrayElements(
          JIntArrayPtr array, ffi.Pointer<JBooleanMarker> isCopy) =>
      _GetIntArrayElements(ptr, array, isCopy);

  late final _GetLongArrayElements = ptr.value.ref.GetLongArrayElements
      .asFunction<
          ffi.Pointer<JLongMarker> Function(ffi.Pointer<JniEnv1> env,
              JLongArrayPtr array, ffi.Pointer<JBooleanMarker> isCopy)>();
  ffi.Pointer<JLongMarker> GetLongArrayElements(
          JLongArrayPtr array, ffi.Pointer<JBooleanMarker> isCopy) =>
      _GetLongArrayElements(ptr, array, isCopy);

  late final _GetFloatArrayElements = ptr.value.ref.GetFloatArrayElements
      .asFunction<
          ffi.Pointer<JFloatMarker> Function(ffi.Pointer<JniEnv1> env,
              JFloatArrayPtr array, ffi.Pointer<JBooleanMarker> isCopy)>();
  ffi.Pointer<JFloatMarker> GetFloatArrayElements(
          JFloatArrayPtr array, ffi.Pointer<JBooleanMarker> isCopy) =>
      _GetFloatArrayElements(ptr, array, isCopy);

  late final _GetDoubleArrayElements = ptr.value.ref.GetDoubleArrayElements
      .asFunction<
          ffi.Pointer<JDoubleMarker> Function(ffi.Pointer<JniEnv1> env,
              JDoubleArrayPtr array, ffi.Pointer<JBooleanMarker> isCopy)>();
  ffi.Pointer<JDoubleMarker> GetDoubleArrayElements(
          JDoubleArrayPtr array, ffi.Pointer<JBooleanMarker> isCopy) =>
      _GetDoubleArrayElements(ptr, array, isCopy);

  late final _ReleaseBooleanArrayElements =
      ptr.value.ref.ReleaseBooleanArrayElements.asFunction<
          void Function(ffi.Pointer<JniEnv1> env, JBooleanArrayPtr array,
              ffi.Pointer<JBooleanMarker> elems, int mode)>();
  void ReleaseBooleanArrayElements(JBooleanArrayPtr array,
          ffi.Pointer<JBooleanMarker> elems, int mode) =>
      _ReleaseBooleanArrayElements(ptr, array, elems, mode);

  late final _ReleaseByteArrayElements = ptr.value.ref.ReleaseByteArrayElements
      .asFunction<
          void Function(ffi.Pointer<JniEnv1> env, JByteArrayPtr array,
              ffi.Pointer<JByteMarker> elems, int mode)>();
  void ReleaseByteArrayElements(
          JByteArrayPtr array, ffi.Pointer<JByteMarker> elems, int mode) =>
      _ReleaseByteArrayElements(ptr, array, elems, mode);

  late final _ReleaseCharArrayElements = ptr.value.ref.ReleaseCharArrayElements
      .asFunction<
          void Function(ffi.Pointer<JniEnv1> env, JCharArrayPtr array,
              ffi.Pointer<JCharMarker> elems, int mode)>();
  void ReleaseCharArrayElements(
          JCharArrayPtr array, ffi.Pointer<JCharMarker> elems, int mode) =>
      _ReleaseCharArrayElements(ptr, array, elems, mode);

  late final _ReleaseShortArrayElements =
      ptr.value.ref.ReleaseShortArrayElements.asFunction<
          void Function(ffi.Pointer<JniEnv1> env, JShortArrayPtr array,
              ffi.Pointer<JShortMarker> elems, int mode)>();
  void ReleaseShortArrayElements(
          JShortArrayPtr array, ffi.Pointer<JShortMarker> elems, int mode) =>
      _ReleaseShortArrayElements(ptr, array, elems, mode);

  late final _ReleaseIntArrayElements = ptr.value.ref.ReleaseIntArrayElements
      .asFunction<
          void Function(ffi.Pointer<JniEnv1> env, JIntArrayPtr array,
              ffi.Pointer<JIntMarker> elems, int mode)>();
  void ReleaseIntArrayElements(
          JIntArrayPtr array, ffi.Pointer<JIntMarker> elems, int mode) =>
      _ReleaseIntArrayElements(ptr, array, elems, mode);

  late final _ReleaseLongArrayElements = ptr.value.ref.ReleaseLongArrayElements
      .asFunction<
          void Function(ffi.Pointer<JniEnv1> env, JLongArrayPtr array,
              ffi.Pointer<JLongMarker> elems, int mode)>();
  void ReleaseLongArrayElements(
          JLongArrayPtr array, ffi.Pointer<JLongMarker> elems, int mode) =>
      _ReleaseLongArrayElements(ptr, array, elems, mode);

  late final _ReleaseFloatArrayElements =
      ptr.value.ref.ReleaseFloatArrayElements.asFunction<
          void Function(ffi.Pointer<JniEnv1> env, JFloatArrayPtr array,
              ffi.Pointer<JFloatMarker> elems, int mode)>();
  void ReleaseFloatArrayElements(
          JFloatArrayPtr array, ffi.Pointer<JFloatMarker> elems, int mode) =>
      _ReleaseFloatArrayElements(ptr, array, elems, mode);

  late final _ReleaseDoubleArrayElements =
      ptr.value.ref.ReleaseDoubleArrayElements.asFunction<
          void Function(ffi.Pointer<JniEnv1> env, JDoubleArrayPtr array,
              ffi.Pointer<JDoubleMarker> elems, int mode)>();
  void ReleaseDoubleArrayElements(
          JDoubleArrayPtr array, ffi.Pointer<JDoubleMarker> elems, int mode) =>
      _ReleaseDoubleArrayElements(ptr, array, elems, mode);

  late final _GetBooleanArrayRegion = ptr.value.ref.GetBooleanArrayRegion
      .asFunction<
          void Function(ffi.Pointer<JniEnv1> env, JBooleanArrayPtr array,
              int start, int len, ffi.Pointer<JBooleanMarker> buf)>();
  void GetBooleanArrayRegion(JBooleanArrayPtr array, int start, int len,
          ffi.Pointer<JBooleanMarker> buf) =>
      _GetBooleanArrayRegion(ptr, array, start, len, buf);

  late final _GetByteArrayRegion = ptr.value.ref.GetByteArrayRegion.asFunction<
      void Function(ffi.Pointer<JniEnv1> env, JByteArrayPtr array, int start,
          int len, ffi.Pointer<JByteMarker> buf)>();
  void GetByteArrayRegion(JByteArrayPtr array, int start, int len,
          ffi.Pointer<JByteMarker> buf) =>
      _GetByteArrayRegion(ptr, array, start, len, buf);

  late final _GetCharArrayRegion = ptr.value.ref.GetCharArrayRegion.asFunction<
      void Function(ffi.Pointer<JniEnv1> env, JCharArrayPtr array, int start,
          int len, ffi.Pointer<JCharMarker> buf)>();
  void GetCharArrayRegion(JCharArrayPtr array, int start, int len,
          ffi.Pointer<JCharMarker> buf) =>
      _GetCharArrayRegion(ptr, array, start, len, buf);

  late final _GetShortArrayRegion = ptr.value.ref.GetShortArrayRegion
      .asFunction<
          void Function(ffi.Pointer<JniEnv1> env, JShortArrayPtr array,
              int start, int len, ffi.Pointer<JShortMarker> buf)>();
  void GetShortArrayRegion(JShortArrayPtr array, int start, int len,
          ffi.Pointer<JShortMarker> buf) =>
      _GetShortArrayRegion(ptr, array, start, len, buf);

  late final _GetIntArrayRegion = ptr.value.ref.GetIntArrayRegion.asFunction<
      void Function(ffi.Pointer<JniEnv1> env, JIntArrayPtr array, int start,
          int len, ffi.Pointer<JIntMarker> buf)>();
  void GetIntArrayRegion(JIntArrayPtr array, int start, int len,
          ffi.Pointer<JIntMarker> buf) =>
      _GetIntArrayRegion(ptr, array, start, len, buf);

  late final _GetLongArrayRegion = ptr.value.ref.GetLongArrayRegion.asFunction<
      void Function(ffi.Pointer<JniEnv1> env, JLongArrayPtr array, int start,
          int len, ffi.Pointer<JLongMarker> buf)>();
  void GetLongArrayRegion(JLongArrayPtr array, int start, int len,
          ffi.Pointer<JLongMarker> buf) =>
      _GetLongArrayRegion(ptr, array, start, len, buf);

  late final _GetFloatArrayRegion = ptr.value.ref.GetFloatArrayRegion
      .asFunction<
          void Function(ffi.Pointer<JniEnv1> env, JFloatArrayPtr array,
              int start, int len, ffi.Pointer<JFloatMarker> buf)>();
  void GetFloatArrayRegion(JFloatArrayPtr array, int start, int len,
          ffi.Pointer<JFloatMarker> buf) =>
      _GetFloatArrayRegion(ptr, array, start, len, buf);

  late final _GetDoubleArrayRegion = ptr.value.ref.GetDoubleArrayRegion
      .asFunction<
          void Function(ffi.Pointer<JniEnv1> env, JDoubleArrayPtr array,
              int start, int len, ffi.Pointer<JDoubleMarker> buf)>();
  void GetDoubleArrayRegion(JDoubleArrayPtr array, int start, int len,
          ffi.Pointer<JDoubleMarker> buf) =>
      _GetDoubleArrayRegion(ptr, array, start, len, buf);

  late final _SetBooleanArrayRegion = ptr.value.ref.SetBooleanArrayRegion
      .asFunction<
          void Function(ffi.Pointer<JniEnv1> env, JBooleanArrayPtr array,
              int start, int len, ffi.Pointer<JBooleanMarker> buf)>();
  void SetBooleanArrayRegion(JBooleanArrayPtr array, int start, int len,
          ffi.Pointer<JBooleanMarker> buf) =>
      _SetBooleanArrayRegion(ptr, array, start, len, buf);

  late final _SetByteArrayRegion = ptr.value.ref.SetByteArrayRegion.asFunction<
      void Function(ffi.Pointer<JniEnv1> env, JByteArrayPtr array, int start,
          int len, ffi.Pointer<JByteMarker> buf)>();
  void SetByteArrayRegion(JByteArrayPtr array, int start, int len,
          ffi.Pointer<JByteMarker> buf) =>
      _SetByteArrayRegion(ptr, array, start, len, buf);

  late final _SetCharArrayRegion = ptr.value.ref.SetCharArrayRegion.asFunction<
      void Function(ffi.Pointer<JniEnv1> env, JCharArrayPtr array, int start,
          int len, ffi.Pointer<JCharMarker> buf)>();
  void SetCharArrayRegion(JCharArrayPtr array, int start, int len,
          ffi.Pointer<JCharMarker> buf) =>
      _SetCharArrayRegion(ptr, array, start, len, buf);

  late final _SetShortArrayRegion = ptr.value.ref.SetShortArrayRegion
      .asFunction<
          void Function(ffi.Pointer<JniEnv1> env, JShortArrayPtr array,
              int start, int len, ffi.Pointer<JShortMarker> buf)>();
  void SetShortArrayRegion(JShortArrayPtr array, int start, int len,
          ffi.Pointer<JShortMarker> buf) =>
      _SetShortArrayRegion(ptr, array, start, len, buf);

  late final _SetIntArrayRegion = ptr.value.ref.SetIntArrayRegion.asFunction<
      void Function(ffi.Pointer<JniEnv1> env, JIntArrayPtr array, int start,
          int len, ffi.Pointer<JIntMarker> buf)>();
  void SetIntArrayRegion(JIntArrayPtr array, int start, int len,
          ffi.Pointer<JIntMarker> buf) =>
      _SetIntArrayRegion(ptr, array, start, len, buf);

  late final _SetLongArrayRegion = ptr.value.ref.SetLongArrayRegion.asFunction<
      void Function(ffi.Pointer<JniEnv1> env, JLongArrayPtr array, int start,
          int len, ffi.Pointer<JLongMarker> buf)>();
  void SetLongArrayRegion(JLongArrayPtr array, int start, int len,
          ffi.Pointer<JLongMarker> buf) =>
      _SetLongArrayRegion(ptr, array, start, len, buf);

  late final _SetFloatArrayRegion = ptr.value.ref.SetFloatArrayRegion
      .asFunction<
          void Function(ffi.Pointer<JniEnv1> env, JFloatArrayPtr array,
              int start, int len, ffi.Pointer<JFloatMarker> buf)>();
  void SetFloatArrayRegion(JFloatArrayPtr array, int start, int len,
          ffi.Pointer<JFloatMarker> buf) =>
      _SetFloatArrayRegion(ptr, array, start, len, buf);

  late final _SetDoubleArrayRegion = ptr.value.ref.SetDoubleArrayRegion
      .asFunction<
          void Function(ffi.Pointer<JniEnv1> env, JDoubleArrayPtr array,
              int start, int len, ffi.Pointer<JDoubleMarker> buf)>();
  void SetDoubleArrayRegion(JDoubleArrayPtr array, int start, int len,
          ffi.Pointer<JDoubleMarker> buf) =>
      _SetDoubleArrayRegion(ptr, array, start, len, buf);

  late final _RegisterNatives = ptr.value.ref.RegisterNatives.asFunction<
      int Function(ffi.Pointer<JniEnv1> env, JClassPtr clazz,
          ffi.Pointer<JNINativeMethod> methods, int nMethods)>();
  int RegisterNatives(JClassPtr clazz, ffi.Pointer<JNINativeMethod> methods,
          int nMethods) =>
      _RegisterNatives(ptr, clazz, methods, nMethods);

  late final _UnregisterNatives = ptr.value.ref.UnregisterNatives
      .asFunction<int Function(ffi.Pointer<JniEnv1> env, JClassPtr clazz)>();
  int UnregisterNatives(JClassPtr clazz) => _UnregisterNatives(ptr, clazz);

  late final _MonitorEnter = ptr.value.ref.MonitorEnter
      .asFunction<int Function(ffi.Pointer<JniEnv1> env, JObjectPtr obj)>();
  int MonitorEnter(JObjectPtr obj) => _MonitorEnter(ptr, obj);

  late final _MonitorExit = ptr.value.ref.MonitorExit
      .asFunction<int Function(ffi.Pointer<JniEnv1> env, JObjectPtr obj)>();
  int MonitorExit(JObjectPtr obj) => _MonitorExit(ptr, obj);

  late final _GetJavaVM = ptr.value.ref.GetJavaVM.asFunction<
      int Function(
          ffi.Pointer<JniEnv1> env, ffi.Pointer<ffi.Pointer<JavaVM1>> vm)>();
  int GetJavaVM(ffi.Pointer<ffi.Pointer<JavaVM1>> vm) => _GetJavaVM(ptr, vm);

  late final _GetStringRegion = ptr.value.ref.GetStringRegion.asFunction<
      void Function(ffi.Pointer<JniEnv1> env, JStringPtr str, int start,
          int len, ffi.Pointer<JCharMarker> buf)>();
  void GetStringRegion(
          JStringPtr str, int start, int len, ffi.Pointer<JCharMarker> buf) =>
      _GetStringRegion(ptr, str, start, len, buf);

  late final _GetStringUTFRegion = ptr.value.ref.GetStringUTFRegion.asFunction<
      void Function(ffi.Pointer<JniEnv1> env, JStringPtr str, int start,
          int len, ffi.Pointer<ffi.Char> buf)>();
  void GetStringUTFRegion(
          JStringPtr str, int start, int len, ffi.Pointer<ffi.Char> buf) =>
      _GetStringUTFRegion(ptr, str, start, len, buf);

  late final _GetPrimitiveArrayCritical =
      ptr.value.ref.GetPrimitiveArrayCritical.asFunction<
          ffi.Pointer<ffi.Void> Function(ffi.Pointer<JniEnv1> env,
              JArrayPtr array, ffi.Pointer<JBooleanMarker> isCopy)>();
  ffi.Pointer<ffi.Void> GetPrimitiveArrayCritical(
          JArrayPtr array, ffi.Pointer<JBooleanMarker> isCopy) =>
      _GetPrimitiveArrayCritical(ptr, array, isCopy);

  late final _ReleasePrimitiveArrayCritical =
      ptr.value.ref.ReleasePrimitiveArrayCritical.asFunction<
          void Function(ffi.Pointer<JniEnv1> env, JArrayPtr array,
              ffi.Pointer<ffi.Void> carray, int mode)>();
  void ReleasePrimitiveArrayCritical(
          JArrayPtr array, ffi.Pointer<ffi.Void> carray, int mode) =>
      _ReleasePrimitiveArrayCritical(ptr, array, carray, mode);

  late final _GetStringCritical = ptr.value.ref.GetStringCritical.asFunction<
      ffi.Pointer<JCharMarker> Function(ffi.Pointer<JniEnv1> env,
          JStringPtr str, ffi.Pointer<JBooleanMarker> isCopy)>();
  ffi.Pointer<JCharMarker> GetStringCritical(
          JStringPtr str, ffi.Pointer<JBooleanMarker> isCopy) =>
      _GetStringCritical(ptr, str, isCopy);

  late final _ReleaseStringCritical = ptr.value.ref.ReleaseStringCritical
      .asFunction<
          void Function(ffi.Pointer<JniEnv1> env, JStringPtr str,
              ffi.Pointer<JCharMarker> carray)>();
  void ReleaseStringCritical(JStringPtr str, ffi.Pointer<JCharMarker> carray) =>
      _ReleaseStringCritical(ptr, str, carray);

  late final _NewWeakGlobalRef = ptr.value.ref.NewWeakGlobalRef.asFunction<
      JWeakPtr Function(ffi.Pointer<JniEnv1> env, JObjectPtr obj)>();
  JWeakPtr NewWeakGlobalRef(JObjectPtr obj) => _NewWeakGlobalRef(ptr, obj);

  late final _DeleteWeakGlobalRef = ptr.value.ref.DeleteWeakGlobalRef
      .asFunction<void Function(ffi.Pointer<JniEnv1> env, JWeakPtr obj)>();
  void DeleteWeakGlobalRef(JWeakPtr obj) => _DeleteWeakGlobalRef(ptr, obj);

  late final _ExceptionCheck = ptr.value.ref.ExceptionCheck
      .asFunction<int Function(ffi.Pointer<JniEnv1> env)>();
  int ExceptionCheck() => _ExceptionCheck(ptr);

  late final _NewDirectByteBuffer = ptr.value.ref.NewDirectByteBuffer
      .asFunction<
          JObjectPtr Function(ffi.Pointer<JniEnv1> env,
              ffi.Pointer<ffi.Void> address, int capacity)>();
  JObjectPtr NewDirectByteBuffer(ffi.Pointer<ffi.Void> address, int capacity) =>
      _NewDirectByteBuffer(ptr, address, capacity);

  late final _GetDirectBufferAddress = ptr.value.ref.GetDirectBufferAddress
      .asFunction<
          ffi.Pointer<ffi.Void> Function(
              ffi.Pointer<JniEnv1> env, JObjectPtr buf)>();
  ffi.Pointer<ffi.Void> GetDirectBufferAddress(JObjectPtr buf) =>
      _GetDirectBufferAddress(ptr, buf);

  late final _GetDirectBufferCapacity = ptr.value.ref.GetDirectBufferCapacity
      .asFunction<int Function(ffi.Pointer<JniEnv1> env, JObjectPtr buf)>();
  int GetDirectBufferCapacity(JObjectPtr buf) =>
      _GetDirectBufferCapacity(ptr, buf);

  late final _GetObjectRefType = ptr.value.ref.GetObjectRefType
      .asFunction<int Function(ffi.Pointer<JniEnv1> env, JObjectPtr obj)>();
  int GetObjectRefType(JObjectPtr obj) => _GetObjectRefType(ptr, obj);
}

/// Wraps over the function pointers in JavaVM and exposes them as methods.
class JniJavaVM {
  final ffi.Pointer<JavaVM> ptr;
  JniJavaVM(this.ptr);

  late final _DestroyJavaVM = ptr.value.ref.DestroyJavaVM
      .asFunction<int Function(ffi.Pointer<JavaVM1> vm)>();
  int DestroyJavaVM() => _DestroyJavaVM(ptr);

  late final _AttachCurrentThread = ptr.value.ref.AttachCurrentThread
      .asFunction<
          int Function(
              ffi.Pointer<JavaVM1> vm,
              ffi.Pointer<ffi.Pointer<JniEnv>> p_env,
              ffi.Pointer<ffi.Void> thr_args)>();
  int AttachCurrentThread(ffi.Pointer<ffi.Pointer<JniEnv>> p_env,
          ffi.Pointer<ffi.Void> thr_args) =>
      _AttachCurrentThread(ptr, p_env, thr_args);

  late final _DetachCurrentThread = ptr.value.ref.DetachCurrentThread
      .asFunction<int Function(ffi.Pointer<JavaVM1> vm)>();
  int DetachCurrentThread() => _DetachCurrentThread(ptr);

  late final _GetEnv = ptr.value.ref.GetEnv.asFunction<
      int Function(ffi.Pointer<JavaVM1> vm,
          ffi.Pointer<ffi.Pointer<ffi.Void>> p_env, int version)>();
  int GetEnv(ffi.Pointer<ffi.Pointer<ffi.Void>> p_env, int version) =>
      _GetEnv(ptr, p_env, version);

  late final _AttachCurrentThreadAsDaemon =
      ptr.value.ref.AttachCurrentThreadAsDaemon.asFunction<
          int Function(
              ffi.Pointer<JavaVM1> vm,
              ffi.Pointer<ffi.Pointer<JniEnv>> p_env,
              ffi.Pointer<ffi.Void> thr_args)>();
  int AttachCurrentThreadAsDaemon(ffi.Pointer<ffi.Pointer<JniEnv>> p_env,
          ffi.Pointer<ffi.Void> thr_args) =>
      _AttachCurrentThreadAsDaemon(ptr, p_env, thr_args);
}
