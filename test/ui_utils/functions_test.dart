import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mi_libro_vecino/ui_utils/functions.dart';

void main() {
  group('Register page', () {
    setUp(() {});

    test('calls createUserWithEmailAndPassword', () {
      expect(
        fromStringToTimeOfDay('12:00'),
        const TimeOfDay(hour: 12, minute: 0),
      );
    });
  });
}
