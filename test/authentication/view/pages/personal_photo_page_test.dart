import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mi_libro_vecino/authentication/cubit/register_cubit.dart';
import 'package:mi_libro_vecino/authentication/view/register_page.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/pump_app.dart';

class MockSearchCubit extends MockCubit<RegisterState>
    implements RegisterCubit {}

void main() {
  group('Register personal photo page', () {
    late RegisterCubit registerCubit;

    setUp(() {
      registerCubit = MockSearchCubit();
    });

    testWidgets('renders Register personal photo Page', (tester) async {
      final state = RegisterInitial();
      when(() => registerCubit.state).thenReturn(state.copyWith(index: 2));
      await tester.pumpApp(
        BlocProvider.value(
          value: registerCubit,
          child: const RegisterPageView(),
        ),
      );
      expect(
        find.byKey(const Key('pick_image_key')),
        findsOneWidget,
      );
    });
  });
}
