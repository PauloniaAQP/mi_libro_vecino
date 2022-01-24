import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mi_libro_vecino/libraries/components/libraries_list.dart';

import '../../helpers/pump_app.dart';

void main() {
  group('Libraries list page', () {
    setUp(() {});

    testWidgets('renders libraries list Page', (tester) async {
      await tester.pumpApp(
        const LibrariesList(),
      );
      expect(
        find.byKey(
          const Key('librariesListKey'),
        ),
        findsOneWidget,
      );
    });
  });
}
