import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mi_libro_vecino/authentication/cubit/register_cubit.dart';
import 'package:mi_libro_vecino/authentication/view/pages/waiting_page.dart';

import '../../../helpers/pump_app.dart';

class MockSearchCubit extends MockCubit<RegisterState>
    implements RegisterCubit {}

void main() {
  group('Register waiting page', () {
    late RegisterCubit registerCubit;

    setUp(() {
      registerCubit = MockSearchCubit();
    });

    testWidgets('renders waiting Page', (tester) async {
      await tester.pumpApp(
        BlocProvider.value(
          value: registerCubit,
          child: const WaitingPage(),
        ),
      );
      expect(
        find.byKey(
          const Key('waiting_page_button'),
        ),
        findsOneWidget,
      );
    });
  });
}
