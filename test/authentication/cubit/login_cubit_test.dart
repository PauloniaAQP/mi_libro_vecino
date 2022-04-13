import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mi_libro_vecino/authentication/cubit/login_cubit.dart';
import 'package:mocktail/mocktail.dart';

import '../../firebase_mock.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockUserCredential extends Mock implements UserCredential {}

void main() {
  setupFirebaseAuthMocks();
  group('Register cubit test', () {
    late LoginState testState;

    setUp(() async {
      await Firebase.initializeApp();
      testState = LoginInitial();
      testState.loginForm.updateValue({
        LoginState.emailController: 'email@mail.com',
        LoginState.passwordController: '123456',
      });
    });

    test('Initial testState index is 0', () {
      expect(
        LoginCubit()
            .state
            .loginForm
            .controls[LoginState.emailController]!
            .value,
        null,
      );
    });

    blocTest<LoginCubit, LoginState>(
      'The cubit should be on index 1',
      build: () => LoginCubit()..emit(testState),
      act: (cubit) {
        cubit.login();
      },
      expect: () => [
        LoginLoading(
          loginForm: testState.loginForm,
        ),
      ],
    );
  });
}
