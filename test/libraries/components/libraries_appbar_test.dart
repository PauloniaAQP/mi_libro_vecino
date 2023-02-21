import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mi_libro_vecino/libraries/components/libraries_appbar.dart';
import 'package:mi_libro_vecino/ui_utils/constans/assets.dart';

import '../../helpers/pump_app.dart';

void main() {
  group('Library app bar widget', () {
    setUp(() {});

    testWidgets('renders Library app bar widget on mobile', (tester) async {
      await tester.pumpApp(
        const LibrariesAppBar(),
      );
      expect(find.image(const AssetImage(Assets.facebookLogo)), findsOneWidget);
    });
  });
}
