# The Flutter tooling requires that developers have CMake 3.10 or later
# installed. You should not increase this version, as doing so will cause
# the plugin to fail to compile for some customers of the plugin.
cmake_minimum_required(VERSION 3.10)

project(jni_gen_test VERSION 0.0.1 LANGUAGES C)

add_library(jni_gen_test SHARED
  "jni_gen_test.c"
)

set_target_properties(jni_gen_test PROPERTIES
  OUTPUT_NAME "jni_gen_test"
)

target_compile_definitions(jni_gen_test PUBLIC DART_SHARED_LIB)

if(WIN32)
	set_target_properties(${TARGET_NAME} PROPERTIES
		LINK_FLAGS "/DELAYLOAD:jvm.dll")
endif()

if (ANDROID)
	target_link_libraries(jni_gen_test log)
else()
	find_package(Java REQUIRED)
	find_package(JNI REQUIRED)
	include_directories(${JNI_INCLUDE_DIRS})
	target_link_libraries(jni_gen_test ${JNI_LIBRARIES})
endif()
