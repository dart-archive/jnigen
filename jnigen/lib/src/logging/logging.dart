// Copyright (c) 2022, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

enum LogLevel {
  fatal,
  warning,
  info,
  debug,
  verbose,
}

class Log {
  static LogLevel _level = LogLevel.info;
  static DateTime _began = DateTime.now();

  static String _levelString(LogLevel level) => level.name.toUpperCase();

  static void begin(LogLevel level) {
    _level = level;
    _began = DateTime.now();
  }

  static void _log(LogLevel level, Object? value, {String? color}) {
    if (level.index <= _level.index) {
      final duration = DateTime.now().difference(_began);
      final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
      final minutes = duration.inMinutes.toString().padLeft(2, '0');
      final levelString = _levelString(level);
      var message = '[jnigen] [$minutes:$seconds $levelString] $value';
      if (color != null) {
        message = '$color$message$_ansiDefault';
      }
      stderr.writeln(message);
    }
  }

  static const _ansiRed = '\x1b[31m';
  static const _ansiDefault = '\x1b[39;49m';

  static void fatal(Object? value, {int exitCode = 2}) {
    _log(LogLevel.fatal, value,
        color: stderr.supportsAnsiEscapes ? _ansiRed : null);
    exit(exitCode);
  }

  static void warning(Object? value) => _log(LogLevel.warning, value);
  static void info(Object? value) => _log(LogLevel.info, value);
  static void debug(Object? value) => _log(LogLevel.debug, value);
  static void verbose(Object? value) => _log(LogLevel.verbose, value);
}
