import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mi_libro_vecino/libraries/components/library_card.dart';
import 'package:mi_libro_vecino/ui_utils/constans/assets.dart';

import '../../helpers/pump_app.dart';

void main() {
  group('Library card widget', () {
    setUp(() {});

    testWidgets('renders Library card widget', (tester) async {
      await tester.pumpApp(
        LibraryCard(
          imgPath: Assets.testImg,
          labels: const [],
          onTap: () {},
          subtitle: '',
          title: '',
        ),
      );
      expect(
        find.byKey(
          const Key('libraryCardInkwellKey'),
        ),
        findsOneWidget,
      );
    });
  });
}
