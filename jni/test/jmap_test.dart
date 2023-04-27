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
    try {
      Jni.spawn(dylibDir: "build/jni_libs", jvmOptions: ["-Xmx128m"]);
    } on JvmExistsException catch (_) {
      // TODO(#51): Support destroying and reinstantiating JVM.
    }
  }
  run(testRunner: test);
}

void run({required TestRunnerCallback testRunner}) {
  JMap<JString, JString> newJMap(Arena arena) {
    return {
      "1".toJString()..deletedIn(arena): "One".toJString()..deletedIn(arena),
      "2".toJString()..deletedIn(arena): "Two".toJString()..deletedIn(arena),
      "3".toJString()..deletedIn(arena): "Three".toJString()..deletedIn(arena),
    }.toJMap(JString.type, JString.type)
      ..deletedIn(arena);
  }

  testRunner('length', () {
    using((arena) {
      final map = newJMap(arena);
      expect(map.length, 3);
    });
  });
  testRunner('[]', () {
    using((arena) {
      final map = newJMap(arena);
      // ignore: collection_methods_unrelated_type
      expect(map[1], null);
      expect(
        map["1".toJString()..deletedIn(arena)]
            ?.toDartString(deleteOriginal: true),
        "One",
      );
      expect(
        map["4".toJString()..deletedIn(arena)],
        null,
      );
    });
  });
  testRunner('[]=', () {
    using((arena) {
      final map = newJMap(arena);
      map["0".toJString()..deletedIn(arena)] = "Zero".toJString()
        ..deletedIn(arena);
      expect(
        map["0".toJString()..deletedIn(arena)]
            ?.toDartString(deleteOriginal: true),
        "Zero",
      );
      expect(map.length, 4);
      map["1".toJString()..deletedIn(arena)] = "one!".toJString()
        ..deletedIn(arena);
      expect(
        map["1".toJString()..deletedIn(arena)]
            ?.toDartString(deleteOriginal: true),
        "one!",
      );
      expect(map.length, 4);
    });
  });
  testRunner('addAll', () {
    using((arena) {
      final map = newJMap(arena);
      final toAdd = {
        "0".toJString()..deletedIn(arena): "Zero".toJString()..deletedIn(arena),
        "1".toJString()..deletedIn(arena): "one!".toJString()..deletedIn(arena),
      }.toJMap(JString.type, JString.type);
      map.addAll(toAdd);
      expect(map.length, 4);
      expect(
        map["0".toJString()..deletedIn(arena)]
            ?.toDartString(deleteOriginal: true),
        "Zero",
      );
      expect(
        map["1".toJString()..deletedIn(arena)]
            ?.toDartString(deleteOriginal: true),
        "one!",
      );
      map.addAll({
        "4".toJString()..deletedIn(arena): "Four".toJString()..deletedIn(arena)
      });
      expect(map.length, 5);
    });
  });
  testRunner('clear, isEmpty, isNotEmpty', () {
    using((arena) {
      final map = newJMap(arena);
      expect(map.isEmpty, false);
      expect(map.isNotEmpty, true);
      map.clear();
      expect(map.isEmpty, true);
      expect(map.isNotEmpty, false);
    });
  });
  testRunner('containsKey', () {
    using((arena) {
      final map = newJMap(arena);
      // ignore: iterable_contains_unrelated_type
      expect(map.containsKey(1), false);
      expect(map.containsKey("1".toJString()..deletedIn(arena)), true);
      expect(map.containsKey("4".toJString()..deletedIn(arena)), false);
    });
  });
  testRunner('containsValue', () {
    using((arena) {
      final map = newJMap(arena);
      // ignore: iterable_contains_unrelated_type
      expect(map.containsValue(1), false);
      expect(map.containsValue("One".toJString()..deletedIn(arena)), true);
      expect(map.containsValue("Four".toJString()..deletedIn(arena)), false);
    });
  });
  testRunner('keys', () {
    using((arena) {
      final map = newJMap(arena);
      final keys = map.keys;
      expect(
        keys
            .map((element) => element.toDartString(deleteOriginal: true))
            .toSet(),
        {"1", "2", "3"},
      );
    });
  });
  testRunner('remove', () {
    using((arena) {
      final map = newJMap(arena);
      // ignore: collection_methods_unrelated_type
      expect(map.remove(1), null);
      expect(map.remove("4".toJString()..deletedIn(arena)), null);
      expect(map.length, 3);
      expect(
        map
            .remove("3".toJString()..deletedIn(arena))
            ?.toDartString(deleteOriginal: true),
        "Three",
      );
      expect(map.length, 2);
    });
  });
}
