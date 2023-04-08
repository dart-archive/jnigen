#include <stdint.h>
#include "../dartjni.h"

typedef struct GlobalJniEnv {
  void* reserved0;
  void* reserved1;
  void* reserved2;
  void* reserved3;
  JniResult (*GetVersion)();
  JniClassLookupResult (*DefineClass)(char* name,
                                      jobject loader,
                                      jbyte* buf,
                                      jsize bufLen);
  JniClassLookupResult (*FindClass)(char* name);
  JniPointerResult (*FromReflectedMethod)(jobject method);
  JniPointerResult (*FromReflectedField)(jobject field);
  JniResult (*ToReflectedMethod)(jclass cls,
                                 jmethodID methodId,
                                 jboolean isStatic);
  JniClassLookupResult (*GetSuperclass)(jclass clazz);
  JniResult (*IsAssignableFrom)(jclass clazz1, jclass clazz2);
  JniResult (*ToReflectedField)(jclass cls,
                                jfieldID fieldID,
                                jboolean isStatic);
  JniResult (*Throw)(jthrowable obj);
  JniResult (*ThrowNew)(jclass clazz, char* message);
  JniResult (*ExceptionOccurred)();
  jthrowable (*ExceptionDescribe)();
  jthrowable (*ExceptionClear)();
  jthrowable (*FatalError)(char* msg);
  JniResult (*PushLocalFrame)(jint capacity);
  JniResult (*PopLocalFrame)(jobject result);
  JniResult (*NewGlobalRef)(jobject obj);
  jthrowable (*DeleteGlobalRef)(jobject globalRef);
  jthrowable (*DeleteLocalRef)(jobject localRef);
  JniResult (*IsSameObject)(jobject ref1, jobject ref2);
  JniResult (*NewLocalRef)(jobject obj);
  JniResult (*EnsureLocalCapacity)(jint capacity);
  JniResult (*AllocObject)(jclass clazz);
  JniResult (*NewObject)(jclass, jmethodID);
  JniResult (*NewObjectV)(jclass, jmethodID, va_list);
  JniResult (*NewObjectA)(jclass clazz, jmethodID methodID, jvalue* args);
  JniClassLookupResult (*GetObjectClass)(jobject obj);
  JniResult (*IsInstanceOf)(jobject obj, jclass clazz);
  JniPointerResult (*GetMethodID)(jclass clazz, char* name, char* sig);
  JniResult (*CallObjectMethod)(jobject, jmethodID);
  JniResult (*CallObjectMethodV)(jobject, jmethodID, va_list);
  JniResult (*CallObjectMethodA)(jobject obj, jmethodID methodID, jvalue* args);
  JniResult (*CallBooleanMethod)(jobject, jmethodID);
  JniResult (*CallBooleanMethodV)(jobject, jmethodID, va_list);
  JniResult (*CallBooleanMethodA)(jobject obj,
                                  jmethodID methodId,
                                  jvalue* args);
  JniResult (*CallByteMethod)(jobject, jmethodID);
  JniResult (*CallByteMethodV)(jobject, jmethodID, va_list);
  JniResult (*CallByteMethodA)(jobject obj, jmethodID methodID, jvalue* args);
  JniResult (*CallCharMethod)(jobject, jmethodID);
  JniResult (*CallCharMethodV)(jobject, jmethodID, va_list);
  JniResult (*CallCharMethodA)(jobject obj, jmethodID methodID, jvalue* args);
  JniResult (*CallShortMethod)(jobject, jmethodID);
  JniResult (*CallShortMethodV)(jobject, jmethodID, va_list);
  JniResult (*CallShortMethodA)(jobject obj, jmethodID methodID, jvalue* args);
  JniResult (*CallIntMethod)(jobject, jmethodID);
  JniResult (*CallIntMethodV)(jobject, jmethodID, va_list);
  JniResult (*CallIntMethodA)(jobject obj, jmethodID methodID, jvalue* args);
  JniResult (*CallLongMethod)(jobject, jmethodID);
  JniResult (*CallLongMethodV)(jobject, jmethodID, va_list);
  JniResult (*CallLongMethodA)(jobject obj, jmethodID methodID, jvalue* args);
  JniResult (*CallFloatMethod)(jobject, jmethodID);
  JniResult (*CallFloatMethodV)(jobject, jmethodID, va_list);
  JniResult (*CallFloatMethodA)(jobject obj, jmethodID methodID, jvalue* args);
  JniResult (*CallDoubleMethod)(jobject, jmethodID);
  JniResult (*CallDoubleMethodV)(jobject, jmethodID, va_list);
  JniResult (*CallDoubleMethodA)(jobject obj, jmethodID methodID, jvalue* args);
  jthrowable (*CallVoidMethod)(jobject, jmethodID);
  jthrowable (*CallVoidMethodV)(jobject, jmethodID, va_list);
  jthrowable (*CallVoidMethodA)(jobject obj, jmethodID methodID, jvalue* args);
  JniResult (*CallNonvirtualObjectMethod)(jobject, jclass, jmethodID);
  JniResult (*CallNonvirtualObjectMethodV)(jobject, jclass, jmethodID, va_list);
  JniResult (*CallNonvirtualObjectMethodA)(jobject obj,
                                           jclass clazz,
                                           jmethodID methodID,
                                           jvalue* args);
  JniResult (*CallNonvirtualBooleanMethod)(jobject, jclass, jmethodID);
  JniResult (*CallNonvirtualBooleanMethodV)(jobject,
                                            jclass,
                                            jmethodID,
                                            va_list);
  JniResult (*CallNonvirtualBooleanMethodA)(jobject obj,
                                            jclass clazz,
                                            jmethodID methodID,
                                            jvalue* args);
  JniResult (*CallNonvirtualByteMethod)(jobject, jclass, jmethodID);
  JniResult (*CallNonvirtualByteMethodV)(jobject, jclass, jmethodID, va_list);
  JniResult (*CallNonvirtualByteMethodA)(jobject obj,
                                         jclass clazz,
                                         jmethodID methodID,
                                         jvalue* args);
  JniResult (*CallNonvirtualCharMethod)(jobject, jclass, jmethodID);
  JniResult (*CallNonvirtualCharMethodV)(jobject, jclass, jmethodID, va_list);
  JniResult (*CallNonvirtualCharMethodA)(jobject obj,
                                         jclass clazz,
                                         jmethodID methodID,
                                         jvalue* args);
  JniResult (*CallNonvirtualShortMethod)(jobject, jclass, jmethodID);
  JniResult (*CallNonvirtualShortMethodV)(jobject, jclass, jmethodID, va_list);
  JniResult (*CallNonvirtualShortMethodA)(jobject obj,
                                          jclass clazz,
                                          jmethodID methodID,
                                          jvalue* args);
  JniResult (*CallNonvirtualIntMethod)(jobject, jclass, jmethodID);
  JniResult (*CallNonvirtualIntMethodV)(jobject, jclass, jmethodID, va_list);
  JniResult (*CallNonvirtualIntMethodA)(jobject obj,
                                        jclass clazz,
                                        jmethodID methodID,
                                        jvalue* args);
  JniResult (*CallNonvirtualLongMethod)(jobject, jclass, jmethodID);
  JniResult (*CallNonvirtualLongMethodV)(jobject, jclass, jmethodID, va_list);
  JniResult (*CallNonvirtualLongMethodA)(jobject obj,
                                         jclass clazz,
                                         jmethodID methodID,
                                         jvalue* args);
  JniResult (*CallNonvirtualFloatMethod)(jobject, jclass, jmethodID);
  JniResult (*CallNonvirtualFloatMethodV)(jobject, jclass, jmethodID, va_list);
  JniResult (*CallNonvirtualFloatMethodA)(jobject obj,
                                          jclass clazz,
                                          jmethodID methodID,
                                          jvalue* args);
  JniResult (*CallNonvirtualDoubleMethod)(jobject, jclass, jmethodID);
  JniResult (*CallNonvirtualDoubleMethodV)(jobject, jclass, jmethodID, va_list);
  JniResult (*CallNonvirtualDoubleMethodA)(jobject obj,
                                           jclass clazz,
                                           jmethodID methodID,
                                           jvalue* args);
  jthrowable (*CallNonvirtualVoidMethod)(jobject, jclass, jmethodID);
  jthrowable (*CallNonvirtualVoidMethodV)(jobject, jclass, jmethodID, va_list);
  jthrowable (*CallNonvirtualVoidMethodA)(jobject obj,
                                          jclass clazz,
                                          jmethodID methodID,
                                          jvalue* args);
  JniPointerResult (*GetFieldID)(jclass clazz, char* name, char* sig);
  JniResult (*GetObjectField)(jobject obj, jfieldID fieldID);
  JniResult (*GetBooleanField)(jobject obj, jfieldID fieldID);
  JniResult (*GetByteField)(jobject obj, jfieldID fieldID);
  JniResult (*GetCharField)(jobject obj, jfieldID fieldID);
  JniResult (*GetShortField)(jobject obj, jfieldID fieldID);
  JniResult (*GetIntField)(jobject obj, jfieldID fieldID);
  JniResult (*GetLongField)(jobject obj, jfieldID fieldID);
  JniResult (*GetFloatField)(jobject obj, jfieldID fieldID);
  JniResult (*GetDoubleField)(jobject obj, jfieldID fieldID);
  jthrowable (*SetObjectField)(jobject obj, jfieldID fieldID, jobject val);
  jthrowable (*SetBooleanField)(jobject obj, jfieldID fieldID, jboolean val);
  jthrowable (*SetByteField)(jobject obj, jfieldID fieldID, jbyte val);
  jthrowable (*SetCharField)(jobject obj, jfieldID fieldID, jchar val);
  jthrowable (*SetShortField)(jobject obj, jfieldID fieldID, jshort val);
  jthrowable (*SetIntField)(jobject obj, jfieldID fieldID, jint val);
  jthrowable (*SetLongField)(jobject obj, jfieldID fieldID, jlong val);
  jthrowable (*SetFloatField)(jobject obj, jfieldID fieldID, jfloat val);
  jthrowable (*SetDoubleField)(jobject obj, jfieldID fieldID, jdouble val);
  JniPointerResult (*GetStaticMethodID)(jclass clazz, char* name, char* sig);
  JniResult (*CallStaticObjectMethod)(jclass, jmethodID);
  JniResult (*CallStaticObjectMethodV)(jclass, jmethodID, va_list);
  JniResult (*CallStaticObjectMethodA)(jclass clazz,
                                       jmethodID methodID,
                                       jvalue* args);
  JniResult (*CallStaticBooleanMethod)(jclass, jmethodID);
  JniResult (*CallStaticBooleanMethodV)(jclass, jmethodID, va_list);
  JniResult (*CallStaticBooleanMethodA)(jclass clazz,
                                        jmethodID methodID,
                                        jvalue* args);
  JniResult (*CallStaticByteMethod)(jclass, jmethodID);
  JniResult (*CallStaticByteMethodV)(jclass, jmethodID, va_list);
  JniResult (*CallStaticByteMethodA)(jclass clazz,
                                     jmethodID methodID,
                                     jvalue* args);
  JniResult (*CallStaticCharMethod)(jclass, jmethodID);
  JniResult (*CallStaticCharMethodV)(jclass, jmethodID, va_list);
  JniResult (*CallStaticCharMethodA)(jclass clazz,
                                     jmethodID methodID,
                                     jvalue* args);
  JniResult (*CallStaticShortMethod)(jclass, jmethodID);
  JniResult (*CallStaticShortMethodV)(jclass, jmethodID, va_list);
  JniResult (*CallStaticShortMethodA)(jclass clazz,
                                      jmethodID methodID,
                                      jvalue* args);
  JniResult (*CallStaticIntMethod)(jclass, jmethodID);
  JniResult (*CallStaticIntMethodV)(jclass, jmethodID, va_list);
  JniResult (*CallStaticIntMethodA)(jclass clazz,
                                    jmethodID methodID,
                                    jvalue* args);
  JniResult (*CallStaticLongMethod)(jclass, jmethodID);
  JniResult (*CallStaticLongMethodV)(jclass, jmethodID, va_list);
  JniResult (*CallStaticLongMethodA)(jclass clazz,
                                     jmethodID methodID,
                                     jvalue* args);
  JniResult (*CallStaticFloatMethod)(jclass, jmethodID);
  JniResult (*CallStaticFloatMethodV)(jclass, jmethodID, va_list);
  JniResult (*CallStaticFloatMethodA)(jclass clazz,
                                      jmethodID methodID,
                                      jvalue* args);
  JniResult (*CallStaticDoubleMethod)(jclass, jmethodID);
  JniResult (*CallStaticDoubleMethodV)(jclass, jmethodID, va_list);
  JniResult (*CallStaticDoubleMethodA)(jclass clazz,
                                       jmethodID methodID,
                                       jvalue* args);
  jthrowable (*CallStaticVoidMethod)(jclass, jmethodID);
  jthrowable (*CallStaticVoidMethodV)(jclass, jmethodID, va_list);
  jthrowable (*CallStaticVoidMethodA)(jclass clazz,
                                      jmethodID methodID,
                                      jvalue* args);
  JniPointerResult (*GetStaticFieldID)(jclass clazz, char* name, char* sig);
  JniResult (*GetStaticObjectField)(jclass clazz, jfieldID fieldID);
  JniResult (*GetStaticBooleanField)(jclass clazz, jfieldID fieldID);
  JniResult (*GetStaticByteField)(jclass clazz, jfieldID fieldID);
  JniResult (*GetStaticCharField)(jclass clazz, jfieldID fieldID);
  JniResult (*GetStaticShortField)(jclass clazz, jfieldID fieldID);
  JniResult (*GetStaticIntField)(jclass clazz, jfieldID fieldID);
  JniResult (*GetStaticLongField)(jclass clazz, jfieldID fieldID);
  JniResult (*GetStaticFloatField)(jclass clazz, jfieldID fieldID);
  JniResult (*GetStaticDoubleField)(jclass clazz, jfieldID fieldID);
  jthrowable (*SetStaticObjectField)(jclass clazz,
                                     jfieldID fieldID,
                                     jobject val);
  jthrowable (*SetStaticBooleanField)(jclass clazz,
                                      jfieldID fieldID,
                                      jboolean val);
  jthrowable (*SetStaticByteField)(jclass clazz, jfieldID fieldID, jbyte val);
  jthrowable (*SetStaticCharField)(jclass clazz, jfieldID fieldID, jchar val);
  jthrowable (*SetStaticShortField)(jclass clazz, jfieldID fieldID, jshort val);
  jthrowable (*SetStaticIntField)(jclass clazz, jfieldID fieldID, jint val);
  jthrowable (*SetStaticLongField)(jclass clazz, jfieldID fieldID, jlong val);
  jthrowable (*SetStaticFloatField)(jclass clazz, jfieldID fieldID, jfloat val);
  jthrowable (*SetStaticDoubleField)(jclass clazz,
                                     jfieldID fieldID,
                                     jdouble val);
  JniResult (*NewString)(jchar* unicodeChars, jsize len);
  JniResult (*GetStringLength)(jstring string);
  JniPointerResult (*GetStringChars)(jstring string, jboolean* isCopy);
  jthrowable (*ReleaseStringChars)(jstring string, jchar* isCopy);
  JniResult (*NewStringUTF)(char* bytes);
  JniResult (*GetStringUTFLength)(jstring string);
  JniPointerResult (*GetStringUTFChars)(jstring string, jboolean* isCopy);
  jthrowable (*ReleaseStringUTFChars)(jstring string, char* utf);
  JniResult (*GetArrayLength)(jarray array);
  JniResult (*NewObjectArray)(jsize length,
                              jclass elementClass,
                              jobject initialElement);
  JniResult (*GetObjectArrayElement)(jobjectArray array, jsize index);
  jthrowable (*SetObjectArrayElement)(jobjectArray array,
                                      jsize index,
                                      jobject val);
  JniResult (*NewBooleanArray)(jsize length);
  JniResult (*NewByteArray)(jsize length);
  JniResult (*NewCharArray)(jsize length);
  JniResult (*NewShortArray)(jsize length);
  JniResult (*NewIntArray)(jsize length);
  JniResult (*NewLongArray)(jsize length);
  JniResult (*NewFloatArray)(jsize length);
  JniResult (*NewDoubleArray)(jsize length);
  JniPointerResult (*GetBooleanArrayElements)(jbooleanArray array,
                                              jboolean* isCopy);
  JniPointerResult (*GetByteArrayElements)(jbyteArray array, jboolean* isCopy);
  JniPointerResult (*GetCharArrayElements)(jcharArray array, jboolean* isCopy);
  JniPointerResult (*GetShortArrayElements)(jshortArray array,
                                            jboolean* isCopy);
  JniPointerResult (*GetIntArrayElements)(jintArray array, jboolean* isCopy);
  JniPointerResult (*GetLongArrayElements)(jlongArray array, jboolean* isCopy);
  JniPointerResult (*GetFloatArrayElements)(jfloatArray array,
                                            jboolean* isCopy);
  JniPointerResult (*GetDoubleArrayElements)(jdoubleArray array,
                                             jboolean* isCopy);
  jthrowable (*ReleaseBooleanArrayElements)(jbooleanArray array,
                                            jboolean* elems,
                                            jint mode);
  jthrowable (*ReleaseByteArrayElements)(jbyteArray array,
                                         jbyte* elems,
                                         jint mode);
  jthrowable (*ReleaseCharArrayElements)(jcharArray array,
                                         jchar* elems,
                                         jint mode);
  jthrowable (*ReleaseShortArrayElements)(jshortArray array,
                                          jshort* elems,
                                          jint mode);
  jthrowable (*ReleaseIntArrayElements)(jintArray array,
                                        jint* elems,
                                        jint mode);
  jthrowable (*ReleaseLongArrayElements)(jlongArray array,
                                         jlong* elems,
                                         jint mode);
  jthrowable (*ReleaseFloatArrayElements)(jfloatArray array,
                                          jfloat* elems,
                                          jint mode);
  jthrowable (*ReleaseDoubleArrayElements)(jdoubleArray array,
                                           jdouble* elems,
                                           jint mode);
  jthrowable (*GetBooleanArrayRegion)(jbooleanArray array,
                                      jsize start,
                                      jsize len,
                                      jboolean* buf);
  jthrowable (*GetByteArrayRegion)(jbyteArray array,
                                   jsize start,
                                   jsize len,
                                   jbyte* buf);
  jthrowable (*GetCharArrayRegion)(jcharArray array,
                                   jsize start,
                                   jsize len,
                                   jchar* buf);
  jthrowable (*GetShortArrayRegion)(jshortArray array,
                                    jsize start,
                                    jsize len,
                                    jshort* buf);
  jthrowable (*GetIntArrayRegion)(jintArray array,
                                  jsize start,
                                  jsize len,
                                  jint* buf);
  jthrowable (*GetLongArrayRegion)(jlongArray array,
                                   jsize start,
                                   jsize len,
                                   jlong* buf);
  jthrowable (*GetFloatArrayRegion)(jfloatArray array,
                                    jsize start,
                                    jsize len,
                                    jfloat* buf);
  jthrowable (*GetDoubleArrayRegion)(jdoubleArray array,
                                     jsize start,
                                     jsize len,
                                     jdouble* buf);
  jthrowable (*SetBooleanArrayRegion)(jbooleanArray array,
                                      jsize start,
                                      jsize len,
                                      jboolean* buf);
  jthrowable (*SetByteArrayRegion)(jbyteArray array,
                                   jsize start,
                                   jsize len,
                                   jbyte* buf);
  jthrowable (*SetCharArrayRegion)(jcharArray array,
                                   jsize start,
                                   jsize len,
                                   jchar* buf);
  jthrowable (*SetShortArrayRegion)(jshortArray array,
                                    jsize start,
                                    jsize len,
                                    jshort* buf);
  jthrowable (*SetIntArrayRegion)(jintArray array,
                                  jsize start,
                                  jsize len,
                                  jint* buf);
  jthrowable (*SetLongArrayRegion)(jlongArray array,
                                   jsize start,
                                   jsize len,
                                   jlong* buf);
  jthrowable (*SetFloatArrayRegion)(jfloatArray array,
                                    jsize start,
                                    jsize len,
                                    jfloat* buf);
  jthrowable (*SetDoubleArrayRegion)(jdoubleArray array,
                                     jsize start,
                                     jsize len,
                                     jdouble* buf);
  JniResult (*RegisterNatives)(jclass clazz,
                               JNINativeMethod* methods,
                               jint nMethods);
  JniResult (*UnregisterNatives)(jclass clazz);
  JniResult (*MonitorEnter)(jobject obj);
  JniResult (*MonitorExit)(jobject obj);
  JniResult (*GetJavaVM)(JavaVM** vm);
  jthrowable (*GetStringRegion)(jstring str,
                                jsize start,
                                jsize len,
                                jchar* buf);
  jthrowable (*GetStringUTFRegion)(jstring str,
                                   jsize start,
                                   jsize len,
                                   char* buf);
  JniPointerResult (*GetPrimitiveArrayCritical)(jarray array, jboolean* isCopy);
  jthrowable (*ReleasePrimitiveArrayCritical)(jarray array,
                                              void* carray,
                                              jint mode);
  JniPointerResult (*GetStringCritical)(jstring str, jboolean* isCopy);
  jthrowable (*ReleaseStringCritical)(jstring str, jchar* carray);
  JniResult (*NewWeakGlobalRef)(jobject obj);
  jthrowable (*DeleteWeakGlobalRef)(jweak obj);
  JniResult (*ExceptionCheck)();
  JniResult (*NewDirectByteBuffer)(void* address, jlong capacity);
  JniPointerResult (*GetDirectBufferAddress)(jobject buf);
  JniResult (*GetDirectBufferCapacity)(jobject buf);
  JniResult (*GetObjectRefType)(jobject obj);
} GlobalJniEnv;
FFI_PLUGIN_EXPORT GlobalJniEnv* GetGlobalEnv();
