import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mi_libro_vecino/authentication/cubit/register_cubit.dart';
import 'package:mi_libro_vecino/authentication/view/register_page.dart';
import 'package:mocktail/mocktail.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../helpers/pump_app.dart';

class MockSearchCubit extends MockCubit<RegisterState>
    implements RegisterCubit {}

class MockScreenBreakpoints extends Mock implements ScreenBreakpoints {}

void main() {
  group('Email register page', () {
    late RegisterCubit registerCubit;
    late ScreenBreakpoints mockScreenBreakpoints;
    setUp(() {
      registerCubit = MockSearchCubit();
      mockScreenBreakpoints = MockScreenBreakpoints();
    });

    testWidgets('render Email register Page', (tester) async {
      final state = RegisterInitial();
      when(() => registerCubit.state).thenReturn(state.copyWith(index: 0));
      when(() => getDeviceType(const Size(1000, 1200), mockScreenBreakpoints))
          .thenReturn(DeviceScreenType.desktop);
      await tester.pumpApp(
        BlocProvider.value(
          value: registerCubit,
          child: const RegisterPage(),
        ),
      );
      expect(
        find.text(
          'Nuevo registro',
        ),
        findsOneWidget,
      );
    });
  });
}
