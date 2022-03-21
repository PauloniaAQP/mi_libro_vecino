import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mi_libro_vecino/admin/cubit/admin_cubit.dart';
import 'package:mi_libro_vecino/admin/view/pages/admin_library_information_page.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/pump_app.dart';

class MockAdminCubit extends MockCubit<AdminState> implements AdminCubit {}

void main() {
  group('Admin page', () {
    late AdminCubit adminCubit;

    setUp(() {
      adminCubit = MockAdminCubit();
    });

    testWidgets('renders admin information page', (tester) async {
      final state = AdminInitial();
      when(() => adminCubit.state).thenReturn(state);
      await tester.pumpApp(
        BlocProvider.value(
          value: adminCubit,
          child: const AdminLibraryInformationPage(id: '01', index: 0),
        ),
      );
      expect(
        find.byKey(
          const Key('admin_info_page_image_container'),
        ),
        findsOneWidget,
      );
    });

    testWidgets('renders admin information page', (tester) async {
      final state = AdminInitial();
      when(() => adminCubit.state).thenReturn(state);
      await tester.pumpApp(
        BlocProvider.value(
          value: adminCubit,
          child: const AdminLibraryInformationPage(id: '01', index: 1),
        ),
      );
      expect(
        find.byKey(
          const Key('admin_info_remove_library_button'),
        ),
        findsOneWidget,
      );
    });
  });
}
