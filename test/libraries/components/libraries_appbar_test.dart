import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mi_libro_vecino/libraries/components/libraries_appbar.dart';
import 'package:mi_libro_vecino/ui_utils/constans/assets.dart';
import 'package:mocktail/mocktail.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../helpers/pump_app.dart';

class MockScreenBreakpoints extends Mock implements ScreenBreakpoints {}

void main() {
  group('Library app bar widget', () {
    late ScreenBreakpoints mockScreenBreakpoints;
    setUp(() {
      mockScreenBreakpoints = MockScreenBreakpoints();
    });

    testWidgets('renders Library app bar widget on mobile', (tester) async {
      await tester.pumpApp(
        const LibrariesAppBar(),
      );
      expect(find.image(const AssetImage(Assets.facebookLogo)), findsOneWidget);
    });
    //testWidgets('renders Library app bar widget on desktop', (tester) async {
    //  when(() => getDeviceType(const Size(1000, 1200), mockScreenBreakpoints))
    //      .thenAnswer((_) => DeviceScreenType.desktop);
    //  await tester.pumpApp(
    //    const LibrariesAppBar(),
    //  );
    //  //expect(find.image(AssetImage(Assets.facebookLogo)), findsOneWidget);
    //  expect(find.text('Síguenos'), findsOneWidget);
    //});
  });
}
