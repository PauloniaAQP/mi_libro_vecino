import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mi_libro_vecino/admin/cubit/admin_cubit.dart';
import 'package:mi_libro_vecino_api/repositories/library_repository.dart';
import 'package:mi_libro_vecino_api/repositories/user_repository.dart';

import '../../firebase_mock.dart';

void main() {
  setupFirebaseAuthMocks();
  group('Admin cubit test', () {
    late String query;

    setUp(() async {
      WidgetsFlutterBinding.ensureInitialized();
      query = 'hola';
      await Firebase.initializeApp();
      Get
        ..lazyPut(() => UserRepository())
        ..lazyPut(() => LibraryRepository());
    });

    test('Initial state index is 0', () {
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
