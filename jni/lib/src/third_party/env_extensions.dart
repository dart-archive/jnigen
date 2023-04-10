// Auto generated file. Do not edit.
// ignore_for_file: non_constant_identifier_names

import "dart:ffi" as ffi;

import "jni_bindings_generated.dart";
import "../accessors.dart";

extension EnvExtension on ffi.Pointer<GlobalJniEnv> {
  int GetVersion() =>
      ref.GetVersion.asFunction<JniResult Function()>()().integer;

  JClassPtr DefineClass(ffi.Pointer<ffi.Char> name, JObjectPtr loader,
          ffi.Pointer<JByteMarker> buf, int bufLen) =>
      ref.DefineClass.asFunction<
              JniClassLookupResult Function(
                  ffi.Pointer<ffi.Char> name,
                  JObjectPtr loader,
                  ffi.Pointer<JByteMarker> buf,
                  int bufLen)>()(name, loader, buf, bufLen)
          .value;

  JClassPtr FindClass(ffi.Pointer<ffi.Char> name) => ref.FindClass.asFunction<
          JniClassLookupResult Function(ffi.Pointer<ffi.Char> name)>()(name)
      .value;

  JMethodIDPtr FromReflectedMethod(JObjectPtr method) => ref.FromReflectedMethod
          .asFunction<JniPointerResult Function(JObjectPtr method)>()(method)
      .methodID;

  JFieldIDPtr FromReflectedField(JObjectPtr field) => ref.FromReflectedField
          .asFunction<JniPointerResult Function(JObjectPtr field)>()(field)
      .fieldID;

  JObjectPtr ToReflectedMethod(
          JClassPtr cls, JMethodIDPtr methodId, int isStatic) =>
      ref.ToReflectedMethod.asFunction<
              JniResult Function(JClassPtr cls, JMethodIDPtr methodId,
                  int isStatic)>()(cls, methodId, isStatic)
          .object;

  JClassPtr GetSuperclass(JClassPtr clazz) => ref.GetSuperclass.asFunction<
          JniClassLookupResult Function(JClassPtr clazz)>()(clazz)
      .value;

  bool IsAssignableFrom(JClassPtr clazz1, JClassPtr clazz2) =>
      ref.IsAssignableFrom.asFunction<
              JniResult Function(
                  JClassPtr clazz1, JClassPtr clazz2)>()(clazz1, clazz2)
          .boolean;

  JObjectPtr ToReflectedField(
          JClassPtr cls, JFieldIDPtr fieldID, int isStatic) =>
      ref.ToReflectedField.asFunction<
              JniResult Function(JClassPtr cls, JFieldIDPtr fieldID,
                  int isStatic)>()(cls, fieldID, isStatic)
          .object;

  int Throw(JThrowablePtr obj) =>
      ref.Throw.asFunction<JniResult Function(JThrowablePtr obj)>()(obj)
          .integer;

  int ThrowNew(JClassPtr clazz, ffi.Pointer<ffi.Char> message) =>
      ref.ThrowNew.asFunction<
              JniResult Function(JClassPtr clazz,
                  ffi.Pointer<ffi.Char> message)>()(clazz, message)
          .integer;

  JThrowablePtr ExceptionOccurred() =>
      ref.ExceptionOccurred.asFunction<JniResult Function()>()().object;

  void ExceptionDescribe() =>
      ref.ExceptionDescribe.asFunction<JThrowablePtr Function()>()().check();

  void ExceptionClear() =>
      ref.ExceptionClear.asFunction<JThrowablePtr Function()>()().check();

  void FatalError(ffi.Pointer<ffi.Char> msg) => ref.FatalError.asFunction<
          JThrowablePtr Function(ffi.Pointer<ffi.Char> msg)>()(msg)
      .check();

  int PushLocalFrame(int capacity) =>
      ref.PushLocalFrame.asFunction<JniResult Function(int capacity)>()(
              capacity)
          .integer;

  JObjectPtr PopLocalFrame(JObjectPtr result) =>
      ref.PopLocalFrame.asFunction<JniResult Function(JObjectPtr result)>()(
              result)
          .object;

  JObjectPtr NewGlobalRef(JObjectPtr obj) =>
      ref.NewGlobalRef.asFunction<JniResult Function(JObjectPtr obj)>()(obj)
          .object;

  void DeleteGlobalRef(JObjectPtr globalRef) => ref.DeleteGlobalRef.asFunction<
          JThrowablePtr Function(JObjectPtr globalRef)>()(globalRef)
      .check();

  void DeleteLocalRef(JObjectPtr localRef) => ref.DeleteLocalRef.asFunction<
          JThrowablePtr Function(JObjectPtr localRef)>()(localRef)
      .check();

  bool IsSameObject(JObjectPtr ref1, JObjectPtr ref2) =>
      ref.IsSameObject.asFunction<
              JniResult Function(
                  JObjectPtr ref1, JObjectPtr ref2)>()(ref1, ref2)
          .boolean;

  JObjectPtr NewLocalRef(JObjectPtr obj) =>
      ref.NewLocalRef.asFunction<JniResult Function(JObjectPtr obj)>()(obj)
          .object;

  int EnsureLocalCapacity(int capacity) =>
      ref.EnsureLocalCapacity.asFunction<JniResult Function(int capacity)>()(
              capacity)
          .integer;

  JObjectPtr AllocObject(JClassPtr clazz) =>
      ref.AllocObject.asFunction<JniResult Function(JClassPtr clazz)>()(clazz)
          .object;

  JObjectPtr NewObject(JClassPtr clazz, JMethodIDPtr methodID) =>
      ref.NewObject.asFunction<
              JniResult Function(
                  JClassPtr clazz, JMethodIDPtr methodID)>()(clazz, methodID)
          .object;

  JObjectPtr NewObjectA(
          JClassPtr clazz, JMethodIDPtr methodID, ffi.Pointer<JValue> args) =>
      ref.NewObjectA.asFunction<
              JniResult Function(JClassPtr clazz, JMethodIDPtr methodID,
                  ffi.Pointer<JValue> args)>()(clazz, methodID, args)
          .object;

  JClassPtr GetObjectClass(JObjectPtr obj) => ref.GetObjectClass.asFunction<
          JniClassLookupResult Function(JObjectPtr obj)>()(obj)
      .value;

  bool IsInstanceOf(JObjectPtr obj, JClassPtr clazz) =>
      ref.IsInstanceOf.asFunction<
              JniResult Function(JObjectPtr obj, JClassPtr clazz)>()(obj, clazz)
          .boolean;

  JMethodIDPtr GetMethodID(JClassPtr clazz, ffi.Pointer<ffi.Char> name,
          ffi.Pointer<ffi.Char> sig) =>
      ref.GetMethodID.asFunction<
              JniPointerResult Function(
                  JClassPtr clazz,
                  ffi.Pointer<ffi.Char> name,
                  ffi.Pointer<ffi.Char> sig)>()(clazz, name, sig)
          .methodID;

  JObjectPtr CallObjectMethod(JObjectPtr obj, JMethodIDPtr methodID) =>
      ref.CallObjectMethod.asFunction<
              JniResult Function(
                  JObjectPtr obj, JMethodIDPtr methodID)>()(obj, methodID)
          .object;

  JObjectPtr CallObjectMethodA(
          JObjectPtr obj, JMethodIDPtr methodID, ffi.Pointer<JValue> args) =>
      ref.CallObjectMethodA.asFunction<
              JniResult Function(JObjectPtr obj, JMethodIDPtr methodID,
                  ffi.Pointer<JValue> args)>()(obj, methodID, args)
          .object;

  bool CallBooleanMethod(JObjectPtr obj, JMethodIDPtr methodID) =>
      ref.CallBooleanMethod.asFunction<
              JniResult Function(
                  JObjectPtr obj, JMethodIDPtr methodID)>()(obj, methodID)
          .boolean;

  bool CallBooleanMethodA(
          JObjectPtr obj, JMethodIDPtr methodId, ffi.Pointer<JValue> args) =>
      ref.CallBooleanMethodA.asFunction<
              JniResult Function(JObjectPtr obj, JMethodIDPtr methodId,
                  ffi.Pointer<JValue> args)>()(obj, methodId, args)
          .boolean;

  int CallByteMethod(JObjectPtr obj, JMethodIDPtr methodID) =>
      ref.CallByteMethod.asFunction<
              JniResult Function(
                  JObjectPtr obj, JMethodIDPtr methodID)>()(obj, methodID)
          .byte;

  int CallByteMethodA(
          JObjectPtr obj, JMethodIDPtr methodID, ffi.Pointer<JValue> args) =>
      ref.CallByteMethodA.asFunction<
              JniResult Function(JObjectPtr obj, JMethodIDPtr methodID,
                  ffi.Pointer<JValue> args)>()(obj, methodID, args)
          .byte;

  int CallCharMethod(JObjectPtr obj, JMethodIDPtr methodID) =>
      ref.CallCharMethod.asFunction<
              JniResult Function(
                  JObjectPtr obj, JMethodIDPtr methodID)>()(obj, methodID)
          .char;

  int CallCharMethodA(
          JObjectPtr obj, JMethodIDPtr methodID, ffi.Pointer<JValue> args) =>
      ref.CallCharMethodA.asFunction<
              JniResult Function(JObjectPtr obj, JMethodIDPtr methodID,
                  ffi.Pointer<JValue> args)>()(obj, methodID, args)
          .char;

  int CallShortMethod(JObjectPtr obj, JMethodIDPtr methodID) =>
      ref.CallShortMethod.asFunction<
              JniResult Function(
                  JObjectPtr obj, JMethodIDPtr methodID)>()(obj, methodID)
          .short;

  int CallShortMethodA(
          JObjectPtr obj, JMethodIDPtr methodID, ffi.Pointer<JValue> args) =>
      ref.CallShortMethodA.asFunction<
              JniResult Function(JObjectPtr obj, JMethodIDPtr methodID,
                  ffi.Pointer<JValue> args)>()(obj, methodID, args)
          .short;

  int CallIntMethod(JObjectPtr obj, JMethodIDPtr methodID) =>
      ref.CallIntMethod.asFunction<
              JniResult Function(
                  JObjectPtr obj, JMethodIDPtr methodID)>()(obj, methodID)
          .integer;

  int CallIntMethodA(
          JObjectPtr obj, JMethodIDPtr methodID, ffi.Pointer<JValue> args) =>
      ref.CallIntMethodA.asFunction<
              JniResult Function(JObjectPtr obj, JMethodIDPtr methodID,
                  ffi.Pointer<JValue> args)>()(obj, methodID, args)
          .integer;

  int CallLongMethod(JObjectPtr obj, JMethodIDPtr methodID) =>
      ref.CallLongMethod.asFunction<
              JniResult Function(
                  JObjectPtr obj, JMethodIDPtr methodID)>()(obj, methodID)
          .long;

  int CallLongMethodA(
          JObjectPtr obj, JMethodIDPtr methodID, ffi.Pointer<JValue> args) =>
      ref.CallLongMethodA.asFunction<
              JniResult Function(JObjectPtr obj, JMethodIDPtr methodID,
                  ffi.Pointer<JValue> args)>()(obj, methodID, args)
          .long;

  double CallFloatMethod(JObjectPtr obj, JMethodIDPtr methodID) =>
      ref.CallFloatMethod.asFunction<
              JniResult Function(
                  JObjectPtr obj, JMethodIDPtr methodID)>()(obj, methodID)
          .float;

  double CallFloatMethodA(
          JObjectPtr obj, JMethodIDPtr methodID, ffi.Pointer<JValue> args) =>
      ref.CallFloatMethodA.asFunction<
              JniResult Function(JObjectPtr obj, JMethodIDPtr methodID,
                  ffi.Pointer<JValue> args)>()(obj, methodID, args)
          .float;

  double CallDoubleMethod(JObjectPtr obj, JMethodIDPtr methodID) =>
      ref.CallDoubleMethod.asFunction<
              JniResult Function(
                  JObjectPtr obj, JMethodIDPtr methodID)>()(obj, methodID)
          .doubleFloat;

  double CallDoubleMethodA(
          JObjectPtr obj, JMethodIDPtr methodID, ffi.Pointer<JValue> args) =>
      ref.CallDoubleMethodA.asFunction<
              JniResult Function(JObjectPtr obj, JMethodIDPtr methodID,
                  ffi.Pointer<JValue> args)>()(obj, methodID, args)
          .doubleFloat;

  void CallVoidMethod(JObjectPtr obj, JMethodIDPtr methodID) =>
      ref.CallVoidMethod.asFunction<
              JThrowablePtr Function(
                  JObjectPtr obj, JMethodIDPtr methodID)>()(obj, methodID)
          .check();

  void CallVoidMethodA(
          JObjectPtr obj, JMethodIDPtr methodID, ffi.Pointer<JValue> args) =>
      ref.CallVoidMethodA.asFunction<
              JThrowablePtr Function(JObjectPtr obj, JMethodIDPtr methodID,
                  ffi.Pointer<JValue> args)>()(obj, methodID, args)
          .check();

  JObjectPtr CallNonvirtualObjectMethod(
          JObjectPtr obj, JClassPtr clazz, JMethodIDPtr methodID) =>
      ref.CallNonvirtualObjectMethod.asFunction<
              JniResult Function(JObjectPtr obj, JClassPtr clazz,
                  JMethodIDPtr methodID)>()(obj, clazz, methodID)
          .object;

  JObjectPtr CallNonvirtualObjectMethodA(JObjectPtr obj, JClassPtr clazz,
          JMethodIDPtr methodID, ffi.Pointer<JValue> args) =>
      ref.CallNonvirtualObjectMethodA.asFunction<
              JniResult Function(
                  JObjectPtr obj,
                  JClassPtr clazz,
                  JMethodIDPtr methodID,
                  ffi.Pointer<JValue> args)>()(obj, clazz, methodID, args)
          .object;

  bool CallNonvirtualBooleanMethod(
          JObjectPtr obj, JClassPtr clazz, JMethodIDPtr methodID) =>
      ref.CallNonvirtualBooleanMethod.asFunction<
              JniResult Function(JObjectPtr obj, JClassPtr clazz,
                  JMethodIDPtr methodID)>()(obj, clazz, methodID)
          .boolean;

  bool CallNonvirtualBooleanMethodA(JObjectPtr obj, JClassPtr clazz,
          JMethodIDPtr methodID, ffi.Pointer<JValue> args) =>
      ref.CallNonvirtualBooleanMethodA.asFunction<
              JniResult Function(
                  JObjectPtr obj,
                  JClassPtr clazz,
                  JMethodIDPtr methodID,
                  ffi.Pointer<JValue> args)>()(obj, clazz, methodID, args)
          .boolean;

  int CallNonvirtualByteMethod(
          JObjectPtr obj, JClassPtr clazz, JMethodIDPtr methodID) =>
      ref.CallNonvirtualByteMethod.asFunction<
              JniResult Function(JObjectPtr obj, JClassPtr clazz,
                  JMethodIDPtr methodID)>()(obj, clazz, methodID)
          .byte;

  int CallNonvirtualByteMethodA(JObjectPtr obj, JClassPtr clazz,
          JMethodIDPtr methodID, ffi.Pointer<JValue> args) =>
      ref.CallNonvirtualByteMethodA.asFunction<
              JniResult Function(
                  JObjectPtr obj,
                  JClassPtr clazz,
                  JMethodIDPtr methodID,
                  ffi.Pointer<JValue> args)>()(obj, clazz, methodID, args)
          .byte;

  int CallNonvirtualCharMethod(
          JObjectPtr obj, JClassPtr clazz, JMethodIDPtr methodID) =>
      ref.CallNonvirtualCharMethod.asFunction<
              JniResult Function(JObjectPtr obj, JClassPtr clazz,
                  JMethodIDPtr methodID)>()(obj, clazz, methodID)
          .char;

  int CallNonvirtualCharMethodA(JObjectPtr obj, JClassPtr clazz,
          JMethodIDPtr methodID, ffi.Pointer<JValue> args) =>
      ref.CallNonvirtualCharMethodA.asFunction<
              JniResult Function(
                  JObjectPtr obj,
                  JClassPtr clazz,
                  JMethodIDPtr methodID,
                  ffi.Pointer<JValue> args)>()(obj, clazz, methodID, args)
          .char;

  int CallNonvirtualShortMethod(
          JObjectPtr obj, JClassPtr clazz, JMethodIDPtr methodID) =>
      ref.CallNonvirtualShortMethod.asFunction<
              JniResult Function(JObjectPtr obj, JClassPtr clazz,
                  JMethodIDPtr methodID)>()(obj, clazz, methodID)
          .short;

  int CallNonvirtualShortMethodA(JObjectPtr obj, JClassPtr clazz,
          JMethodIDPtr methodID, ffi.Pointer<JValue> args) =>
      ref.CallNonvirtualShortMethodA.asFunction<
              JniResult Function(
                  JObjectPtr obj,
                  JClassPtr clazz,
                  JMethodIDPtr methodID,
                  ffi.Pointer<JValue> args)>()(obj, clazz, methodID, args)
          .short;

  int CallNonvirtualIntMethod(
          JObjectPtr obj, JClassPtr clazz, JMethodIDPtr methodID) =>
      ref.CallNonvirtualIntMethod.asFunction<
              JniResult Function(JObjectPtr obj, JClassPtr clazz,
                  JMethodIDPtr methodID)>()(obj, clazz, methodID)
          .integer;

  int CallNonvirtualIntMethodA(JObjectPtr obj, JClassPtr clazz,
          JMethodIDPtr methodID, ffi.Pointer<JValue> args) =>
      ref.CallNonvirtualIntMethodA.asFunction<
              JniResult Function(
                  JObjectPtr obj,
                  JClassPtr clazz,
                  JMethodIDPtr methodID,
                  ffi.Pointer<JValue> args)>()(obj, clazz, methodID, args)
          .integer;

  int CallNonvirtualLongMethod(
          JObjectPtr obj, JClassPtr clazz, JMethodIDPtr methodID) =>
      ref.CallNonvirtualLongMethod.asFunction<
              JniResult Function(JObjectPtr obj, JClassPtr clazz,
                  JMethodIDPtr methodID)>()(obj, clazz, methodID)
          .long;

  int CallNonvirtualLongMethodA(JObjectPtr obj, JClassPtr clazz,
          JMethodIDPtr methodID, ffi.Pointer<JValue> args) =>
      ref.CallNonvirtualLongMethodA.asFunction<
              JniResult Function(
                  JObjectPtr obj,
                  JClassPtr clazz,
                  JMethodIDPtr methodID,
                  ffi.Pointer<JValue> args)>()(obj, clazz, methodID, args)
          .long;

  double CallNonvirtualFloatMethod(
          JObjectPtr obj, JClassPtr clazz, JMethodIDPtr methodID) =>
      ref.CallNonvirtualFloatMethod.asFunction<
              JniResult Function(JObjectPtr obj, JClassPtr clazz,
                  JMethodIDPtr methodID)>()(obj, clazz, methodID)
          .float;

  double CallNonvirtualFloatMethodA(JObjectPtr obj, JClassPtr clazz,
          JMethodIDPtr methodID, ffi.Pointer<JValue> args) =>
      ref.CallNonvirtualFloatMethodA.asFunction<
              JniResult Function(
                  JObjectPtr obj,
                  JClassPtr clazz,
                  JMethodIDPtr methodID,
                  ffi.Pointer<JValue> args)>()(obj, clazz, methodID, args)
          .float;

  double CallNonvirtualDoubleMethod(
          JObjectPtr obj, JClassPtr clazz, JMethodIDPtr methodID) =>
      ref.CallNonvirtualDoubleMethod.asFunction<
              JniResult Function(JObjectPtr obj, JClassPtr clazz,
                  JMethodIDPtr methodID)>()(obj, clazz, methodID)
          .doubleFloat;

  double CallNonvirtualDoubleMethodA(JObjectPtr obj, JClassPtr clazz,
          JMethodIDPtr methodID, ffi.Pointer<JValue> args) =>
      ref.CallNonvirtualDoubleMethodA.asFunction<
              JniResult Function(
                  JObjectPtr obj,
                  JClassPtr clazz,
                  JMethodIDPtr methodID,
                  ffi.Pointer<JValue> args)>()(obj, clazz, methodID, args)
          .doubleFloat;

  void CallNonvirtualVoidMethod(
          JObjectPtr obj, JClassPtr clazz, JMethodIDPtr methodID) =>
      ref.CallNonvirtualVoidMethod.asFunction<
              JThrowablePtr Function(JObjectPtr obj, JClassPtr clazz,
                  JMethodIDPtr methodID)>()(obj, clazz, methodID)
          .check();

  void CallNonvirtualVoidMethodA(JObjectPtr obj, JClassPtr clazz,
          JMethodIDPtr methodID, ffi.Pointer<JValue> args) =>
      ref.CallNonvirtualVoidMethodA.asFunction<
              JThrowablePtr Function(
                  JObjectPtr obj,
                  JClassPtr clazz,
                  JMethodIDPtr methodID,
                  ffi.Pointer<JValue> args)>()(obj, clazz, methodID, args)
          .check();

  JFieldIDPtr GetFieldID(JClassPtr clazz, ffi.Pointer<ffi.Char> name,
          ffi.Pointer<ffi.Char> sig) =>
      ref.GetFieldID.asFunction<
              JniPointerResult Function(
                  JClassPtr clazz,
                  ffi.Pointer<ffi.Char> name,
                  ffi.Pointer<ffi.Char> sig)>()(clazz, name, sig)
          .fieldID;

  JObjectPtr GetObjectField(JObjectPtr obj, JFieldIDPtr fieldID) =>
      ref.GetObjectField.asFunction<
              JniResult Function(
                  JObjectPtr obj, JFieldIDPtr fieldID)>()(obj, fieldID)
          .object;

  bool GetBooleanField(JObjectPtr obj, JFieldIDPtr fieldID) =>
      ref.GetBooleanField.asFunction<
              JniResult Function(
                  JObjectPtr obj, JFieldIDPtr fieldID)>()(obj, fieldID)
          .boolean;

  int GetByteField(JObjectPtr obj, JFieldIDPtr fieldID) =>
      ref.GetByteField.asFunction<
              JniResult Function(
                  JObjectPtr obj, JFieldIDPtr fieldID)>()(obj, fieldID)
          .byte;

  int GetCharField(JObjectPtr obj, JFieldIDPtr fieldID) =>
      ref.GetCharField.asFunction<
              JniResult Function(
                  JObjectPtr obj, JFieldIDPtr fieldID)>()(obj, fieldID)
          .char;

  int GetShortField(JObjectPtr obj, JFieldIDPtr fieldID) =>
      ref.GetShortField.asFunction<
              JniResult Function(
                  JObjectPtr obj, JFieldIDPtr fieldID)>()(obj, fieldID)
          .short;

  int GetIntField(JObjectPtr obj, JFieldIDPtr fieldID) =>
      ref.GetIntField.asFunction<
              JniResult Function(
                  JObjectPtr obj, JFieldIDPtr fieldID)>()(obj, fieldID)
          .integer;

  int GetLongField(JObjectPtr obj, JFieldIDPtr fieldID) =>
      ref.GetLongField.asFunction<
              JniResult Function(
                  JObjectPtr obj, JFieldIDPtr fieldID)>()(obj, fieldID)
          .long;

  double GetFloatField(JObjectPtr obj, JFieldIDPtr fieldID) =>
      ref.GetFloatField.asFunction<
              JniResult Function(
                  JObjectPtr obj, JFieldIDPtr fieldID)>()(obj, fieldID)
          .float;

  double GetDoubleField(JObjectPtr obj, JFieldIDPtr fieldID) =>
      ref.GetDoubleField.asFunction<
              JniResult Function(
                  JObjectPtr obj, JFieldIDPtr fieldID)>()(obj, fieldID)
          .doubleFloat;

  void SetObjectField(JObjectPtr obj, JFieldIDPtr fieldID, JObjectPtr val) =>
      ref.SetObjectField.asFunction<
              JThrowablePtr Function(JObjectPtr obj, JFieldIDPtr fieldID,
                  JObjectPtr val)>()(obj, fieldID, val)
          .check();

  void SetBooleanField(JObjectPtr obj, JFieldIDPtr fieldID, int val) =>
      ref.SetBooleanField.asFunction<
              JThrowablePtr Function(JObjectPtr obj, JFieldIDPtr fieldID,
                  int val)>()(obj, fieldID, val)
          .check();

  void SetByteField(JObjectPtr obj, JFieldIDPtr fieldID, int val) =>
      ref.SetByteField.asFunction<
              JThrowablePtr Function(JObjectPtr obj, JFieldIDPtr fieldID,
                  int val)>()(obj, fieldID, val)
          .check();

  void SetCharField(JObjectPtr obj, JFieldIDPtr fieldID, int val) =>
      ref.SetCharField.asFunction<
              JThrowablePtr Function(JObjectPtr obj, JFieldIDPtr fieldID,
                  int val)>()(obj, fieldID, val)
          .check();

  void SetShortField(JObjectPtr obj, JFieldIDPtr fieldID, int val) =>
      ref.SetShortField.asFunction<
              JThrowablePtr Function(JObjectPtr obj, JFieldIDPtr fieldID,
                  int val)>()(obj, fieldID, val)
          .check();

  void SetIntField(JObjectPtr obj, JFieldIDPtr fieldID, int val) =>
      ref.SetIntField.asFunction<
              JThrowablePtr Function(JObjectPtr obj, JFieldIDPtr fieldID,
                  int val)>()(obj, fieldID, val)
          .check();

  void SetLongField(JObjectPtr obj, JFieldIDPtr fieldID, int val) =>
      ref.SetLongField.asFunction<
              JThrowablePtr Function(JObjectPtr obj, JFieldIDPtr fieldID,
                  int val)>()(obj, fieldID, val)
          .check();

  void SetFloatField(JObjectPtr obj, JFieldIDPtr fieldID, double val) =>
      ref.SetFloatField.asFunction<
              JThrowablePtr Function(JObjectPtr obj, JFieldIDPtr fieldID,
                  double val)>()(obj, fieldID, val)
          .check();

  void SetDoubleField(JObjectPtr obj, JFieldIDPtr fieldID, double val) =>
      ref.SetDoubleField.asFunction<
              JThrowablePtr Function(JObjectPtr obj, JFieldIDPtr fieldID,
                  double val)>()(obj, fieldID, val)
          .check();

  JMethodIDPtr GetStaticMethodID(JClassPtr clazz, ffi.Pointer<ffi.Char> name,
          ffi.Pointer<ffi.Char> sig) =>
      ref.GetStaticMethodID.asFunction<
              JniPointerResult Function(
                  JClassPtr clazz,
                  ffi.Pointer<ffi.Char> name,
                  ffi.Pointer<ffi.Char> sig)>()(clazz, name, sig)
          .methodID;

  JObjectPtr CallStaticObjectMethod(JClassPtr clazz, JMethodIDPtr methodID) =>
      ref.CallStaticObjectMethod.asFunction<
              JniResult Function(
                  JClassPtr clazz, JMethodIDPtr methodID)>()(clazz, methodID)
          .object;

  JObjectPtr CallStaticObjectMethodA(
          JClassPtr clazz, JMethodIDPtr methodID, ffi.Pointer<JValue> args) =>
      ref.CallStaticObjectMethodA.asFunction<
              JniResult Function(JClassPtr clazz, JMethodIDPtr methodID,
                  ffi.Pointer<JValue> args)>()(clazz, methodID, args)
          .object;

  bool CallStaticBooleanMethod(JClassPtr clazz, JMethodIDPtr methodID) =>
      ref.CallStaticBooleanMethod.asFunction<
              JniResult Function(
                  JClassPtr clazz, JMethodIDPtr methodID)>()(clazz, methodID)
          .boolean;

  bool CallStaticBooleanMethodA(
          JClassPtr clazz, JMethodIDPtr methodID, ffi.Pointer<JValue> args) =>
      ref.CallStaticBooleanMethodA.asFunction<
              JniResult Function(JClassPtr clazz, JMethodIDPtr methodID,
                  ffi.Pointer<JValue> args)>()(clazz, methodID, args)
          .boolean;

  int CallStaticByteMethod(JClassPtr clazz, JMethodIDPtr methodID) =>
      ref.CallStaticByteMethod.asFunction<
              JniResult Function(
                  JClassPtr clazz, JMethodIDPtr methodID)>()(clazz, methodID)
          .byte;

  int CallStaticByteMethodA(
          JClassPtr clazz, JMethodIDPtr methodID, ffi.Pointer<JValue> args) =>
      ref.CallStaticByteMethodA.asFunction<
              JniResult Function(JClassPtr clazz, JMethodIDPtr methodID,
                  ffi.Pointer<JValue> args)>()(clazz, methodID, args)
          .byte;

  int CallStaticCharMethod(JClassPtr clazz, JMethodIDPtr methodID) =>
      ref.CallStaticCharMethod.asFunction<
              JniResult Function(
                  JClassPtr clazz, JMethodIDPtr methodID)>()(clazz, methodID)
          .char;

  int CallStaticCharMethodA(
          JClassPtr clazz, JMethodIDPtr methodID, ffi.Pointer<JValue> args) =>
      ref.CallStaticCharMethodA.asFunction<
              JniResult Function(JClassPtr clazz, JMethodIDPtr methodID,
                  ffi.Pointer<JValue> args)>()(clazz, methodID, args)
          .char;

  int CallStaticShortMethod(JClassPtr clazz, JMethodIDPtr methodID) =>
      ref.CallStaticShortMethod.asFunction<
              JniResult Function(
                  JClassPtr clazz, JMethodIDPtr methodID)>()(clazz, methodID)
          .short;

  int CallStaticShortMethodA(
          JClassPtr clazz, JMethodIDPtr methodID, ffi.Pointer<JValue> args) =>
      ref.CallStaticShortMethodA.asFunction<
              JniResult Function(JClassPtr clazz, JMethodIDPtr methodID,
                  ffi.Pointer<JValue> args)>()(clazz, methodID, args)
          .short;

  int CallStaticIntMethod(JClassPtr clazz, JMethodIDPtr methodID) =>
      ref.CallStaticIntMethod.asFunction<
              JniResult Function(
                  JClassPtr clazz, JMethodIDPtr methodID)>()(clazz, methodID)
          .integer;

  int CallStaticIntMethodA(
          JClassPtr clazz, JMethodIDPtr methodID, ffi.Pointer<JValue> args) =>
      ref.CallStaticIntMethodA.asFunction<
              JniResult Function(JClassPtr clazz, JMethodIDPtr methodID,
                  ffi.Pointer<JValue> args)>()(clazz, methodID, args)
          .integer;

  int CallStaticLongMethod(JClassPtr clazz, JMethodIDPtr methodID) =>
      ref.CallStaticLongMethod.asFunction<
              JniResult Function(
                  JClassPtr clazz, JMethodIDPtr methodID)>()(clazz, methodID)
          .long;

  int CallStaticLongMethodA(
          JClassPtr clazz, JMethodIDPtr methodID, ffi.Pointer<JValue> args) =>
      ref.CallStaticLongMethodA.asFunction<
              JniResult Function(JClassPtr clazz, JMethodIDPtr methodID,
                  ffi.Pointer<JValue> args)>()(clazz, methodID, args)
          .long;

  double CallStaticFloatMethod(JClassPtr clazz, JMethodIDPtr methodID) =>
      ref.CallStaticFloatMethod.asFunction<
              JniResult Function(
                  JClassPtr clazz, JMethodIDPtr methodID)>()(clazz, methodID)
          .float;

  double CallStaticFloatMethodA(
          JClassPtr clazz, JMethodIDPtr methodID, ffi.Pointer<JValue> args) =>
      ref.CallStaticFloatMethodA.asFunction<
              JniResult Function(JClassPtr clazz, JMethodIDPtr methodID,
                  ffi.Pointer<JValue> args)>()(clazz, methodID, args)
          .float;

  double CallStaticDoubleMethod(JClassPtr clazz, JMethodIDPtr methodID) =>
      ref.CallStaticDoubleMethod.asFunction<
              JniResult Function(
                  JClassPtr clazz, JMethodIDPtr methodID)>()(clazz, methodID)
          .doubleFloat;

  double CallStaticDoubleMethodA(
          JClassPtr clazz, JMethodIDPtr methodID, ffi.Pointer<JValue> args) =>
      ref.CallStaticDoubleMethodA.asFunction<
              JniResult Function(JClassPtr clazz, JMethodIDPtr methodID,
                  ffi.Pointer<JValue> args)>()(clazz, methodID, args)
          .doubleFloat;

  void CallStaticVoidMethod(JClassPtr clazz, JMethodIDPtr methodID) =>
      ref.CallStaticVoidMethod.asFunction<
              JThrowablePtr Function(
                  JClassPtr clazz, JMethodIDPtr methodID)>()(clazz, methodID)
          .check();

  void CallStaticVoidMethodA(
          JClassPtr clazz, JMethodIDPtr methodID, ffi.Pointer<JValue> args) =>
      ref.CallStaticVoidMethodA.asFunction<
              JThrowablePtr Function(JClassPtr clazz, JMethodIDPtr methodID,
                  ffi.Pointer<JValue> args)>()(clazz, methodID, args)
          .check();

  JFieldIDPtr GetStaticFieldID(JClassPtr clazz, ffi.Pointer<ffi.Char> name,
          ffi.Pointer<ffi.Char> sig) =>
      ref.GetStaticFieldID.asFunction<
              JniPointerResult Function(
                  JClassPtr clazz,
                  ffi.Pointer<ffi.Char> name,
                  ffi.Pointer<ffi.Char> sig)>()(clazz, name, sig)
          .fieldID;

  JObjectPtr GetStaticObjectField(JClassPtr clazz, JFieldIDPtr fieldID) =>
      ref.GetStaticObjectField.asFunction<
              JniResult Function(
                  JClassPtr clazz, JFieldIDPtr fieldID)>()(clazz, fieldID)
          .object;

  bool GetStaticBooleanField(JClassPtr clazz, JFieldIDPtr fieldID) =>
      ref.GetStaticBooleanField.asFunction<
              JniResult Function(
                  JClassPtr clazz, JFieldIDPtr fieldID)>()(clazz, fieldID)
          .boolean;

  int GetStaticByteField(JClassPtr clazz, JFieldIDPtr fieldID) =>
      ref.GetStaticByteField.asFunction<
              JniResult Function(
                  JClassPtr clazz, JFieldIDPtr fieldID)>()(clazz, fieldID)
          .byte;

  int GetStaticCharField(JClassPtr clazz, JFieldIDPtr fieldID) =>
      ref.GetStaticCharField.asFunction<
              JniResult Function(
                  JClassPtr clazz, JFieldIDPtr fieldID)>()(clazz, fieldID)
          .char;

  int GetStaticShortField(JClassPtr clazz, JFieldIDPtr fieldID) =>
      ref.GetStaticShortField.asFunction<
              JniResult Function(
                  JClassPtr clazz, JFieldIDPtr fieldID)>()(clazz, fieldID)
          .short;

  int GetStaticIntField(JClassPtr clazz, JFieldIDPtr fieldID) =>
      ref.GetStaticIntField.asFunction<
              JniResult Function(
                  JClassPtr clazz, JFieldIDPtr fieldID)>()(clazz, fieldID)
          .integer;

  int GetStaticLongField(JClassPtr clazz, JFieldIDPtr fieldID) =>
      ref.GetStaticLongField.asFunction<
              JniResult Function(
                  JClassPtr clazz, JFieldIDPtr fieldID)>()(clazz, fieldID)
          .long;

  double GetStaticFloatField(JClassPtr clazz, JFieldIDPtr fieldID) =>
      ref.GetStaticFloatField.asFunction<
              JniResult Function(
                  JClassPtr clazz, JFieldIDPtr fieldID)>()(clazz, fieldID)
          .float;

  double GetStaticDoubleField(JClassPtr clazz, JFieldIDPtr fieldID) =>
      ref.GetStaticDoubleField.asFunction<
              JniResult Function(
                  JClassPtr clazz, JFieldIDPtr fieldID)>()(clazz, fieldID)
          .doubleFloat;

  void SetStaticObjectField(
          JClassPtr clazz, JFieldIDPtr fieldID, JObjectPtr val) =>
      ref.SetStaticObjectField.asFunction<
              JThrowablePtr Function(JClassPtr clazz, JFieldIDPtr fieldID,
                  JObjectPtr val)>()(clazz, fieldID, val)
          .check();

  void SetStaticBooleanField(JClassPtr clazz, JFieldIDPtr fieldID, int val) =>
      ref.SetStaticBooleanField.asFunction<
              JThrowablePtr Function(JClassPtr clazz, JFieldIDPtr fieldID,
                  int val)>()(clazz, fieldID, val)
          .check();

  void SetStaticByteField(JClassPtr clazz, JFieldIDPtr fieldID, int val) =>
      ref.SetStaticByteField.asFunction<
              JThrowablePtr Function(JClassPtr clazz, JFieldIDPtr fieldID,
                  int val)>()(clazz, fieldID, val)
          .check();

  void SetStaticCharField(JClassPtr clazz, JFieldIDPtr fieldID, int val) =>
      ref.SetStaticCharField.asFunction<
              JThrowablePtr Function(JClassPtr clazz, JFieldIDPtr fieldID,
                  int val)>()(clazz, fieldID, val)
          .check();

  void SetStaticShortField(JClassPtr clazz, JFieldIDPtr fieldID, int val) =>
      ref.SetStaticShortField.asFunction<
              JThrowablePtr Function(JClassPtr clazz, JFieldIDPtr fieldID,
                  int val)>()(clazz, fieldID, val)
          .check();

  void SetStaticIntField(JClassPtr clazz, JFieldIDPtr fieldID, int val) =>
      ref.SetStaticIntField.asFunction<
              JThrowablePtr Function(JClassPtr clazz, JFieldIDPtr fieldID,
                  int val)>()(clazz, fieldID, val)
          .check();

  void SetStaticLongField(JClassPtr clazz, JFieldIDPtr fieldID, int val) =>
      ref.SetStaticLongField.asFunction<
              JThrowablePtr Function(JClassPtr clazz, JFieldIDPtr fieldID,
                  int val)>()(clazz, fieldID, val)
          .check();

  void SetStaticFloatField(JClassPtr clazz, JFieldIDPtr fieldID, double val) =>
      ref.SetStaticFloatField.asFunction<
              JThrowablePtr Function(JClassPtr clazz, JFieldIDPtr fieldID,
                  double val)>()(clazz, fieldID, val)
          .check();

  void SetStaticDoubleField(JClassPtr clazz, JFieldIDPtr fieldID, double val) =>
      ref.SetStaticDoubleField.asFunction<
              JThrowablePtr Function(JClassPtr clazz, JFieldIDPtr fieldID,
                  double val)>()(clazz, fieldID, val)
          .check();

  JStringPtr NewString(ffi.Pointer<JCharMarker> unicodeChars, int len) =>
      ref.NewString.asFunction<
              JniResult Function(ffi.Pointer<JCharMarker> unicodeChars,
                  int len)>()(unicodeChars, len)
          .object;

  int GetStringLength(JStringPtr string) =>
      ref.GetStringLength.asFunction<JniResult Function(JStringPtr string)>()(
              string)
          .integer;

  ffi.Pointer<JCharMarker> GetStringChars(
          JStringPtr string, ffi.Pointer<JBooleanMarker> isCopy) =>
      ref.GetStringChars.asFunction<
              JniPointerResult Function(JStringPtr string,
                  ffi.Pointer<JBooleanMarker> isCopy)>()(string, isCopy)
          .getPointer<JCharMarker>();

  void ReleaseStringChars(JStringPtr string, ffi.Pointer<JCharMarker> isCopy) =>
      ref.ReleaseStringChars.asFunction<
              JThrowablePtr Function(JStringPtr string,
                  ffi.Pointer<JCharMarker> isCopy)>()(string, isCopy)
          .check();

  JStringPtr NewStringUTF(ffi.Pointer<ffi.Char> bytes) => ref.NewStringUTF
          .asFunction<JniResult Function(ffi.Pointer<ffi.Char> bytes)>()(bytes)
      .object;

  int GetStringUTFLength(JStringPtr string) => ref.GetStringUTFLength
          .asFunction<JniResult Function(JStringPtr string)>()(string)
      .integer;

  ffi.Pointer<ffi.Char> GetStringUTFChars(
          JStringPtr string, ffi.Pointer<JBooleanMarker> isCopy) =>
      ref.GetStringUTFChars.asFunction<
              JniPointerResult Function(JStringPtr string,
                  ffi.Pointer<JBooleanMarker> isCopy)>()(string, isCopy)
          .getPointer<ffi.Char>();

  void ReleaseStringUTFChars(JStringPtr string, ffi.Pointer<ffi.Char> utf) =>
      ref.ReleaseStringUTFChars.asFunction<
              JThrowablePtr Function(
                  JStringPtr string, ffi.Pointer<ffi.Char> utf)>()(string, utf)
          .check();

  int GetArrayLength(JArrayPtr array) =>
      ref.GetArrayLength.asFunction<JniResult Function(JArrayPtr array)>()(
              array)
          .integer;

  JObjectArrayPtr NewObjectArray(
          int length, JClassPtr elementClass, JObjectPtr initialElement) =>
      ref.NewObjectArray.asFunction<
                  JniResult Function(int length, JClassPtr elementClass,
                      JObjectPtr initialElement)>()(
              length, elementClass, initialElement)
          .object;

  JObjectPtr GetObjectArrayElement(JObjectArrayPtr array, int index) =>
      ref.GetObjectArrayElement.asFunction<
              JniResult Function(
                  JObjectArrayPtr array, int index)>()(array, index)
          .object;

  void SetObjectArrayElement(
          JObjectArrayPtr array, int index, JObjectPtr val) =>
      ref.SetObjectArrayElement.asFunction<
              JThrowablePtr Function(JObjectArrayPtr array, int index,
                  JObjectPtr val)>()(array, index, val)
          .check();

  JBooleanArrayPtr NewBooleanArray(int length) =>
      ref.NewBooleanArray.asFunction<JniResult Function(int length)>()(length)
          .object;

  JByteArrayPtr NewByteArray(int length) =>
      ref.NewByteArray.asFunction<JniResult Function(int length)>()(length)
          .object;

  JCharArrayPtr NewCharArray(int length) =>
      ref.NewCharArray.asFunction<JniResult Function(int length)>()(length)
          .object;

  JShortArrayPtr NewShortArray(int length) =>
      ref.NewShortArray.asFunction<JniResult Function(int length)>()(length)
          .object;

  JIntArrayPtr NewIntArray(int length) =>
      ref.NewIntArray.asFunction<JniResult Function(int length)>()(length)
          .object;

  JLongArrayPtr NewLongArray(int length) =>
      ref.NewLongArray.asFunction<JniResult Function(int length)>()(length)
          .object;

  JFloatArrayPtr NewFloatArray(int length) =>
      ref.NewFloatArray.asFunction<JniResult Function(int length)>()(length)
          .object;

  JDoubleArrayPtr NewDoubleArray(int length) =>
      ref.NewDoubleArray.asFunction<JniResult Function(int length)>()(length)
          .object;

  ffi.Pointer<JBooleanMarker> GetBooleanArrayElements(
          JBooleanArrayPtr array, ffi.Pointer<JBooleanMarker> isCopy) =>
      ref.GetBooleanArrayElements.asFunction<
              JniPointerResult Function(JBooleanArrayPtr array,
                  ffi.Pointer<JBooleanMarker> isCopy)>()(array, isCopy)
          .getPointer<JBooleanMarker>();

  ffi.Pointer<JByteMarker> GetByteArrayElements(
          JByteArrayPtr array, ffi.Pointer<JBooleanMarker> isCopy) =>
      ref.GetByteArrayElements.asFunction<
              JniPointerResult Function(JByteArrayPtr array,
                  ffi.Pointer<JBooleanMarker> isCopy)>()(array, isCopy)
          .getPointer<JByteMarker>();

  ffi.Pointer<JCharMarker> GetCharArrayElements(
          JCharArrayPtr array, ffi.Pointer<JBooleanMarker> isCopy) =>
      ref.GetCharArrayElements.asFunction<
              JniPointerResult Function(JCharArrayPtr array,
                  ffi.Pointer<JBooleanMarker> isCopy)>()(array, isCopy)
          .getPointer<JCharMarker>();

  ffi.Pointer<JShortMarker> GetShortArrayElements(
          JShortArrayPtr array, ffi.Pointer<JBooleanMarker> isCopy) =>
      ref.GetShortArrayElements.asFunction<
              JniPointerResult Function(JShortArrayPtr array,
                  ffi.Pointer<JBooleanMarker> isCopy)>()(array, isCopy)
          .getPointer<JShortMarker>();

  ffi.Pointer<JIntMarker> GetIntArrayElements(
          JIntArrayPtr array, ffi.Pointer<JBooleanMarker> isCopy) =>
      ref.GetIntArrayElements.asFunction<
              JniPointerResult Function(JIntArrayPtr array,
                  ffi.Pointer<JBooleanMarker> isCopy)>()(array, isCopy)
          .getPointer<JIntMarker>();

  ffi.Pointer<JLongMarker> GetLongArrayElements(
          JLongArrayPtr array, ffi.Pointer<JBooleanMarker> isCopy) =>
      ref.GetLongArrayElements.asFunction<
              JniPointerResult Function(JLongArrayPtr array,
                  ffi.Pointer<JBooleanMarker> isCopy)>()(array, isCopy)
          .getPointer<JLongMarker>();

  ffi.Pointer<JFloatMarker> GetFloatArrayElements(
          JFloatArrayPtr array, ffi.Pointer<JBooleanMarker> isCopy) =>
      ref.GetFloatArrayElements.asFunction<
              JniPointerResult Function(JFloatArrayPtr array,
                  ffi.Pointer<JBooleanMarker> isCopy)>()(array, isCopy)
          .getPointer<JFloatMarker>();

  ffi.Pointer<JDoubleMarker> GetDoubleArrayElements(
          JDoubleArrayPtr array, ffi.Pointer<JBooleanMarker> isCopy) =>
      ref.GetDoubleArrayElements.asFunction<
              JniPointerResult Function(JDoubleArrayPtr array,
                  ffi.Pointer<JBooleanMarker> isCopy)>()(array, isCopy)
          .getPointer<JDoubleMarker>();

  void ReleaseBooleanArrayElements(JBooleanArrayPtr array,
          ffi.Pointer<JBooleanMarker> elems, int mode) =>
      ref.ReleaseBooleanArrayElements.asFunction<
              JThrowablePtr Function(
                  JBooleanArrayPtr array,
                  ffi.Pointer<JBooleanMarker> elems,
                  int mode)>()(array, elems, mode)
          .check();

  void ReleaseByteArrayElements(
          JByteArrayPtr array, ffi.Pointer<JByteMarker> elems, int mode) =>
      ref.ReleaseByteArrayElements.asFunction<
              JThrowablePtr Function(
                  JByteArrayPtr array,
                  ffi.Pointer<JByteMarker> elems,
                  int mode)>()(array, elems, mode)
          .check();

  void ReleaseCharArrayElements(
          JCharArrayPtr array, ffi.Pointer<JCharMarker> elems, int mode) =>
      ref.ReleaseCharArrayElements.asFunction<
              JThrowablePtr Function(
                  JCharArrayPtr array,
                  ffi.Pointer<JCharMarker> elems,
                  int mode)>()(array, elems, mode)
          .check();

  void ReleaseShortArrayElements(
          JShortArrayPtr array, ffi.Pointer<JShortMarker> elems, int mode) =>
      ref.ReleaseShortArrayElements.asFunction<
              JThrowablePtr Function(
                  JShortArrayPtr array,
                  ffi.Pointer<JShortMarker> elems,
                  int mode)>()(array, elems, mode)
          .check();

  void ReleaseIntArrayElements(
          JIntArrayPtr array, ffi.Pointer<JIntMarker> elems, int mode) =>
      ref.ReleaseIntArrayElements.asFunction<
              JThrowablePtr Function(
                  JIntArrayPtr array,
                  ffi.Pointer<JIntMarker> elems,
                  int mode)>()(array, elems, mode)
          .check();

  void ReleaseLongArrayElements(
          JLongArrayPtr array, ffi.Pointer<JLongMarker> elems, int mode) =>
      ref.ReleaseLongArrayElements.asFunction<
              JThrowablePtr Function(
                  JLongArrayPtr array,
                  ffi.Pointer<JLongMarker> elems,
                  int mode)>()(array, elems, mode)
          .check();

  void ReleaseFloatArrayElements(
          JFloatArrayPtr array, ffi.Pointer<JFloatMarker> elems, int mode) =>
      ref.ReleaseFloatArrayElements.asFunction<
              JThrowablePtr Function(
                  JFloatArrayPtr array,
                  ffi.Pointer<JFloatMarker> elems,
                  int mode)>()(array, elems, mode)
          .check();

  void ReleaseDoubleArrayElements(
          JDoubleArrayPtr array, ffi.Pointer<JDoubleMarker> elems, int mode) =>
      ref.ReleaseDoubleArrayElements.asFunction<
              JThrowablePtr Function(
                  JDoubleArrayPtr array,
                  ffi.Pointer<JDoubleMarker> elems,
                  int mode)>()(array, elems, mode)
          .check();

  void GetBooleanArrayRegion(JBooleanArrayPtr array, int start, int len,
          ffi.Pointer<JBooleanMarker> buf) =>
      ref.GetBooleanArrayRegion.asFunction<
              JThrowablePtr Function(JBooleanArrayPtr array, int start, int len,
                  ffi.Pointer<JBooleanMarker> buf)>()(array, start, len, buf)
          .check();

  void GetByteArrayRegion(JByteArrayPtr array, int start, int len,
          ffi.Pointer<JByteMarker> buf) =>
      ref.GetByteArrayRegion.asFunction<
              JThrowablePtr Function(JByteArrayPtr array, int start, int len,
                  ffi.Pointer<JByteMarker> buf)>()(array, start, len, buf)
          .check();

  void GetCharArrayRegion(JCharArrayPtr array, int start, int len,
          ffi.Pointer<JCharMarker> buf) =>
      ref.GetCharArrayRegion.asFunction<
              JThrowablePtr Function(JCharArrayPtr array, int start, int len,
                  ffi.Pointer<JCharMarker> buf)>()(array, start, len, buf)
          .check();

  void GetShortArrayRegion(JShortArrayPtr array, int start, int len,
          ffi.Pointer<JShortMarker> buf) =>
      ref.GetShortArrayRegion.asFunction<
              JThrowablePtr Function(JShortArrayPtr array, int start, int len,
                  ffi.Pointer<JShortMarker> buf)>()(array, start, len, buf)
          .check();

  void GetIntArrayRegion(JIntArrayPtr array, int start, int len,
          ffi.Pointer<JIntMarker> buf) =>
      ref.GetIntArrayRegion.asFunction<
              JThrowablePtr Function(JIntArrayPtr array, int start, int len,
                  ffi.Pointer<JIntMarker> buf)>()(array, start, len, buf)
          .check();

  void GetLongArrayRegion(JLongArrayPtr array, int start, int len,
          ffi.Pointer<JLongMarker> buf) =>
      ref.GetLongArrayRegion.asFunction<
              JThrowablePtr Function(JLongArrayPtr array, int start, int len,
                  ffi.Pointer<JLongMarker> buf)>()(array, start, len, buf)
          .check();

  void GetFloatArrayRegion(JFloatArrayPtr array, int start, int len,
          ffi.Pointer<JFloatMarker> buf) =>
      ref.GetFloatArrayRegion.asFunction<
              JThrowablePtr Function(JFloatArrayPtr array, int start, int len,
                  ffi.Pointer<JFloatMarker> buf)>()(array, start, len, buf)
          .check();

  void GetDoubleArrayRegion(JDoubleArrayPtr array, int start, int len,
          ffi.Pointer<JDoubleMarker> buf) =>
      ref.GetDoubleArrayRegion.asFunction<
              JThrowablePtr Function(JDoubleArrayPtr array, int start, int len,
                  ffi.Pointer<JDoubleMarker> buf)>()(array, start, len, buf)
          .check();

  void SetBooleanArrayRegion(JBooleanArrayPtr array, int start, int len,
          ffi.Pointer<JBooleanMarker> buf) =>
      ref.SetBooleanArrayRegion.asFunction<
              JThrowablePtr Function(JBooleanArrayPtr array, int start, int len,
                  ffi.Pointer<JBooleanMarker> buf)>()(array, start, len, buf)
          .check();

  void SetByteArrayRegion(JByteArrayPtr array, int start, int len,
          ffi.Pointer<JByteMarker> buf) =>
      ref.SetByteArrayRegion.asFunction<
              JThrowablePtr Function(JByteArrayPtr array, int start, int len,
                  ffi.Pointer<JByteMarker> buf)>()(array, start, len, buf)
          .check();

  void SetCharArrayRegion(JCharArrayPtr array, int start, int len,
          ffi.Pointer<JCharMarker> buf) =>
      ref.SetCharArrayRegion.asFunction<
              JThrowablePtr Function(JCharArrayPtr array, int start, int len,
                  ffi.Pointer<JCharMarker> buf)>()(array, start, len, buf)
          .check();

  void SetShortArrayRegion(JShortArrayPtr array, int start, int len,
          ffi.Pointer<JShortMarker> buf) =>
      ref.SetShortArrayRegion.asFunction<
              JThrowablePtr Function(JShortArrayPtr array, int start, int len,
                  ffi.Pointer<JShortMarker> buf)>()(array, start, len, buf)
          .check();

  void SetIntArrayRegion(JIntArrayPtr array, int start, int len,
          ffi.Pointer<JIntMarker> buf) =>
      ref.SetIntArrayRegion.asFunction<
              JThrowablePtr Function(JIntArrayPtr array, int start, int len,
                  ffi.Pointer<JIntMarker> buf)>()(array, start, len, buf)
          .check();

  void SetLongArrayRegion(JLongArrayPtr array, int start, int len,
          ffi.Pointer<JLongMarker> buf) =>
      ref.SetLongArrayRegion.asFunction<
              JThrowablePtr Function(JLongArrayPtr array, int start, int len,
                  ffi.Pointer<JLongMarker> buf)>()(array, start, len, buf)
          .check();

  void SetFloatArrayRegion(JFloatArrayPtr array, int start, int len,
          ffi.Pointer<JFloatMarker> buf) =>
      ref.SetFloatArrayRegion.asFunction<
              JThrowablePtr Function(JFloatArrayPtr array, int start, int len,
                  ffi.Pointer<JFloatMarker> buf)>()(array, start, len, buf)
          .check();

  void SetDoubleArrayRegion(JDoubleArrayPtr array, int start, int len,
          ffi.Pointer<JDoubleMarker> buf) =>
      ref.SetDoubleArrayRegion.asFunction<
              JThrowablePtr Function(JDoubleArrayPtr array, int start, int len,
                  ffi.Pointer<JDoubleMarker> buf)>()(array, start, len, buf)
          .check();

  int RegisterNatives(JClassPtr clazz, ffi.Pointer<JNINativeMethod> methods,
          int nMethods) =>
      ref.RegisterNatives.asFunction<
              JniResult Function(
                  JClassPtr clazz,
                  ffi.Pointer<JNINativeMethod> methods,
                  int nMethods)>()(clazz, methods, nMethods)
          .integer;

  int UnregisterNatives(JClassPtr clazz) =>
      ref.UnregisterNatives.asFunction<JniResult Function(JClassPtr clazz)>()(
              clazz)
          .integer;

  int MonitorEnter(JObjectPtr obj) =>
      ref.MonitorEnter.asFunction<JniResult Function(JObjectPtr obj)>()(obj)
          .integer;

  int MonitorExit(JObjectPtr obj) =>
      ref.MonitorExit.asFunction<JniResult Function(JObjectPtr obj)>()(obj)
          .integer;

  int GetJavaVM(ffi.Pointer<ffi.Pointer<JavaVM1>> vm) =>
      ref.GetJavaVM.asFunction<
              JniResult Function(ffi.Pointer<ffi.Pointer<JavaVM1>> vm)>()(vm)
          .integer;

  void GetStringRegion(
          JStringPtr str, int start, int len, ffi.Pointer<JCharMarker> buf) =>
      ref.GetStringRegion.asFunction<
              JThrowablePtr Function(JStringPtr str, int start, int len,
                  ffi.Pointer<JCharMarker> buf)>()(str, start, len, buf)
          .check();

  void GetStringUTFRegion(
          JStringPtr str, int start, int len, ffi.Pointer<ffi.Char> buf) =>
      ref.GetStringUTFRegion.asFunction<
              JThrowablePtr Function(JStringPtr str, int start, int len,
                  ffi.Pointer<ffi.Char> buf)>()(str, start, len, buf)
          .check();

  ffi.Pointer<ffi.Void> GetPrimitiveArrayCritical(
          JArrayPtr array, ffi.Pointer<JBooleanMarker> isCopy) =>
      ref.GetPrimitiveArrayCritical.asFunction<
              JniPointerResult Function(JArrayPtr array,
                  ffi.Pointer<JBooleanMarker> isCopy)>()(array, isCopy)
          .getPointer<ffi.Void>();

  void ReleasePrimitiveArrayCritical(
          JArrayPtr array, ffi.Pointer<ffi.Void> carray, int mode) =>
      ref.ReleasePrimitiveArrayCritical.asFunction<
              JThrowablePtr Function(
                  JArrayPtr array,
                  ffi.Pointer<ffi.Void> carray,
                  int mode)>()(array, carray, mode)
          .check();

  ffi.Pointer<JCharMarker> GetStringCritical(
          JStringPtr str, ffi.Pointer<JBooleanMarker> isCopy) =>
      ref.GetStringCritical.asFunction<
              JniPointerResult Function(JStringPtr str,
                  ffi.Pointer<JBooleanMarker> isCopy)>()(str, isCopy)
          .getPointer<JCharMarker>();

  void ReleaseStringCritical(JStringPtr str, ffi.Pointer<JCharMarker> carray) =>
      ref.ReleaseStringCritical.asFunction<
              JThrowablePtr Function(JStringPtr str,
                  ffi.Pointer<JCharMarker> carray)>()(str, carray)
          .check();

  JWeakPtr NewWeakGlobalRef(JObjectPtr obj) =>
      ref.NewWeakGlobalRef.asFunction<JniResult Function(JObjectPtr obj)>()(obj)
          .object;

  void DeleteWeakGlobalRef(JWeakPtr obj) => ref.DeleteWeakGlobalRef.asFunction<
          JThrowablePtr Function(JWeakPtr obj)>()(obj)
      .check();

  bool ExceptionCheck() =>
      ref.ExceptionCheck.asFunction<JniResult Function()>()().boolean;

  JObjectPtr NewDirectByteBuffer(ffi.Pointer<ffi.Void> address, int capacity) =>
      ref.NewDirectByteBuffer.asFunction<
              JniResult Function(ffi.Pointer<ffi.Void> address,
                  int capacity)>()(address, capacity)
          .object;

  ffi.Pointer<ffi.Void> GetDirectBufferAddress(JObjectPtr buf) =>
      ref.GetDirectBufferAddress.asFunction<
              JniPointerResult Function(JObjectPtr buf)>()(buf)
          .getPointer<ffi.Void>();

  int GetDirectBufferCapacity(JObjectPtr buf) => ref.GetDirectBufferCapacity
          .asFunction<JniResult Function(JObjectPtr buf)>()(buf)
      .long;

  int GetObjectRefType(JObjectPtr obj) =>
      ref.GetObjectRefType.asFunction<JniResult Function(JObjectPtr obj)>()(obj)
          .integer;
}

extension JniAccessorsExtension on ffi.Pointer<JniAccessors> {
  JniClassLookupResult getClass(ffi.Pointer<ffi.Char> internalName) =>
      ref.getClass.asFunction<
          JniClassLookupResult Function(
              ffi.Pointer<ffi.Char> internalName)>()(internalName);

  JniPointerResult getFieldID(JClassPtr cls, ffi.Pointer<ffi.Char> fieldName,
          ffi.Pointer<ffi.Char> signature) =>
      ref.getFieldID.asFunction<
          JniPointerResult Function(
              JClassPtr cls,
              ffi.Pointer<ffi.Char> fieldName,
              ffi.Pointer<ffi.Char> signature)>()(cls, fieldName, signature);

  JniPointerResult getStaticFieldID(JClassPtr cls,
          ffi.Pointer<ffi.Char> fieldName, ffi.Pointer<ffi.Char> signature) =>
      ref.getStaticFieldID.asFunction<
          JniPointerResult Function(
              JClassPtr cls,
              ffi.Pointer<ffi.Char> fieldName,
              ffi.Pointer<ffi.Char> signature)>()(cls, fieldName, signature);

  JniPointerResult getMethodID(JClassPtr cls, ffi.Pointer<ffi.Char> methodName,
          ffi.Pointer<ffi.Char> signature) =>
      ref.getMethodID.asFunction<
          JniPointerResult Function(
              JClassPtr cls,
              ffi.Pointer<ffi.Char> methodName,
              ffi.Pointer<ffi.Char> signature)>()(cls, methodName, signature);

  JniPointerResult getStaticMethodID(JClassPtr cls,
          ffi.Pointer<ffi.Char> methodName, ffi.Pointer<ffi.Char> signature) =>
      ref.getStaticMethodID.asFunction<
          JniPointerResult Function(
              JClassPtr cls,
              ffi.Pointer<ffi.Char> methodName,
              ffi.Pointer<ffi.Char> signature)>()(cls, methodName, signature);

  JniResult newObject(
          JClassPtr cls, JMethodIDPtr ctor, ffi.Pointer<JValue> args) =>
      ref.newObject.asFunction<
          JniResult Function(JClassPtr cls, JMethodIDPtr ctor,
              ffi.Pointer<JValue> args)>()(cls, ctor, args);

  JniPointerResult newPrimitiveArray(int length, int type) =>
      ref.newPrimitiveArray
              .asFunction<JniPointerResult Function(int length, int type)>()(
          length, type);

  JniPointerResult newObjectArray(
          int length, JClassPtr elementClass, JObjectPtr initialElement) =>
      ref.newObjectArray.asFunction<
              JniPointerResult Function(int length, JClassPtr elementClass,
                  JObjectPtr initialElement)>()(
          length, elementClass, initialElement);

  JniResult getArrayElement(JArrayPtr array, int index, int type) =>
      ref.getArrayElement.asFunction<
          JniResult Function(
              JArrayPtr array, int index, int type)>()(array, index, type);

  JniResult callMethod(JObjectPtr obj, JMethodIDPtr methodID, int callType,
          ffi.Pointer<JValue> args) =>
      ref.callMethod.asFunction<
          JniResult Function(
              JObjectPtr obj,
              JMethodIDPtr methodID,
              int callType,
              ffi.Pointer<JValue> args)>()(obj, methodID, callType, args);

  JniResult callStaticMethod(JClassPtr cls, JMethodIDPtr methodID, int callType,
          ffi.Pointer<JValue> args) =>
      ref.callStaticMethod.asFunction<
          JniResult Function(JClassPtr cls, JMethodIDPtr methodID, int callType,
              ffi.Pointer<JValue> args)>()(cls, methodID, callType, args);

  JniResult getField(JObjectPtr obj, JFieldIDPtr fieldID, int callType) =>
      ref.getField.asFunction<
          JniResult Function(JObjectPtr obj, JFieldIDPtr fieldID,
              int callType)>()(obj, fieldID, callType);

  JniResult getStaticField(JClassPtr cls, JFieldIDPtr fieldID, int callType) =>
      ref.getStaticField.asFunction<
          JniResult Function(JClassPtr cls, JFieldIDPtr fieldID,
              int callType)>()(cls, fieldID, callType);

  JniExceptionDetails getExceptionDetails(JThrowablePtr exception) => ref
          .getExceptionDetails
          .asFunction<JniExceptionDetails Function(JThrowablePtr exception)>()(
      exception);
}

extension JniEnvExtension on ffi.Pointer<JniEnv> {
  int GetVersion() => value.ref.GetVersion
      .asFunction<int Function(ffi.Pointer<JniEnv1> env)>()(this);

  JClassPtr DefineClass(ffi.Pointer<ffi.Char> name, JObjectPtr loader,
          ffi.Pointer<JByteMarker> buf, int bufLen) =>
      value.ref.DefineClass.asFunction<
          JClassPtr Function(
              ffi.Pointer<JniEnv1> env,
              ffi.Pointer<ffi.Char> name,
              JObjectPtr loader,
              ffi.Pointer<JByteMarker> buf,
              int bufLen)>()(this, name, loader, buf, bufLen);

  JClassPtr FindClass(ffi.Pointer<ffi.Char> name) => value.ref.FindClass
      .asFunction<
          JClassPtr Function(ffi.Pointer<JniEnv1> env,
              ffi.Pointer<ffi.Char> name)>()(this, name);

  JMethodIDPtr FromReflectedMethod(JObjectPtr method) =>
      value.ref.FromReflectedMethod.asFunction<
          JMethodIDPtr Function(
              ffi.Pointer<JniEnv1> env, JObjectPtr method)>()(this, method);

  JFieldIDPtr FromReflectedField(JObjectPtr field) =>
      value.ref.FromReflectedField.asFunction<
          JFieldIDPtr Function(
              ffi.Pointer<JniEnv1> env, JObjectPtr field)>()(this, field);

  JObjectPtr ToReflectedMethod(
          JClassPtr cls, JMethodIDPtr methodId, int isStatic) =>
      value.ref.ToReflectedMethod.asFunction<
          JObjectPtr Function(
              ffi.Pointer<JniEnv1> env,
              JClassPtr cls,
              JMethodIDPtr methodId,
              int isStatic)>()(this, cls, methodId, isStatic);

  JClassPtr GetSuperclass(JClassPtr clazz) =>
      value.ref.GetSuperclass.asFunction<
          JClassPtr Function(
              ffi.Pointer<JniEnv1> env, JClassPtr clazz)>()(this, clazz);

  int IsAssignableFrom(JClassPtr clazz1, JClassPtr clazz2) =>
      value.ref.IsAssignableFrom.asFunction<
          int Function(ffi.Pointer<JniEnv1> env, JClassPtr clazz1,
              JClassPtr clazz2)>()(this, clazz1, clazz2);

  JObjectPtr ToReflectedField(
          JClassPtr cls, JFieldIDPtr fieldID, int isStatic) =>
      value.ref.ToReflectedField.asFunction<
          JObjectPtr Function(
              ffi.Pointer<JniEnv1> env,
              JClassPtr cls,
              JFieldIDPtr fieldID,
              int isStatic)>()(this, cls, fieldID, isStatic);

  int Throw(JThrowablePtr obj) => value.ref.Throw.asFunction<
      int Function(ffi.Pointer<JniEnv1> env, JThrowablePtr obj)>()(this, obj);

  int ThrowNew(JClassPtr clazz, ffi.Pointer<ffi.Char> message) =>
      value.ref.ThrowNew.asFunction<
          int Function(ffi.Pointer<JniEnv1> env, JClassPtr clazz,
              ffi.Pointer<ffi.Char> message)>()(this, clazz, message);

  JThrowablePtr ExceptionOccurred() => value.ref.ExceptionOccurred
      .asFunction<JThrowablePtr Function(ffi.Pointer<JniEnv1> env)>()(this);

  void ExceptionDescribe() => value.ref.ExceptionDescribe
      .asFunction<void Function(ffi.Pointer<JniEnv1> env)>()(this);

  void ExceptionClear() => value.ref.ExceptionClear
      .asFunction<void Function(ffi.Pointer<JniEnv1> env)>()(this);

  void FatalError(ffi.Pointer<ffi.Char> msg) => value.ref.FatalError.asFunction<
      void Function(
          ffi.Pointer<JniEnv1> env, ffi.Pointer<ffi.Char> msg)>()(this, msg);

  int PushLocalFrame(int capacity) => value.ref.PushLocalFrame
          .asFunction<int Function(ffi.Pointer<JniEnv1> env, int capacity)>()(
      this, capacity);

  JObjectPtr PopLocalFrame(JObjectPtr result) => value.ref.PopLocalFrame
      .asFunction<
          JObjectPtr Function(
              ffi.Pointer<JniEnv1> env, JObjectPtr result)>()(this, result);

  JObjectPtr NewGlobalRef(JObjectPtr obj) => value.ref.NewGlobalRef.asFunction<
      JObjectPtr Function(
          ffi.Pointer<JniEnv1> env, JObjectPtr obj)>()(this, obj);

  void DeleteGlobalRef(JObjectPtr globalRef) =>
      value.ref.DeleteGlobalRef.asFunction<
              void Function(ffi.Pointer<JniEnv1> env, JObjectPtr globalRef)>()(
          this, globalRef);

  void DeleteLocalRef(JObjectPtr localRef) =>
      value.ref.DeleteLocalRef.asFunction<
          void Function(
              ffi.Pointer<JniEnv1> env, JObjectPtr localRef)>()(this, localRef);

  int IsSameObject(JObjectPtr ref1, JObjectPtr ref2) =>
      value.ref.IsSameObject.asFunction<
          int Function(ffi.Pointer<JniEnv1> env, JObjectPtr ref1,
              JObjectPtr ref2)>()(this, ref1, ref2);

  JObjectPtr NewLocalRef(JObjectPtr obj) => value.ref.NewLocalRef.asFunction<
      JObjectPtr Function(
          ffi.Pointer<JniEnv1> env, JObjectPtr obj)>()(this, obj);

  int EnsureLocalCapacity(int capacity) => value.ref.EnsureLocalCapacity
          .asFunction<int Function(ffi.Pointer<JniEnv1> env, int capacity)>()(
      this, capacity);

  JObjectPtr AllocObject(JClassPtr clazz) => value.ref.AllocObject.asFunction<
      JObjectPtr Function(
          ffi.Pointer<JniEnv1> env, JClassPtr clazz)>()(this, clazz);

  JObjectPtr NewObject(JClassPtr clazz, JMethodIDPtr methodID) =>
      value.ref.NewObject.asFunction<
          JObjectPtr Function(ffi.Pointer<JniEnv1> env, JClassPtr clazz,
              JMethodIDPtr methodID)>()(this, clazz, methodID);

  JObjectPtr NewObjectA(
          JClassPtr clazz, JMethodIDPtr methodID, ffi.Pointer<JValue> args) =>
      value.ref.NewObjectA.asFunction<
          JObjectPtr Function(
              ffi.Pointer<JniEnv1> env,
              JClassPtr clazz,
              JMethodIDPtr methodID,
              ffi.Pointer<JValue> args)>()(this, clazz, methodID, args);

  JClassPtr GetObjectClass(JObjectPtr obj) =>
      value.ref.GetObjectClass.asFunction<
          JClassPtr Function(
              ffi.Pointer<JniEnv1> env, JObjectPtr obj)>()(this, obj);

  int IsInstanceOf(JObjectPtr obj, JClassPtr clazz) =>
      value.ref.IsInstanceOf.asFunction<
          int Function(ffi.Pointer<JniEnv1> env, JObjectPtr obj,
              JClassPtr clazz)>()(this, obj, clazz);

  JMethodIDPtr GetMethodID(JClassPtr clazz, ffi.Pointer<ffi.Char> name,
          ffi.Pointer<ffi.Char> sig) =>
      value.ref.GetMethodID.asFunction<
          JMethodIDPtr Function(
              ffi.Pointer<JniEnv1> env,
              JClassPtr clazz,
              ffi.Pointer<ffi.Char> name,
              ffi.Pointer<ffi.Char> sig)>()(this, clazz, name, sig);

  JObjectPtr CallObjectMethod(JObjectPtr obj, JMethodIDPtr methodID) =>
      value.ref.CallObjectMethod.asFunction<
          JObjectPtr Function(ffi.Pointer<JniEnv1> env, JObjectPtr obj,
              JMethodIDPtr methodID)>()(this, obj, methodID);

  JObjectPtr CallObjectMethodA(
          JObjectPtr obj, JMethodIDPtr methodID, ffi.Pointer<JValue> args) =>
      value.ref.CallObjectMethodA.asFunction<
          JObjectPtr Function(
              ffi.Pointer<JniEnv1> env,
              JObjectPtr obj,
              JMethodIDPtr methodID,
              ffi.Pointer<JValue> args)>()(this, obj, methodID, args);

  int CallBooleanMethod(JObjectPtr obj, JMethodIDPtr methodID) =>
      value.ref.CallBooleanMethod.asFunction<
          int Function(ffi.Pointer<JniEnv1> env, JObjectPtr obj,
              JMethodIDPtr methodID)>()(this, obj, methodID);

  int CallBooleanMethodA(
          JObjectPtr obj, JMethodIDPtr methodId, ffi.Pointer<JValue> args) =>
      value.ref.CallBooleanMethodA.asFunction<
          int Function(
              ffi.Pointer<JniEnv1> env,
              JObjectPtr obj,
              JMethodIDPtr methodId,
              ffi.Pointer<JValue> args)>()(this, obj, methodId, args);

  int CallByteMethod(JObjectPtr obj, JMethodIDPtr methodID) =>
      value.ref.CallByteMethod.asFunction<
          int Function(ffi.Pointer<JniEnv1> env, JObjectPtr obj,
              JMethodIDPtr methodID)>()(this, obj, methodID);

  int CallByteMethodA(
          JObjectPtr obj, JMethodIDPtr methodID, ffi.Pointer<JValue> args) =>
      value.ref.CallByteMethodA.asFunction<
          int Function(
              ffi.Pointer<JniEnv1> env,
              JObjectPtr obj,
              JMethodIDPtr methodID,
              ffi.Pointer<JValue> args)>()(this, obj, methodID, args);

  int CallCharMethod(JObjectPtr obj, JMethodIDPtr methodID) =>
      value.ref.CallCharMethod.asFunction<
          int Function(ffi.Pointer<JniEnv1> env, JObjectPtr obj,
              JMethodIDPtr methodID)>()(this, obj, methodID);

  int CallCharMethodA(
          JObjectPtr obj, JMethodIDPtr methodID, ffi.Pointer<JValue> args) =>
      value.ref.CallCharMethodA.asFunction<
          int Function(
              ffi.Pointer<JniEnv1> env,
              JObjectPtr obj,
              JMethodIDPtr methodID,
              ffi.Pointer<JValue> args)>()(this, obj, methodID, args);

  int CallShortMethod(JObjectPtr obj, JMethodIDPtr methodID) =>
      value.ref.CallShortMethod.asFunction<
          int Function(ffi.Pointer<JniEnv1> env, JObjectPtr obj,
              JMethodIDPtr methodID)>()(this, obj, methodID);

  int CallShortMethodA(
          JObjectPtr obj, JMethodIDPtr methodID, ffi.Pointer<JValue> args) =>
      value.ref.CallShortMethodA.asFunction<
          int Function(
              ffi.Pointer<JniEnv1> env,
              JObjectPtr obj,
              JMethodIDPtr methodID,
              ffi.Pointer<JValue> args)>()(this, obj, methodID, args);

  int CallIntMethod(JObjectPtr obj, JMethodIDPtr methodID) =>
      value.ref.CallIntMethod.asFunction<
          int Function(ffi.Pointer<JniEnv1> env, JObjectPtr obj,
              JMethodIDPtr methodID)>()(this, obj, methodID);

  int CallIntMethodA(
          JObjectPtr obj, JMethodIDPtr methodID, ffi.Pointer<JValue> args) =>
      value.ref.CallIntMethodA.asFunction<
          int Function(
              ffi.Pointer<JniEnv1> env,
              JObjectPtr obj,
              JMethodIDPtr methodID,
              ffi.Pointer<JValue> args)>()(this, obj, methodID, args);

  int CallLongMethod(JObjectPtr obj, JMethodIDPtr methodID) =>
      value.ref.CallLongMethod.asFunction<
          int Function(ffi.Pointer<JniEnv1> env, JObjectPtr obj,
              JMethodIDPtr methodID)>()(this, obj, methodID);

  int CallLongMethodA(
          JObjectPtr obj, JMethodIDPtr methodID, ffi.Pointer<JValue> args) =>
      value.ref.CallLongMethodA.asFunction<
          int Function(
              ffi.Pointer<JniEnv1> env,
              JObjectPtr obj,
              JMethodIDPtr methodID,
              ffi.Pointer<JValue> args)>()(this, obj, methodID, args);

  double CallFloatMethod(JObjectPtr obj, JMethodIDPtr methodID) =>
      value.ref.CallFloatMethod.asFunction<
          double Function(ffi.Pointer<JniEnv1> env, JObjectPtr obj,
              JMethodIDPtr methodID)>()(this, obj, methodID);

  double CallFloatMethodA(
          JObjectPtr obj, JMethodIDPtr methodID, ffi.Pointer<JValue> args) =>
      value.ref.CallFloatMethodA.asFunction<
          double Function(
              ffi.Pointer<JniEnv1> env,
              JObjectPtr obj,
              JMethodIDPtr methodID,
              ffi.Pointer<JValue> args)>()(this, obj, methodID, args);

  double CallDoubleMethod(JObjectPtr obj, JMethodIDPtr methodID) =>
      value.ref.CallDoubleMethod.asFunction<
          double Function(ffi.Pointer<JniEnv1> env, JObjectPtr obj,
              JMethodIDPtr methodID)>()(this, obj, methodID);

  double CallDoubleMethodA(
          JObjectPtr obj, JMethodIDPtr methodID, ffi.Pointer<JValue> args) =>
      value.ref.CallDoubleMethodA.asFunction<
          double Function(
              ffi.Pointer<JniEnv1> env,
              JObjectPtr obj,
              JMethodIDPtr methodID,
              ffi.Pointer<JValue> args)>()(this, obj, methodID, args);

  void CallVoidMethod(JObjectPtr obj, JMethodIDPtr methodID) =>
      value.ref.CallVoidMethod.asFunction<
          void Function(ffi.Pointer<JniEnv1> env, JObjectPtr obj,
              JMethodIDPtr methodID)>()(this, obj, methodID);

  void CallVoidMethodA(
          JObjectPtr obj, JMethodIDPtr methodID, ffi.Pointer<JValue> args) =>
      value.ref.CallVoidMethodA.asFunction<
          void Function(
              ffi.Pointer<JniEnv1> env,
              JObjectPtr obj,
              JMethodIDPtr methodID,
              ffi.Pointer<JValue> args)>()(this, obj, methodID, args);

  JObjectPtr CallNonvirtualObjectMethod(
          JObjectPtr obj, JClassPtr clazz, JMethodIDPtr methodID) =>
      value.ref.CallNonvirtualObjectMethod.asFunction<
          JObjectPtr Function(
              ffi.Pointer<JniEnv1> env,
              JObjectPtr obj,
              JClassPtr clazz,
              JMethodIDPtr methodID)>()(this, obj, clazz, methodID);

  JObjectPtr CallNonvirtualObjectMethodA(JObjectPtr obj, JClassPtr clazz,
          JMethodIDPtr methodID, ffi.Pointer<JValue> args) =>
      value.ref.CallNonvirtualObjectMethodA.asFunction<
          JObjectPtr Function(
              ffi.Pointer<JniEnv1> env,
              JObjectPtr obj,
              JClassPtr clazz,
              JMethodIDPtr methodID,
              ffi.Pointer<JValue> args)>()(this, obj, clazz, methodID, args);

  int CallNonvirtualBooleanMethod(
          JObjectPtr obj, JClassPtr clazz, JMethodIDPtr methodID) =>
      value.ref.CallNonvirtualBooleanMethod.asFunction<
          int Function(
              ffi.Pointer<JniEnv1> env,
              JObjectPtr obj,
              JClassPtr clazz,
              JMethodIDPtr methodID)>()(this, obj, clazz, methodID);

  int CallNonvirtualBooleanMethodA(JObjectPtr obj, JClassPtr clazz,
          JMethodIDPtr methodID, ffi.Pointer<JValue> args) =>
      value.ref.CallNonvirtualBooleanMethodA.asFunction<
          int Function(
              ffi.Pointer<JniEnv1> env,
              JObjectPtr obj,
              JClassPtr clazz,
              JMethodIDPtr methodID,
              ffi.Pointer<JValue> args)>()(this, obj, clazz, methodID, args);

  int CallNonvirtualByteMethod(
          JObjectPtr obj, JClassPtr clazz, JMethodIDPtr methodID) =>
      value.ref.CallNonvirtualByteMethod.asFunction<
          int Function(
              ffi.Pointer<JniEnv1> env,
              JObjectPtr obj,
              JClassPtr clazz,
              JMethodIDPtr methodID)>()(this, obj, clazz, methodID);

  int CallNonvirtualByteMethodA(JObjectPtr obj, JClassPtr clazz,
          JMethodIDPtr methodID, ffi.Pointer<JValue> args) =>
      value.ref.CallNonvirtualByteMethodA.asFunction<
          int Function(
              ffi.Pointer<JniEnv1> env,
              JObjectPtr obj,
              JClassPtr clazz,
              JMethodIDPtr methodID,
              ffi.Pointer<JValue> args)>()(this, obj, clazz, methodID, args);

  int CallNonvirtualCharMethod(
          JObjectPtr obj, JClassPtr clazz, JMethodIDPtr methodID) =>
      value.ref.CallNonvirtualCharMethod.asFunction<
          int Function(
              ffi.Pointer<JniEnv1> env,
              JObjectPtr obj,
              JClassPtr clazz,
              JMethodIDPtr methodID)>()(this, obj, clazz, methodID);

  int CallNonvirtualCharMethodA(JObjectPtr obj, JClassPtr clazz,
          JMethodIDPtr methodID, ffi.Pointer<JValue> args) =>
      value.ref.CallNonvirtualCharMethodA.asFunction<
          int Function(
              ffi.Pointer<JniEnv1> env,
              JObjectPtr obj,
              JClassPtr clazz,
              JMethodIDPtr methodID,
              ffi.Pointer<JValue> args)>()(this, obj, clazz, methodID, args);

  int CallNonvirtualShortMethod(
          JObjectPtr obj, JClassPtr clazz, JMethodIDPtr methodID) =>
      value.ref.CallNonvirtualShortMethod.asFunction<
          int Function(
              ffi.Pointer<JniEnv1> env,
              JObjectPtr obj,
              JClassPtr clazz,
              JMethodIDPtr methodID)>()(this, obj, clazz, methodID);

  int CallNonvirtualShortMethodA(JObjectPtr obj, JClassPtr clazz,
          JMethodIDPtr methodID, ffi.Pointer<JValue> args) =>
      value.ref.CallNonvirtualShortMethodA.asFunction<
          int Function(
              ffi.Pointer<JniEnv1> env,
              JObjectPtr obj,
              JClassPtr clazz,
              JMethodIDPtr methodID,
              ffi.Pointer<JValue> args)>()(this, obj, clazz, methodID, args);

  int CallNonvirtualIntMethod(
          JObjectPtr obj, JClassPtr clazz, JMethodIDPtr methodID) =>
      value.ref.CallNonvirtualIntMethod.asFunction<
          int Function(
              ffi.Pointer<JniEnv1> env,
              JObjectPtr obj,
              JClassPtr clazz,
              JMethodIDPtr methodID)>()(this, obj, clazz, methodID);

  int CallNonvirtualIntMethodA(JObjectPtr obj, JClassPtr clazz,
          JMethodIDPtr methodID, ffi.Pointer<JValue> args) =>
      value.ref.CallNonvirtualIntMethodA.asFunction<
          int Function(
              ffi.Pointer<JniEnv1> env,
              JObjectPtr obj,
              JClassPtr clazz,
              JMethodIDPtr methodID,
              ffi.Pointer<JValue> args)>()(this, obj, clazz, methodID, args);

  int CallNonvirtualLongMethod(
          JObjectPtr obj, JClassPtr clazz, JMethodIDPtr methodID) =>
      value.ref.CallNonvirtualLongMethod.asFunction<
          int Function(
              ffi.Pointer<JniEnv1> env,
              JObjectPtr obj,
              JClassPtr clazz,
              JMethodIDPtr methodID)>()(this, obj, clazz, methodID);

  int CallNonvirtualLongMethodA(JObjectPtr obj, JClassPtr clazz,
          JMethodIDPtr methodID, ffi.Pointer<JValue> args) =>
      value.ref.CallNonvirtualLongMethodA.asFunction<
          int Function(
              ffi.Pointer<JniEnv1> env,
              JObjectPtr obj,
              JClassPtr clazz,
              JMethodIDPtr methodID,
              ffi.Pointer<JValue> args)>()(this, obj, clazz, methodID, args);

  double CallNonvirtualFloatMethod(
          JObjectPtr obj, JClassPtr clazz, JMethodIDPtr methodID) =>
      value.ref.CallNonvirtualFloatMethod.asFunction<
          double Function(
              ffi.Pointer<JniEnv1> env,
              JObjectPtr obj,
              JClassPtr clazz,
              JMethodIDPtr methodID)>()(this, obj, clazz, methodID);

  double CallNonvirtualFloatMethodA(JObjectPtr obj, JClassPtr clazz,
          JMethodIDPtr methodID, ffi.Pointer<JValue> args) =>
      value.ref.CallNonvirtualFloatMethodA.asFunction<
          double Function(
              ffi.Pointer<JniEnv1> env,
              JObjectPtr obj,
              JClassPtr clazz,
              JMethodIDPtr methodID,
              ffi.Pointer<JValue> args)>()(this, obj, clazz, methodID, args);

  double CallNonvirtualDoubleMethod(
          JObjectPtr obj, JClassPtr clazz, JMethodIDPtr methodID) =>
      value.ref.CallNonvirtualDoubleMethod.asFunction<
          double Function(
              ffi.Pointer<JniEnv1> env,
              JObjectPtr obj,
              JClassPtr clazz,
              JMethodIDPtr methodID)>()(this, obj, clazz, methodID);

  double CallNonvirtualDoubleMethodA(JObjectPtr obj, JClassPtr clazz,
          JMethodIDPtr methodID, ffi.Pointer<JValue> args) =>
      value.ref.CallNonvirtualDoubleMethodA.asFunction<
          double Function(
              ffi.Pointer<JniEnv1> env,
              JObjectPtr obj,
              JClassPtr clazz,
              JMethodIDPtr methodID,
              ffi.Pointer<JValue> args)>()(this, obj, clazz, methodID, args);

  void CallNonvirtualVoidMethod(
          JObjectPtr obj, JClassPtr clazz, JMethodIDPtr methodID) =>
      value.ref.CallNonvirtualVoidMethod.asFunction<
          void Function(
              ffi.Pointer<JniEnv1> env,
              JObjectPtr obj,
              JClassPtr clazz,
              JMethodIDPtr methodID)>()(this, obj, clazz, methodID);

  void CallNonvirtualVoidMethodA(JObjectPtr obj, JClassPtr clazz,
          JMethodIDPtr methodID, ffi.Pointer<JValue> args) =>
      value.ref.CallNonvirtualVoidMethodA.asFunction<
          void Function(
              ffi.Pointer<JniEnv1> env,
              JObjectPtr obj,
              JClassPtr clazz,
              JMethodIDPtr methodID,
              ffi.Pointer<JValue> args)>()(this, obj, clazz, methodID, args);

  JFieldIDPtr GetFieldID(JClassPtr clazz, ffi.Pointer<ffi.Char> name,
          ffi.Pointer<ffi.Char> sig) =>
      value.ref.GetFieldID.asFunction<
          JFieldIDPtr Function(
              ffi.Pointer<JniEnv1> env,
              JClassPtr clazz,
              ffi.Pointer<ffi.Char> name,
              ffi.Pointer<ffi.Char> sig)>()(this, clazz, name, sig);

  JObjectPtr GetObjectField(JObjectPtr obj, JFieldIDPtr fieldID) =>
      value.ref.GetObjectField.asFunction<
          JObjectPtr Function(ffi.Pointer<JniEnv1> env, JObjectPtr obj,
              JFieldIDPtr fieldID)>()(this, obj, fieldID);

  int GetBooleanField(JObjectPtr obj, JFieldIDPtr fieldID) =>
      value.ref.GetBooleanField.asFunction<
          int Function(ffi.Pointer<JniEnv1> env, JObjectPtr obj,
              JFieldIDPtr fieldID)>()(this, obj, fieldID);

  int GetByteField(JObjectPtr obj, JFieldIDPtr fieldID) =>
      value.ref.GetByteField.asFunction<
          int Function(ffi.Pointer<JniEnv1> env, JObjectPtr obj,
              JFieldIDPtr fieldID)>()(this, obj, fieldID);

  int GetCharField(JObjectPtr obj, JFieldIDPtr fieldID) =>
      value.ref.GetCharField.asFunction<
          int Function(ffi.Pointer<JniEnv1> env, JObjectPtr obj,
              JFieldIDPtr fieldID)>()(this, obj, fieldID);

  int GetShortField(JObjectPtr obj, JFieldIDPtr fieldID) =>
      value.ref.GetShortField.asFunction<
          int Function(ffi.Pointer<JniEnv1> env, JObjectPtr obj,
              JFieldIDPtr fieldID)>()(this, obj, fieldID);

  int GetIntField(JObjectPtr obj, JFieldIDPtr fieldID) =>
      value.ref.GetIntField.asFunction<
          int Function(ffi.Pointer<JniEnv1> env, JObjectPtr obj,
              JFieldIDPtr fieldID)>()(this, obj, fieldID);

  int GetLongField(JObjectPtr obj, JFieldIDPtr fieldID) =>
      value.ref.GetLongField.asFunction<
          int Function(ffi.Pointer<JniEnv1> env, JObjectPtr obj,
              JFieldIDPtr fieldID)>()(this, obj, fieldID);

  double GetFloatField(JObjectPtr obj, JFieldIDPtr fieldID) =>
      value.ref.GetFloatField.asFunction<
          double Function(ffi.Pointer<JniEnv1> env, JObjectPtr obj,
              JFieldIDPtr fieldID)>()(this, obj, fieldID);

  double GetDoubleField(JObjectPtr obj, JFieldIDPtr fieldID) =>
      value.ref.GetDoubleField.asFunction<
          double Function(ffi.Pointer<JniEnv1> env, JObjectPtr obj,
              JFieldIDPtr fieldID)>()(this, obj, fieldID);

  void SetObjectField(JObjectPtr obj, JFieldIDPtr fieldID, JObjectPtr val) =>
      value.ref.SetObjectField.asFunction<
          void Function(ffi.Pointer<JniEnv1> env, JObjectPtr obj,
              JFieldIDPtr fieldID, JObjectPtr val)>()(this, obj, fieldID, val);

  void SetBooleanField(JObjectPtr obj, JFieldIDPtr fieldID, int val) =>
      value.ref.SetBooleanField.asFunction<
          void Function(ffi.Pointer<JniEnv1> env, JObjectPtr obj,
              JFieldIDPtr fieldID, int val)>()(this, obj, fieldID, val);

  void SetByteField(JObjectPtr obj, JFieldIDPtr fieldID, int val) =>
      value.ref.SetByteField.asFunction<
          void Function(ffi.Pointer<JniEnv1> env, JObjectPtr obj,
              JFieldIDPtr fieldID, int val)>()(this, obj, fieldID, val);

  void SetCharField(JObjectPtr obj, JFieldIDPtr fieldID, int val) =>
      value.ref.SetCharField.asFunction<
          void Function(ffi.Pointer<JniEnv1> env, JObjectPtr obj,
              JFieldIDPtr fieldID, int val)>()(this, obj, fieldID, val);

  void SetShortField(JObjectPtr obj, JFieldIDPtr fieldID, int val) =>
      value.ref.SetShortField.asFunction<
          void Function(ffi.Pointer<JniEnv1> env, JObjectPtr obj,
              JFieldIDPtr fieldID, int val)>()(this, obj, fieldID, val);

  void SetIntField(JObjectPtr obj, JFieldIDPtr fieldID, int val) =>
      value.ref.SetIntField.asFunction<
          void Function(ffi.Pointer<JniEnv1> env, JObjectPtr obj,
              JFieldIDPtr fieldID, int val)>()(this, obj, fieldID, val);

  void SetLongField(JObjectPtr obj, JFieldIDPtr fieldID, int val) =>
      value.ref.SetLongField.asFunction<
          void Function(ffi.Pointer<JniEnv1> env, JObjectPtr obj,
              JFieldIDPtr fieldID, int val)>()(this, obj, fieldID, val);

  void SetFloatField(JObjectPtr obj, JFieldIDPtr fieldID, double val) =>
      value.ref.SetFloatField.asFunction<
          void Function(ffi.Pointer<JniEnv1> env, JObjectPtr obj,
              JFieldIDPtr fieldID, double val)>()(this, obj, fieldID, val);

  void SetDoubleField(JObjectPtr obj, JFieldIDPtr fieldID, double val) =>
      value.ref.SetDoubleField.asFunction<
          void Function(ffi.Pointer<JniEnv1> env, JObjectPtr obj,
              JFieldIDPtr fieldID, double val)>()(this, obj, fieldID, val);

  JMethodIDPtr GetStaticMethodID(JClassPtr clazz, ffi.Pointer<ffi.Char> name,
          ffi.Pointer<ffi.Char> sig) =>
      value.ref.GetStaticMethodID.asFunction<
          JMethodIDPtr Function(
              ffi.Pointer<JniEnv1> env,
              JClassPtr clazz,
              ffi.Pointer<ffi.Char> name,
              ffi.Pointer<ffi.Char> sig)>()(this, clazz, name, sig);

  JObjectPtr CallStaticObjectMethod(JClassPtr clazz, JMethodIDPtr methodID) =>
      value.ref.CallStaticObjectMethod.asFunction<
          JObjectPtr Function(ffi.Pointer<JniEnv1> env, JClassPtr clazz,
              JMethodIDPtr methodID)>()(this, clazz, methodID);

  JObjectPtr CallStaticObjectMethodA(
          JClassPtr clazz, JMethodIDPtr methodID, ffi.Pointer<JValue> args) =>
      value.ref.CallStaticObjectMethodA.asFunction<
          JObjectPtr Function(
              ffi.Pointer<JniEnv1> env,
              JClassPtr clazz,
              JMethodIDPtr methodID,
              ffi.Pointer<JValue> args)>()(this, clazz, methodID, args);

  int CallStaticBooleanMethod(JClassPtr clazz, JMethodIDPtr methodID) =>
      value.ref.CallStaticBooleanMethod.asFunction<
          int Function(ffi.Pointer<JniEnv1> env, JClassPtr clazz,
              JMethodIDPtr methodID)>()(this, clazz, methodID);

  int CallStaticBooleanMethodA(
          JClassPtr clazz, JMethodIDPtr methodID, ffi.Pointer<JValue> args) =>
      value.ref.CallStaticBooleanMethodA.asFunction<
          int Function(
              ffi.Pointer<JniEnv1> env,
              JClassPtr clazz,
              JMethodIDPtr methodID,
              ffi.Pointer<JValue> args)>()(this, clazz, methodID, args);

  int CallStaticByteMethod(JClassPtr clazz, JMethodIDPtr methodID) =>
      value.ref.CallStaticByteMethod.asFunction<
          int Function(ffi.Pointer<JniEnv1> env, JClassPtr clazz,
              JMethodIDPtr methodID)>()(this, clazz, methodID);

  int CallStaticByteMethodA(
          JClassPtr clazz, JMethodIDPtr methodID, ffi.Pointer<JValue> args) =>
      value.ref.CallStaticByteMethodA.asFunction<
          int Function(
              ffi.Pointer<JniEnv1> env,
              JClassPtr clazz,
              JMethodIDPtr methodID,
              ffi.Pointer<JValue> args)>()(this, clazz, methodID, args);

  int CallStaticCharMethod(JClassPtr clazz, JMethodIDPtr methodID) =>
      value.ref.CallStaticCharMethod.asFunction<
          int Function(ffi.Pointer<JniEnv1> env, JClassPtr clazz,
              JMethodIDPtr methodID)>()(this, clazz, methodID);

  int CallStaticCharMethodA(
          JClassPtr clazz, JMethodIDPtr methodID, ffi.Pointer<JValue> args) =>
      value.ref.CallStaticCharMethodA.asFunction<
          int Function(
              ffi.Pointer<JniEnv1> env,
              JClassPtr clazz,
              JMethodIDPtr methodID,
              ffi.Pointer<JValue> args)>()(this, clazz, methodID, args);

  int CallStaticShortMethod(JClassPtr clazz, JMethodIDPtr methodID) =>
      value.ref.CallStaticShortMethod.asFunction<
          int Function(ffi.Pointer<JniEnv1> env, JClassPtr clazz,
              JMethodIDPtr methodID)>()(this, clazz, methodID);

  int CallStaticShortMethodA(
          JClassPtr clazz, JMethodIDPtr methodID, ffi.Pointer<JValue> args) =>
      value.ref.CallStaticShortMethodA.asFunction<
          int Function(
              ffi.Pointer<JniEnv1> env,
              JClassPtr clazz,
              JMethodIDPtr methodID,
              ffi.Pointer<JValue> args)>()(this, clazz, methodID, args);

  int CallStaticIntMethod(JClassPtr clazz, JMethodIDPtr methodID) =>
      value.ref.CallStaticIntMethod.asFunction<
          int Function(ffi.Pointer<JniEnv1> env, JClassPtr clazz,
              JMethodIDPtr methodID)>()(this, clazz, methodID);

  int CallStaticIntMethodA(
          JClassPtr clazz, JMethodIDPtr methodID, ffi.Pointer<JValue> args) =>
      value.ref.CallStaticIntMethodA.asFunction<
          int Function(
              ffi.Pointer<JniEnv1> env,
              JClassPtr clazz,
              JMethodIDPtr methodID,
              ffi.Pointer<JValue> args)>()(this, clazz, methodID, args);

  int CallStaticLongMethod(JClassPtr clazz, JMethodIDPtr methodID) =>
      value.ref.CallStaticLongMethod.asFunction<
          int Function(ffi.Pointer<JniEnv1> env, JClassPtr clazz,
              JMethodIDPtr methodID)>()(this, clazz, methodID);

  int CallStaticLongMethodA(
          JClassPtr clazz, JMethodIDPtr methodID, ffi.Pointer<JValue> args) =>
      value.ref.CallStaticLongMethodA.asFunction<
          int Function(
              ffi.Pointer<JniEnv1> env,
              JClassPtr clazz,
              JMethodIDPtr methodID,
              ffi.Pointer<JValue> args)>()(this, clazz, methodID, args);

  double CallStaticFloatMethod(JClassPtr clazz, JMethodIDPtr methodID) =>
      value.ref.CallStaticFloatMethod.asFunction<
          double Function(ffi.Pointer<JniEnv1> env, JClassPtr clazz,
              JMethodIDPtr methodID)>()(this, clazz, methodID);

  double CallStaticFloatMethodA(
          JClassPtr clazz, JMethodIDPtr methodID, ffi.Pointer<JValue> args) =>
      value.ref.CallStaticFloatMethodA.asFunction<
          double Function(
              ffi.Pointer<JniEnv1> env,
              JClassPtr clazz,
              JMethodIDPtr methodID,
              ffi.Pointer<JValue> args)>()(this, clazz, methodID, args);

  double CallStaticDoubleMethod(JClassPtr clazz, JMethodIDPtr methodID) =>
      value.ref.CallStaticDoubleMethod.asFunction<
          double Function(ffi.Pointer<JniEnv1> env, JClassPtr clazz,
              JMethodIDPtr methodID)>()(this, clazz, methodID);

  double CallStaticDoubleMethodA(
          JClassPtr clazz, JMethodIDPtr methodID, ffi.Pointer<JValue> args) =>
      value.ref.CallStaticDoubleMethodA.asFunction<
          double Function(
              ffi.Pointer<JniEnv1> env,
              JClassPtr clazz,
              JMethodIDPtr methodID,
              ffi.Pointer<JValue> args)>()(this, clazz, methodID, args);

  void CallStaticVoidMethod(JClassPtr clazz, JMethodIDPtr methodID) =>
      value.ref.CallStaticVoidMethod.asFunction<
          void Function(ffi.Pointer<JniEnv1> env, JClassPtr clazz,
              JMethodIDPtr methodID)>()(this, clazz, methodID);

  void CallStaticVoidMethodA(
          JClassPtr clazz, JMethodIDPtr methodID, ffi.Pointer<JValue> args) =>
      value.ref.CallStaticVoidMethodA.asFunction<
          void Function(
              ffi.Pointer<JniEnv1> env,
              JClassPtr clazz,
              JMethodIDPtr methodID,
              ffi.Pointer<JValue> args)>()(this, clazz, methodID, args);

  JFieldIDPtr GetStaticFieldID(JClassPtr clazz, ffi.Pointer<ffi.Char> name,
          ffi.Pointer<ffi.Char> sig) =>
      value.ref.GetStaticFieldID.asFunction<
          JFieldIDPtr Function(
              ffi.Pointer<JniEnv1> env,
              JClassPtr clazz,
              ffi.Pointer<ffi.Char> name,
              ffi.Pointer<ffi.Char> sig)>()(this, clazz, name, sig);

  JObjectPtr GetStaticObjectField(JClassPtr clazz, JFieldIDPtr fieldID) =>
      value.ref.GetStaticObjectField.asFunction<
          JObjectPtr Function(ffi.Pointer<JniEnv1> env, JClassPtr clazz,
              JFieldIDPtr fieldID)>()(this, clazz, fieldID);

  int GetStaticBooleanField(JClassPtr clazz, JFieldIDPtr fieldID) =>
      value.ref.GetStaticBooleanField.asFunction<
          int Function(ffi.Pointer<JniEnv1> env, JClassPtr clazz,
              JFieldIDPtr fieldID)>()(this, clazz, fieldID);

  int GetStaticByteField(JClassPtr clazz, JFieldIDPtr fieldID) =>
      value.ref.GetStaticByteField.asFunction<
          int Function(ffi.Pointer<JniEnv1> env, JClassPtr clazz,
              JFieldIDPtr fieldID)>()(this, clazz, fieldID);

  int GetStaticCharField(JClassPtr clazz, JFieldIDPtr fieldID) =>
      value.ref.GetStaticCharField.asFunction<
          int Function(ffi.Pointer<JniEnv1> env, JClassPtr clazz,
              JFieldIDPtr fieldID)>()(this, clazz, fieldID);

  int GetStaticShortField(JClassPtr clazz, JFieldIDPtr fieldID) =>
      value.ref.GetStaticShortField.asFunction<
          int Function(ffi.Pointer<JniEnv1> env, JClassPtr clazz,
              JFieldIDPtr fieldID)>()(this, clazz, fieldID);

  int GetStaticIntField(JClassPtr clazz, JFieldIDPtr fieldID) =>
      value.ref.GetStaticIntField.asFunction<
          int Function(ffi.Pointer<JniEnv1> env, JClassPtr clazz,
              JFieldIDPtr fieldID)>()(this, clazz, fieldID);

  int GetStaticLongField(JClassPtr clazz, JFieldIDPtr fieldID) =>
      value.ref.GetStaticLongField.asFunction<
          int Function(ffi.Pointer<JniEnv1> env, JClassPtr clazz,
              JFieldIDPtr fieldID)>()(this, clazz, fieldID);

  double GetStaticFloatField(JClassPtr clazz, JFieldIDPtr fieldID) =>
      value.ref.GetStaticFloatField.asFunction<
          double Function(ffi.Pointer<JniEnv1> env, JClassPtr clazz,
              JFieldIDPtr fieldID)>()(this, clazz, fieldID);

  double GetStaticDoubleField(JClassPtr clazz, JFieldIDPtr fieldID) =>
      value.ref.GetStaticDoubleField.asFunction<
          double Function(ffi.Pointer<JniEnv1> env, JClassPtr clazz,
              JFieldIDPtr fieldID)>()(this, clazz, fieldID);

  void SetStaticObjectField(
          JClassPtr clazz, JFieldIDPtr fieldID, JObjectPtr val) =>
      value.ref.SetStaticObjectField.asFunction<
          void Function(
              ffi.Pointer<JniEnv1> env,
              JClassPtr clazz,
              JFieldIDPtr fieldID,
              JObjectPtr val)>()(this, clazz, fieldID, val);

  void SetStaticBooleanField(JClassPtr clazz, JFieldIDPtr fieldID, int val) =>
      value.ref.SetStaticBooleanField.asFunction<
          void Function(ffi.Pointer<JniEnv1> env, JClassPtr clazz,
              JFieldIDPtr fieldID, int val)>()(this, clazz, fieldID, val);

  void SetStaticByteField(JClassPtr clazz, JFieldIDPtr fieldID, int val) =>
      value.ref.SetStaticByteField.asFunction<
          void Function(ffi.Pointer<JniEnv1> env, JClassPtr clazz,
              JFieldIDPtr fieldID, int val)>()(this, clazz, fieldID, val);

  void SetStaticCharField(JClassPtr clazz, JFieldIDPtr fieldID, int val) =>
      value.ref.SetStaticCharField.asFunction<
          void Function(ffi.Pointer<JniEnv1> env, JClassPtr clazz,
              JFieldIDPtr fieldID, int val)>()(this, clazz, fieldID, val);

  void SetStaticShortField(JClassPtr clazz, JFieldIDPtr fieldID, int val) =>
      value.ref.SetStaticShortField.asFunction<
          void Function(ffi.Pointer<JniEnv1> env, JClassPtr clazz,
              JFieldIDPtr fieldID, int val)>()(this, clazz, fieldID, val);

  void SetStaticIntField(JClassPtr clazz, JFieldIDPtr fieldID, int val) =>
      value.ref.SetStaticIntField.asFunction<
          void Function(ffi.Pointer<JniEnv1> env, JClassPtr clazz,
              JFieldIDPtr fieldID, int val)>()(this, clazz, fieldID, val);

  void SetStaticLongField(JClassPtr clazz, JFieldIDPtr fieldID, int val) =>
      value.ref.SetStaticLongField.asFunction<
          void Function(ffi.Pointer<JniEnv1> env, JClassPtr clazz,
              JFieldIDPtr fieldID, int val)>()(this, clazz, fieldID, val);

  void SetStaticFloatField(JClassPtr clazz, JFieldIDPtr fieldID, double val) =>
      value.ref.SetStaticFloatField.asFunction<
          void Function(ffi.Pointer<JniEnv1> env, JClassPtr clazz,
              JFieldIDPtr fieldID, double val)>()(this, clazz, fieldID, val);

  void SetStaticDoubleField(JClassPtr clazz, JFieldIDPtr fieldID, double val) =>
      value.ref.SetStaticDoubleField.asFunction<
          void Function(ffi.Pointer<JniEnv1> env, JClassPtr clazz,
              JFieldIDPtr fieldID, double val)>()(this, clazz, fieldID, val);

  JStringPtr NewString(ffi.Pointer<JCharMarker> unicodeChars, int len) =>
      value.ref.NewString.asFunction<
          JStringPtr Function(
              ffi.Pointer<JniEnv1> env,
              ffi.Pointer<JCharMarker> unicodeChars,
              int len)>()(this, unicodeChars, len);

  int GetStringLength(JStringPtr string) =>
      value.ref.GetStringLength.asFunction<
          int Function(
              ffi.Pointer<JniEnv1> env, JStringPtr string)>()(this, string);

  ffi.Pointer<JCharMarker> GetStringChars(
          JStringPtr string, ffi.Pointer<JBooleanMarker> isCopy) =>
      value.ref.GetStringChars.asFunction<
          ffi.Pointer<JCharMarker> Function(
              ffi.Pointer<JniEnv1> env,
              JStringPtr string,
              ffi.Pointer<JBooleanMarker> isCopy)>()(this, string, isCopy);

  void ReleaseStringChars(JStringPtr string, ffi.Pointer<JCharMarker> isCopy) =>
      value.ref.ReleaseStringChars.asFunction<
          void Function(ffi.Pointer<JniEnv1> env, JStringPtr string,
              ffi.Pointer<JCharMarker> isCopy)>()(this, string, isCopy);

  JStringPtr NewStringUTF(ffi.Pointer<ffi.Char> bytes) =>
      value.ref.NewStringUTF.asFunction<
          JStringPtr Function(ffi.Pointer<JniEnv1> env,
              ffi.Pointer<ffi.Char> bytes)>()(this, bytes);

  int GetStringUTFLength(JStringPtr string) =>
      value.ref.GetStringUTFLength.asFunction<
          int Function(
              ffi.Pointer<JniEnv1> env, JStringPtr string)>()(this, string);

  ffi.Pointer<ffi.Char> GetStringUTFChars(
          JStringPtr string, ffi.Pointer<JBooleanMarker> isCopy) =>
      value.ref.GetStringUTFChars.asFunction<
          ffi.Pointer<ffi.Char> Function(
              ffi.Pointer<JniEnv1> env,
              JStringPtr string,
              ffi.Pointer<JBooleanMarker> isCopy)>()(this, string, isCopy);

  void ReleaseStringUTFChars(JStringPtr string, ffi.Pointer<ffi.Char> utf) =>
      value.ref.ReleaseStringUTFChars.asFunction<
          void Function(ffi.Pointer<JniEnv1> env, JStringPtr string,
              ffi.Pointer<ffi.Char> utf)>()(this, string, utf);

  int GetArrayLength(JArrayPtr array) => value.ref.GetArrayLength.asFunction<
      int Function(ffi.Pointer<JniEnv1> env, JArrayPtr array)>()(this, array);

  JObjectArrayPtr NewObjectArray(
          int length, JClassPtr elementClass, JObjectPtr initialElement) =>
      value.ref.NewObjectArray.asFunction<
              JObjectArrayPtr Function(ffi.Pointer<JniEnv1> env, int length,
                  JClassPtr elementClass, JObjectPtr initialElement)>()(
          this, length, elementClass, initialElement);

  JObjectPtr GetObjectArrayElement(JObjectArrayPtr array, int index) =>
      value.ref.GetObjectArrayElement.asFunction<
          JObjectPtr Function(ffi.Pointer<JniEnv1> env, JObjectArrayPtr array,
              int index)>()(this, array, index);

  void SetObjectArrayElement(
          JObjectArrayPtr array, int index, JObjectPtr val) =>
      value.ref.SetObjectArrayElement.asFunction<
          void Function(ffi.Pointer<JniEnv1> env, JObjectArrayPtr array,
              int index, JObjectPtr val)>()(this, array, index, val);

  JBooleanArrayPtr NewBooleanArray(int length) =>
      value.ref.NewBooleanArray.asFunction<
          JBooleanArrayPtr Function(
              ffi.Pointer<JniEnv1> env, int length)>()(this, length);

  JByteArrayPtr NewByteArray(int length) => value.ref.NewByteArray.asFunction<
      JByteArrayPtr Function(
          ffi.Pointer<JniEnv1> env, int length)>()(this, length);

  JCharArrayPtr NewCharArray(int length) => value.ref.NewCharArray.asFunction<
      JCharArrayPtr Function(
          ffi.Pointer<JniEnv1> env, int length)>()(this, length);

  JShortArrayPtr NewShortArray(int length) =>
      value.ref.NewShortArray.asFunction<
          JShortArrayPtr Function(
              ffi.Pointer<JniEnv1> env, int length)>()(this, length);

  JIntArrayPtr NewIntArray(int length) => value.ref.NewIntArray.asFunction<
      JIntArrayPtr Function(
          ffi.Pointer<JniEnv1> env, int length)>()(this, length);

  JLongArrayPtr NewLongArray(int length) => value.ref.NewLongArray.asFunction<
      JLongArrayPtr Function(
          ffi.Pointer<JniEnv1> env, int length)>()(this, length);

  JFloatArrayPtr NewFloatArray(int length) =>
      value.ref.NewFloatArray.asFunction<
          JFloatArrayPtr Function(
              ffi.Pointer<JniEnv1> env, int length)>()(this, length);

  JDoubleArrayPtr NewDoubleArray(int length) => value.ref.NewDoubleArray
      .asFunction<
          JDoubleArrayPtr Function(
              ffi.Pointer<JniEnv1> env, int length)>()(this, length);

  ffi.Pointer<JBooleanMarker> GetBooleanArrayElements(
          JBooleanArrayPtr array, ffi.Pointer<JBooleanMarker> isCopy) =>
      value.ref.GetBooleanArrayElements.asFunction<
          ffi.Pointer<JBooleanMarker> Function(
              ffi.Pointer<JniEnv1> env,
              JBooleanArrayPtr array,
              ffi.Pointer<JBooleanMarker> isCopy)>()(this, array, isCopy);

  ffi.Pointer<JByteMarker> GetByteArrayElements(
          JByteArrayPtr array, ffi.Pointer<JBooleanMarker> isCopy) =>
      value.ref.GetByteArrayElements.asFunction<
          ffi.Pointer<JByteMarker> Function(
              ffi.Pointer<JniEnv1> env,
              JByteArrayPtr array,
              ffi.Pointer<JBooleanMarker> isCopy)>()(this, array, isCopy);

  ffi.Pointer<JCharMarker> GetCharArrayElements(
          JCharArrayPtr array, ffi.Pointer<JBooleanMarker> isCopy) =>
      value.ref.GetCharArrayElements.asFunction<
          ffi.Pointer<JCharMarker> Function(
              ffi.Pointer<JniEnv1> env,
              JCharArrayPtr array,
              ffi.Pointer<JBooleanMarker> isCopy)>()(this, array, isCopy);

  ffi.Pointer<JShortMarker> GetShortArrayElements(
          JShortArrayPtr array, ffi.Pointer<JBooleanMarker> isCopy) =>
      value.ref.GetShortArrayElements.asFunction<
          ffi.Pointer<JShortMarker> Function(
              ffi.Pointer<JniEnv1> env,
              JShortArrayPtr array,
              ffi.Pointer<JBooleanMarker> isCopy)>()(this, array, isCopy);

  ffi.Pointer<JIntMarker> GetIntArrayElements(
          JIntArrayPtr array, ffi.Pointer<JBooleanMarker> isCopy) =>
      value.ref.GetIntArrayElements.asFunction<
          ffi.Pointer<JIntMarker> Function(
              ffi.Pointer<JniEnv1> env,
              JIntArrayPtr array,
              ffi.Pointer<JBooleanMarker> isCopy)>()(this, array, isCopy);

  ffi.Pointer<JLongMarker> GetLongArrayElements(
          JLongArrayPtr array, ffi.Pointer<JBooleanMarker> isCopy) =>
      value.ref.GetLongArrayElements.asFunction<
          ffi.Pointer<JLongMarker> Function(
              ffi.Pointer<JniEnv1> env,
              JLongArrayPtr array,
              ffi.Pointer<JBooleanMarker> isCopy)>()(this, array, isCopy);

  ffi.Pointer<JFloatMarker> GetFloatArrayElements(
          JFloatArrayPtr array, ffi.Pointer<JBooleanMarker> isCopy) =>
      value.ref.GetFloatArrayElements.asFunction<
          ffi.Pointer<JFloatMarker> Function(
              ffi.Pointer<JniEnv1> env,
              JFloatArrayPtr array,
              ffi.Pointer<JBooleanMarker> isCopy)>()(this, array, isCopy);

  ffi.Pointer<JDoubleMarker> GetDoubleArrayElements(
          JDoubleArrayPtr array, ffi.Pointer<JBooleanMarker> isCopy) =>
      value.ref.GetDoubleArrayElements.asFunction<
          ffi.Pointer<JDoubleMarker> Function(
              ffi.Pointer<JniEnv1> env,
              JDoubleArrayPtr array,
              ffi.Pointer<JBooleanMarker> isCopy)>()(this, array, isCopy);

  void ReleaseBooleanArrayElements(JBooleanArrayPtr array,
          ffi.Pointer<JBooleanMarker> elems, int mode) =>
      value.ref.ReleaseBooleanArrayElements.asFunction<
          void Function(
              ffi.Pointer<JniEnv1> env,
              JBooleanArrayPtr array,
              ffi.Pointer<JBooleanMarker> elems,
              int mode)>()(this, array, elems, mode);

  void ReleaseByteArrayElements(
          JByteArrayPtr array, ffi.Pointer<JByteMarker> elems, int mode) =>
      value.ref.ReleaseByteArrayElements.asFunction<
          void Function(
              ffi.Pointer<JniEnv1> env,
              JByteArrayPtr array,
              ffi.Pointer<JByteMarker> elems,
              int mode)>()(this, array, elems, mode);

  void ReleaseCharArrayElements(
          JCharArrayPtr array, ffi.Pointer<JCharMarker> elems, int mode) =>
      value.ref.ReleaseCharArrayElements.asFunction<
          void Function(
              ffi.Pointer<JniEnv1> env,
              JCharArrayPtr array,
              ffi.Pointer<JCharMarker> elems,
              int mode)>()(this, array, elems, mode);

  void ReleaseShortArrayElements(
          JShortArrayPtr array, ffi.Pointer<JShortMarker> elems, int mode) =>
      value.ref.ReleaseShortArrayElements.asFunction<
          void Function(
              ffi.Pointer<JniEnv1> env,
              JShortArrayPtr array,
              ffi.Pointer<JShortMarker> elems,
              int mode)>()(this, array, elems, mode);

  void ReleaseIntArrayElements(
          JIntArrayPtr array, ffi.Pointer<JIntMarker> elems, int mode) =>
      value.ref.ReleaseIntArrayElements.asFunction<
          void Function(
              ffi.Pointer<JniEnv1> env,
              JIntArrayPtr array,
              ffi.Pointer<JIntMarker> elems,
              int mode)>()(this, array, elems, mode);

  void ReleaseLongArrayElements(
          JLongArrayPtr array, ffi.Pointer<JLongMarker> elems, int mode) =>
      value.ref.ReleaseLongArrayElements.asFunction<
          void Function(
              ffi.Pointer<JniEnv1> env,
              JLongArrayPtr array,
              ffi.Pointer<JLongMarker> elems,
              int mode)>()(this, array, elems, mode);

  void ReleaseFloatArrayElements(
          JFloatArrayPtr array, ffi.Pointer<JFloatMarker> elems, int mode) =>
      value.ref.ReleaseFloatArrayElements.asFunction<
          void Function(
              ffi.Pointer<JniEnv1> env,
              JFloatArrayPtr array,
              ffi.Pointer<JFloatMarker> elems,
              int mode)>()(this, array, elems, mode);

  void ReleaseDoubleArrayElements(
          JDoubleArrayPtr array, ffi.Pointer<JDoubleMarker> elems, int mode) =>
      value.ref.ReleaseDoubleArrayElements.asFunction<
          void Function(
              ffi.Pointer<JniEnv1> env,
              JDoubleArrayPtr array,
              ffi.Pointer<JDoubleMarker> elems,
              int mode)>()(this, array, elems, mode);

  void GetBooleanArrayRegion(JBooleanArrayPtr array, int start, int len,
          ffi.Pointer<JBooleanMarker> buf) =>
      value.ref.GetBooleanArrayRegion.asFunction<
          void Function(
              ffi.Pointer<JniEnv1> env,
              JBooleanArrayPtr array,
              int start,
              int len,
              ffi.Pointer<JBooleanMarker> buf)>()(this, array, start, len, buf);

  void GetByteArrayRegion(JByteArrayPtr array, int start, int len,
          ffi.Pointer<JByteMarker> buf) =>
      value.ref.GetByteArrayRegion.asFunction<
          void Function(
              ffi.Pointer<JniEnv1> env,
              JByteArrayPtr array,
              int start,
              int len,
              ffi.Pointer<JByteMarker> buf)>()(this, array, start, len, buf);

  void GetCharArrayRegion(JCharArrayPtr array, int start, int len,
          ffi.Pointer<JCharMarker> buf) =>
      value.ref.GetCharArrayRegion.asFunction<
          void Function(
              ffi.Pointer<JniEnv1> env,
              JCharArrayPtr array,
              int start,
              int len,
              ffi.Pointer<JCharMarker> buf)>()(this, array, start, len, buf);

  void GetShortArrayRegion(JShortArrayPtr array, int start, int len,
          ffi.Pointer<JShortMarker> buf) =>
      value.ref.GetShortArrayRegion.asFunction<
          void Function(
              ffi.Pointer<JniEnv1> env,
              JShortArrayPtr array,
              int start,
              int len,
              ffi.Pointer<JShortMarker> buf)>()(this, array, start, len, buf);

  void GetIntArrayRegion(JIntArrayPtr array, int start, int len,
          ffi.Pointer<JIntMarker> buf) =>
      value.ref.GetIntArrayRegion.asFunction<
          void Function(
              ffi.Pointer<JniEnv1> env,
              JIntArrayPtr array,
              int start,
              int len,
              ffi.Pointer<JIntMarker> buf)>()(this, array, start, len, buf);

  void GetLongArrayRegion(JLongArrayPtr array, int start, int len,
          ffi.Pointer<JLongMarker> buf) =>
      value.ref.GetLongArrayRegion.asFunction<
          void Function(
              ffi.Pointer<JniEnv1> env,
              JLongArrayPtr array,
              int start,
              int len,
              ffi.Pointer<JLongMarker> buf)>()(this, array, start, len, buf);

  void GetFloatArrayRegion(JFloatArrayPtr array, int start, int len,
          ffi.Pointer<JFloatMarker> buf) =>
      value.ref.GetFloatArrayRegion.asFunction<
          void Function(
              ffi.Pointer<JniEnv1> env,
              JFloatArrayPtr array,
              int start,
              int len,
              ffi.Pointer<JFloatMarker> buf)>()(this, array, start, len, buf);

  void GetDoubleArrayRegion(JDoubleArrayPtr array, int start, int len,
          ffi.Pointer<JDoubleMarker> buf) =>
      value.ref.GetDoubleArrayRegion.asFunction<
          void Function(
              ffi.Pointer<JniEnv1> env,
              JDoubleArrayPtr array,
              int start,
              int len,
              ffi.Pointer<JDoubleMarker> buf)>()(this, array, start, len, buf);

  void SetBooleanArrayRegion(JBooleanArrayPtr array, int start, int len,
          ffi.Pointer<JBooleanMarker> buf) =>
      value.ref.SetBooleanArrayRegion.asFunction<
          void Function(
              ffi.Pointer<JniEnv1> env,
              JBooleanArrayPtr array,
              int start,
              int len,
              ffi.Pointer<JBooleanMarker> buf)>()(this, array, start, len, buf);

  void SetByteArrayRegion(JByteArrayPtr array, int start, int len,
          ffi.Pointer<JByteMarker> buf) =>
      value.ref.SetByteArrayRegion.asFunction<
          void Function(
              ffi.Pointer<JniEnv1> env,
              JByteArrayPtr array,
              int start,
              int len,
              ffi.Pointer<JByteMarker> buf)>()(this, array, start, len, buf);

  void SetCharArrayRegion(JCharArrayPtr array, int start, int len,
          ffi.Pointer<JCharMarker> buf) =>
      value.ref.SetCharArrayRegion.asFunction<
          void Function(
              ffi.Pointer<JniEnv1> env,
              JCharArrayPtr array,
              int start,
              int len,
              ffi.Pointer<JCharMarker> buf)>()(this, array, start, len, buf);

  void SetShortArrayRegion(JShortArrayPtr array, int start, int len,
          ffi.Pointer<JShortMarker> buf) =>
      value.ref.SetShortArrayRegion.asFunction<
          void Function(
              ffi.Pointer<JniEnv1> env,
              JShortArrayPtr array,
              int start,
              int len,
              ffi.Pointer<JShortMarker> buf)>()(this, array, start, len, buf);

  void SetIntArrayRegion(JIntArrayPtr array, int start, int len,
          ffi.Pointer<JIntMarker> buf) =>
      value.ref.SetIntArrayRegion.asFunction<
          void Function(
              ffi.Pointer<JniEnv1> env,
              JIntArrayPtr array,
              int start,
              int len,
              ffi.Pointer<JIntMarker> buf)>()(this, array, start, len, buf);

  void SetLongArrayRegion(JLongArrayPtr array, int start, int len,
          ffi.Pointer<JLongMarker> buf) =>
      value.ref.SetLongArrayRegion.asFunction<
          void Function(
              ffi.Pointer<JniEnv1> env,
              JLongArrayPtr array,
              int start,
              int len,
              ffi.Pointer<JLongMarker> buf)>()(this, array, start, len, buf);

  void SetFloatArrayRegion(JFloatArrayPtr array, int start, int len,
          ffi.Pointer<JFloatMarker> buf) =>
      value.ref.SetFloatArrayRegion.asFunction<
          void Function(
              ffi.Pointer<JniEnv1> env,
              JFloatArrayPtr array,
              int start,
              int len,
              ffi.Pointer<JFloatMarker> buf)>()(this, array, start, len, buf);

  void SetDoubleArrayRegion(JDoubleArrayPtr array, int start, int len,
          ffi.Pointer<JDoubleMarker> buf) =>
      value.ref.SetDoubleArrayRegion.asFunction<
          void Function(
              ffi.Pointer<JniEnv1> env,
              JDoubleArrayPtr array,
              int start,
              int len,
              ffi.Pointer<JDoubleMarker> buf)>()(this, array, start, len, buf);

  int RegisterNatives(JClassPtr clazz, ffi.Pointer<JNINativeMethod> methods,
          int nMethods) =>
      value.ref.RegisterNatives.asFunction<
          int Function(
              ffi.Pointer<JniEnv1> env,
              JClassPtr clazz,
              ffi.Pointer<JNINativeMethod> methods,
              int nMethods)>()(this, clazz, methods, nMethods);

  int UnregisterNatives(JClassPtr clazz) =>
      value.ref.UnregisterNatives.asFunction<
          int Function(
              ffi.Pointer<JniEnv1> env, JClassPtr clazz)>()(this, clazz);

  int MonitorEnter(JObjectPtr obj) => value.ref.MonitorEnter
          .asFunction<int Function(ffi.Pointer<JniEnv1> env, JObjectPtr obj)>()(
      this, obj);

  int MonitorExit(JObjectPtr obj) => value.ref.MonitorExit
          .asFunction<int Function(ffi.Pointer<JniEnv1> env, JObjectPtr obj)>()(
      this, obj);

  int GetJavaVM(ffi.Pointer<ffi.Pointer<JavaVM1>> vm) =>
      value.ref.GetJavaVM.asFunction<
          int Function(ffi.Pointer<JniEnv1> env,
              ffi.Pointer<ffi.Pointer<JavaVM1>> vm)>()(this, vm);

  void GetStringRegion(
          JStringPtr str, int start, int len, ffi.Pointer<JCharMarker> buf) =>
      value.ref.GetStringRegion.asFunction<
          void Function(
              ffi.Pointer<JniEnv1> env,
              JStringPtr str,
              int start,
              int len,
              ffi.Pointer<JCharMarker> buf)>()(this, str, start, len, buf);

  void GetStringUTFRegion(
          JStringPtr str, int start, int len, ffi.Pointer<ffi.Char> buf) =>
      value.ref.GetStringUTFRegion.asFunction<
          void Function(
              ffi.Pointer<JniEnv1> env,
              JStringPtr str,
              int start,
              int len,
              ffi.Pointer<ffi.Char> buf)>()(this, str, start, len, buf);

  ffi.Pointer<ffi.Void> GetPrimitiveArrayCritical(
          JArrayPtr array, ffi.Pointer<JBooleanMarker> isCopy) =>
      value.ref.GetPrimitiveArrayCritical.asFunction<
          ffi.Pointer<ffi.Void> Function(
              ffi.Pointer<JniEnv1> env,
              JArrayPtr array,
              ffi.Pointer<JBooleanMarker> isCopy)>()(this, array, isCopy);

  void ReleasePrimitiveArrayCritical(
          JArrayPtr array, ffi.Pointer<ffi.Void> carray, int mode) =>
      value.ref.ReleasePrimitiveArrayCritical.asFunction<
          void Function(
              ffi.Pointer<JniEnv1> env,
              JArrayPtr array,
              ffi.Pointer<ffi.Void> carray,
              int mode)>()(this, array, carray, mode);

  ffi.Pointer<JCharMarker> GetStringCritical(
          JStringPtr str, ffi.Pointer<JBooleanMarker> isCopy) =>
      value.ref.GetStringCritical.asFunction<
          ffi.Pointer<JCharMarker> Function(
              ffi.Pointer<JniEnv1> env,
              JStringPtr str,
              ffi.Pointer<JBooleanMarker> isCopy)>()(this, str, isCopy);

  void ReleaseStringCritical(JStringPtr str, ffi.Pointer<JCharMarker> carray) =>
      value.ref.ReleaseStringCritical.asFunction<
          void Function(ffi.Pointer<JniEnv1> env, JStringPtr str,
              ffi.Pointer<JCharMarker> carray)>()(this, str, carray);

  JWeakPtr NewWeakGlobalRef(JObjectPtr obj) =>
      value.ref.NewWeakGlobalRef.asFunction<
          JWeakPtr Function(
              ffi.Pointer<JniEnv1> env, JObjectPtr obj)>()(this, obj);

  void DeleteWeakGlobalRef(JWeakPtr obj) => value.ref.DeleteWeakGlobalRef
          .asFunction<void Function(ffi.Pointer<JniEnv1> env, JWeakPtr obj)>()(
      this, obj);

  int ExceptionCheck() => value.ref.ExceptionCheck
      .asFunction<int Function(ffi.Pointer<JniEnv1> env)>()(this);

  JObjectPtr NewDirectByteBuffer(ffi.Pointer<ffi.Void> address, int capacity) =>
      value.ref.NewDirectByteBuffer.asFunction<
          JObjectPtr Function(
              ffi.Pointer<JniEnv1> env,
              ffi.Pointer<ffi.Void> address,
              int capacity)>()(this, address, capacity);

  ffi.Pointer<ffi.Void> GetDirectBufferAddress(JObjectPtr buf) =>
      value.ref.GetDirectBufferAddress.asFunction<
          ffi.Pointer<ffi.Void> Function(
              ffi.Pointer<JniEnv1> env, JObjectPtr buf)>()(this, buf);

  int GetDirectBufferCapacity(JObjectPtr buf) => value
          .ref.GetDirectBufferCapacity
          .asFunction<int Function(ffi.Pointer<JniEnv1> env, JObjectPtr buf)>()(
      this, buf);

  int GetObjectRefType(JObjectPtr obj) => value.ref.GetObjectRefType
          .asFunction<int Function(ffi.Pointer<JniEnv1> env, JObjectPtr obj)>()(
      this, obj);
}

extension JavaVMExtension on ffi.Pointer<JavaVM> {
  int DestroyJavaVM() => value.ref.DestroyJavaVM
      .asFunction<int Function(ffi.Pointer<JavaVM1> vm)>()(this);

  int AttachCurrentThread(ffi.Pointer<ffi.Pointer<JniEnv>> p_env,
          ffi.Pointer<ffi.Void> thr_args) =>
      value.ref.AttachCurrentThread.asFunction<
          int Function(
              ffi.Pointer<JavaVM1> vm,
              ffi.Pointer<ffi.Pointer<JniEnv>> p_env,
              ffi.Pointer<ffi.Void> thr_args)>()(this, p_env, thr_args);

  int DetachCurrentThread() => value.ref.DetachCurrentThread
      .asFunction<int Function(ffi.Pointer<JavaVM1> vm)>()(this);

  int GetEnv(ffi.Pointer<ffi.Pointer<ffi.Void>> p_env, int version) =>
      value.ref.GetEnv.asFunction<
          int Function(
              ffi.Pointer<JavaVM1> vm,
              ffi.Pointer<ffi.Pointer<ffi.Void>> p_env,
              int version)>()(this, p_env, version);

  int AttachCurrentThreadAsDaemon(ffi.Pointer<ffi.Pointer<JniEnv>> p_env,
          ffi.Pointer<ffi.Void> thr_args) =>
      value.ref.AttachCurrentThreadAsDaemon.asFunction<
          int Function(
              ffi.Pointer<JavaVM1> vm,
              ffi.Pointer<ffi.Pointer<JniEnv>> p_env,
              ffi.Pointer<ffi.Void> thr_args)>()(this, p_env, thr_args);
}
