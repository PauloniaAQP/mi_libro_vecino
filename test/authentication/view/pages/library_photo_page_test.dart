import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mi_libro_vecino/authentication/cubit/register_cubit.dart';
import 'package:mi_libro_vecino/authentication/view/register_page.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/pump_app.dart';

class MockSearchCubit extends MockCubit<RegisterState>
    implements RegisterCubit {}

void main() {
  group('Register photo library page', () {
    late RegisterCubit registerCubit;

    setUp(() {
      registerCubit = MockSearchCubit();
    });

    testWidgets('renders Register photo library Page', (tester) async {
      final state = RegisterInitial();
      when(() => registerCubit.state).thenReturn(state.copyWith(index: 6));
      await tester.pumpApp(
        BlocProvider.value(
          value: registerCubit,
          child: const RegisterPageView(),
        ),
      );
      expect(
        find.text(
          'SUBIR FOTO',
        ),
        findsOneWidget,
      );
    });
  });
}
