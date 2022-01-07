import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mi_libro_vecino/register/cubit/register_cubit.dart';
import 'package:mi_libro_vecino/register/view/register_page.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/pump_app.dart';

class MockSearchCubit extends MockCubit<RegisterState>
    implements RegisterCubit {}


// TODO(oscarnar): Add tests for the rest of the widgets
void main() {
  group('Libraries list page', () {
    late RegisterCubit registerCubit;

    setUp(() {
      registerCubit = MockSearchCubit();
    });

    testWidgets('renders libraries list Page', (tester) async {
      final state = RegisterInitial();
      // when(() => registerCubit.state).thenReturn(state);
      await tester.pumpApp(
        // BlocProvider.value(
        //   value: registerCubit,
        //   child: const RegisterPage(),
        // ),
        const RegisterPage(),
      );
      expect(
        find.text(
          'test',
        ),
        findsOneWidget,
      );
    });
  });
}
