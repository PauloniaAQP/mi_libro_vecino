import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mi_libro_vecino/admin/cubit/admin_cubit.dart';
import 'package:mi_libro_vecino/admin/view/admin_page.dart';
import 'package:mi_libro_vecino/app/bloc/app_user_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:paulonia_cache_image/paulonia_cache_image.dart';

import '../../helpers/pump_app.dart';

class MockAdminCubit extends MockCubit<AdminState> implements AdminCubit {}

class MockAppUserBloc extends MockCubit<AppUserState> implements AppUserBloc {}

void main() {
  group('Admin page', () {
    late AdminCubit adminCubit;
    late AppUserBloc appUserBloc;

    setUp(() {
      PCacheImage.init();
      adminCubit = MockAdminCubit();
      appUserBloc = MockAppUserBloc();
    });

    testWidgets('renders admin new requests Page', (tester) async {
      final state = AdminInitial();
      final appUserState = AppUserInitial();
      when(() => adminCubit.state).thenReturn(state);
      when(() => appUserBloc.state).thenReturn(appUserState);
      when(() => adminCubit.fillData()).thenAnswer((_) async {
        return;
      });
      await tester.pumpApp(
        BlocProvider.value(
          value: appUserBloc,
          child: BlocProvider.value(
            value: adminCubit,
            child: const AdminPage(),
          ),
        ),
      );
      expect(
        find.text(
          'Colaboradores',
        ),
        findsOneWidget,
      );
    });

    testWidgets('renders admin old collaborators Page', (tester) async {
      final state = AdminInitial();
      final appUserState = AppUserInitial();
      when(() => adminCubit.state).thenReturn(state);
      when(() => appUserBloc.state).thenReturn(appUserState);
      when(() => adminCubit.fillData()).thenAnswer((_) async {
        return;
      });
      await tester.pumpApp(
        BlocProvider.value(
          value: appUserBloc,
          child: BlocProvider.value(
            value: adminCubit,
            child: const AdminPage(index: 1),
          ),
        ),
      );
      expect(
        find.text(
          'Colaboradores',
        ),
        findsOneWidget,
      );
    });
  });
}
