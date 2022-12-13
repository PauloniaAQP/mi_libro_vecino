import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mi_libro_vecino/authentication/cubit/register_cubit.dart';
import 'package:mi_libro_vecino/authentication/view/pages/quotes_page.dart';
import 'package:mi_libro_vecino/authentication/view/register_page.dart';
import 'package:mocktail/mocktail.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../helpers/pump_app.dart';

class MockSearchCubit extends MockCubit<RegisterState>
    implements RegisterCubit {}

void main() {
  group('Register page', () {
    late RegisterCubit registerCubit;

    setUp(() {
      registerCubit = MockSearchCubit();
    });

    testWidgets('renders Register Page', (tester) async {
      final state = RegisterInitial();
      when(() => registerCubit.state).thenReturn(state);
      await tester.pumpApp(
        BlocProvider.value(
          value: registerCubit,
          child: ScreenTypeLayout(
            desktop: const RegisterPage(),
            mobile: const SizedBox(),
          ),
        ),
      );
      expect(
        find.byType(ScreenTypeLayout),
        findsOneWidget,
      );
    });
  });
}
