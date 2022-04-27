import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mi_libro_vecino/libraries/components/library_info.dart';

import '../../helpers/pump_app.dart';

void main() {
  group('Information library page', () {
    setUp(() {});

    testWidgets('renders information library Page', (tester) async {
      await tester.pumpApp(
        const InfomationLibrary(),
      );
      expect(
        find.byKey(const Key('notFoundResultsKey')),
        findsOneWidget,
      );
    });
  });
}
