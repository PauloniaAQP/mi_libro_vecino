import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mi_libro_vecino/app/bloc/app_user_bloc.dart';
import 'package:mi_libro_vecino/authentication/bloc/auth_bloc.dart';
import 'package:mi_libro_vecino_api/repositories/library_repository.dart';
import 'package:mi_libro_vecino_api/repositories/user_repository.dart';
import 'package:mocktail/mocktail.dart';

import '../../firebase_mock.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockUserCredential extends Mock implements UserCredential {}

void main() {
  setupFirebaseAuthMocks();
  group('Register cubit test', () {
    late AuthState testState;

    setUp(() async {
      await Firebase.initializeApp();
      testState = const AuthInitial();
      Get
        ..put(UserRepository(), permanent: true)
        ..put(LibraryRepository(), permanent: true);
    });

    test('Initial testState index is 0', () {
      expect(
        AuthBloc(appUserBloc: AppUserBloc()).state,
        const AuthInitial(),
      );
    });

    blocTest<AuthBloc, AuthState>(
      'The cubit should be on index 1',
      build: () => AuthBloc(appUserBloc: AppUserBloc())..emit(testState),
      act: (bloc) {
        bloc.add(const AuthLoginRequested('test@test.com', '123456'));
      },
      expect: () => [
        const AuthLoading(),
        const AuthInitial(),
      ],
    );
  });
}
