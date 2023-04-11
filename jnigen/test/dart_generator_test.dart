// Copyright (c) 2023, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:jnigen/src/bindings/dart_generator.dart';
import 'package:test/test.dart';

void main() {
  test('ReverseExpressionBuilder', () {
    final exprBuilder = ReverseExpressionBuilder();
    exprBuilder.write(' as A).first');
    exprBuilder.write(' as B).second');
    exprBuilder.write('third');
    expect(exprBuilder.toString(), '((third as B).second as A).first');
  });
}
