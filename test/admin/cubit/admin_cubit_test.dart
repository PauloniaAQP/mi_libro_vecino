import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mi_libro_vecino/admin/cubit/admin_cubit.dart';

void main() {
  group('Admin cubit test', () {
    late String query;

    setUp(() {
      query = 'hola';
    });

    test('Initial state index is 0',
        () {
      expect(AdminCubit().state.isSearching, false);
    });

    blocTest<AdminCubit, AdminState>(
      'The cubit should have isSearching true',
      build: () => AdminCubit(),
      act: (cubit) => cubit.onSearchQueryChanged(query),
      expect: () => [
        AdminInitial().copyWith(isSearching: true),
      ],
    );
    blocTest<AdminCubit, AdminState>(
      'The cubit should have isSearching false',
      build: () => AdminCubit(),
      act: (cubit) => cubit.onTapClearSearch(),
      expect: () => [
        AdminInitial().copyWith(isSearching: false),
      ],
    );
  });
}
