// Copyright (c) 2023, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:jni/jni.dart';
import 'package:test/test.dart';

import 'test_util/test_util.dart';

void main() {
  // Don't forget to initialize JNI.
  if (!Platform.isAndroid) {
    Jni.spawnIfNotExists(dylibDir: "build/jni_libs", jvmOptions: ["-Xmx128m"]);
  }
  run(testRunner: test);
}

void run({required TestRunnerCallback testRunner}) {
  JMap<JString, JString> testDataMap(Arena arena) {
    return {
      "1".toJString()..releasedIn(arena): "One".toJString()..releasedIn(arena),
      "2".toJString()..releasedIn(arena): "Two".toJString()..releasedIn(arena),
      "3".toJString()..releasedIn(arena): "Three".toJString()
        ..releasedIn(arena),
    }.toJMap(JString.type, JString.type)
      ..releasedIn(arena);
  }

  testRunner('length', () {
    using((arena) {
      final map = testDataMap(arena);
      expect(map.length, 3);
    });
  });
  testRunner('[]', () {
    using((arena) {
      final map = testDataMap(arena);
      // ignore: collection_methods_unrelated_type
      expect(map[1], null);
      expect(
        map["1".toJString()..releasedIn(arena)]
            ?.toDartString(releaseOriginal: true),
        "One",
      );
      expect(
        map["4".toJString()..releasedIn(arena)],
        null,
      );
    });
  });
  testRunner('[]=', () {
    using((arena) {
      final map = testDataMap(arena);
      map["0".toJString()..releasedIn(arena)] = "Zero".toJString()
        ..releasedIn(arena);
      expect(
        map["0".toJString()..releasedIn(arena)]
            ?.toDartString(releaseOriginal: true),
        "Zero",
      );
      expect(map.length, 4);
      map["1".toJString()..releasedIn(arena)] = "one!".toJString()
        ..releasedIn(arena);
      expect(
        map["1".toJString()..releasedIn(arena)]
            ?.toDartString(releaseOriginal: true),
        "one!",
      );
      expect(map.length, 4);
    });
  });
  testRunner('addAll', () {
    using((arena) {
      final map = testDataMap(arena);
      final toAdd = {
        "0".toJString()..releasedIn(arena): "Zero".toJString()
          ..releasedIn(arena),
        "1".toJString()..releasedIn(arena): "one!".toJString()
          ..releasedIn(arena),
      }.toJMap(JString.type, JString.type);
      map.addAll(toAdd);
      expect(map.length, 4);
      expect(
        map["0".toJString()..releasedIn(arena)]
            ?.toDartString(releaseOriginal: true),
        "Zero",
      );
      expect(
        map["1".toJString()..releasedIn(arena)]
            ?.toDartString(releaseOriginal: true),
        "one!",
      );
      map.addAll({
        "4".toJString()..releasedIn(arena): "Four".toJString()
          ..releasedIn(arena)
      });
      expect(map.length, 5);
    });
  });
  testRunner('clear, isEmpty, isNotEmpty', () {
    using((arena) {
      final map = testDataMap(arena);
      expect(map.isEmpty, false);
      expect(map.isNotEmpty, true);
      map.clear();
      expect(map.isEmpty, true);
      expect(map.isNotEmpty, false);
    });
  });
  testRunner('containsKey', () {
    using((arena) {
      final map = testDataMap(arena);
      // ignore: iterable_contains_unrelated_type
      expect(map.containsKey(1), false);
      expect(map.containsKey("1".toJString()..releasedIn(arena)), true);
      expect(map.containsKey("4".toJString()..releasedIn(arena)), false);
    });
  });
  testRunner('containsValue', () {
    using((arena) {
      final map = testDataMap(arena);
      // ignore: iterable_contains_unrelated_type
      expect(map.containsValue(1), false);
      expect(map.containsValue("One".toJString()..releasedIn(arena)), true);
      expect(map.containsValue("Four".toJString()..releasedIn(arena)), false);
    });
  });
  testRunner('keys', () {
    using((arena) {
      final map = testDataMap(arena);
      final keys = map.keys;
      expect(
        keys
            .map((element) => element.toDartString(releaseOriginal: true))
            .toSet(),
        {"1", "2", "3"},
      );
    });
  });
  testRunner('remove', () {
    using((arena) {
      final map = testDataMap(arena);
      // ignore: collection_methods_unrelated_type
      expect(map.remove(1), null);
      expect(map.remove("4".toJString()..releasedIn(arena)), null);
      expect(map.length, 3);
      expect(
        map
            .remove("3".toJString()..releasedIn(arena))
            ?.toDartString(releaseOriginal: true),
        "Three",
      );
      expect(map.length, 2);
    });
  });
  testRunner('type hashCode, ==', () {
    using((arena) {
      final a = testDataMap(arena);
      final b = testDataMap(arena);
      expect(a.$type, b.$type);
      expect(a.$type, b.$type);
      expect(a.$type.hashCode, b.$type.hashCode);
      final c = JMap.hash(JObject.type, JObject.type)..releasedIn(arena);
      expect(a.$type, isNot(c.$type));
      expect(a.$type.hashCode, isNot(c.$type.hashCode));
    });
  });
}
