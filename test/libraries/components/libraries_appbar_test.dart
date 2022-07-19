import 'package:flutter_test/flutter_test.dart';
import 'package:mi_libro_vecino/libraries/components/libraries_appbar.dart';

import '../../helpers/pump_app.dart';

void main() {
  group('Library app bar widget', () {
    setUp(() {});

    testWidgets('renders Library app bar widget', (tester) async {
      await tester.pumpApp(
        const LibrariesAppBar(),
      );
      expect(
        find.text(
          'Síguenos',
        ),
        findsOneWidget,
      );
    });
  });
}
