import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mi_libro_vecino/app/bloc/app_user_bloc.dart';
import 'package:mi_libro_vecino/authentication/cubit/register_cubit.dart';
import 'package:mi_libro_vecino/authentication/view/register_page.dart';
import 'package:mi_libro_vecino_api/utils/utils.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/pump_app.dart';

class MockSearchCubit extends MockCubit<RegisterState>
    implements RegisterCubit {}

class MockAppUserBloc extends MockCubit<AppUserState> implements AppUserBloc {}

void main() {
  group('Register library location page', () {
    late RegisterCubit registerCubit;
    late AppUserBloc appUserBloc;

    setUp(() async {
      registerCubit = MockSearchCubit();
      appUserBloc = MockAppUserBloc();
    });

    testWidgets('renders library location Page', (tester) async {
      final registerState = RegisterInitial();
      const appUserState = AppUserInitial();
      when(() => registerCubit.state)
          .thenReturn(registerState.copyWith(index: 5));
      when(() => appUserBloc.state).thenReturn(
        appUserState.copyWith(currentLocation: Coordinates(-17, -51)),
      );
      await tester.pumpApp(
        BlocProvider.value(
          value: appUserBloc,
          child: BlocProvider.value(
            value: registerCubit,
            child: const RegisterPage(),
          ),
        ),
      );
      // TODO(oscarnar): Make test for http request
      // expect(
      //   find.text(
      //     'Ubíquese en el mapa',
      //   ),
      //   findsOneWidget,
      // );
    });
  });
}
