import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mi_libro_vecino/admin/cubit/admin_cubit.dart';
import 'package:mi_libro_vecino/admin/view/admin_page.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/pump_app.dart';

class MockAdminCubit extends MockCubit<AdminState> implements AdminCubit {}

void main() {
  group('Admin page', () {
    late AdminCubit adminCubit;

    setUp(() {
      adminCubit = MockAdminCubit();
    });

    testWidgets('renders admin new requests Page', (tester) async {
      final state = AdminInitial();
      when(() => adminCubit.state).thenReturn(state);
      await tester.pumpApp(
        BlocProvider.value(
          value: adminCubit,
          child: const AdminPage(),
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
      when(() => adminCubit.state).thenReturn(state);
      await tester.pumpApp(
        BlocProvider.value(
          value: adminCubit,
          child: const AdminPage(index: 1),
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
