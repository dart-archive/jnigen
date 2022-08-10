#!/bin/bash
set -e -x
dart run jni_gen:build_summarizer
dart run tool/gen.dart
dart run jni:setup
dart run jni:setup -p jni_gen_test
dart test

