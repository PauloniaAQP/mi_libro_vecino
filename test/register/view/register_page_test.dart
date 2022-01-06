import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mi_libro_vecino/register/cubit/register_cubit.dart';
import 'package:mi_libro_vecino/register/view/register_page.dart';
import 'package:mocktail/mocktail.dart';

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
          child: const RegisterPage(),
        ),
      );
      expect(
        find.text(
          'Las bibliotecas hacen que MI LIBRO VECINO sea posible',
        ),
        findsOneWidget,
      );
    });
  });
}
