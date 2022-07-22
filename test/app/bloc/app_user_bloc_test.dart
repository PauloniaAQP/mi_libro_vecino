import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mi_libro_vecino/app/bloc/app_user_bloc.dart';
import 'package:mi_libro_vecino_api/repositories/user_repository.dart';
import 'package:mi_libro_vecino_api/services/auth_service.dart';
import 'package:mi_libro_vecino_api/utils/utils.dart' as utils;

import '../../firebase_mock.dart';

void main() {
  setupFirebaseAuthMocks();
  group('Register cubit test', () {
    late utils.Coordinates coordinates;

    setUp(() async {
      await Firebase.initializeApp();
      coordinates = utils.Coordinates(0, 0);
      Get.put(UserRepository(), permanent: true);
    });

    test('Initial state index is 0', () {
      expect(AppUserBloc().state.status, AuthenticationStatus.unauthenticated);
    });

    blocTest<AppUserBloc, AppUserState>(
      'The cubit should be on index 1',
      setUp: () {
        Firebase.initializeApp();
      },
      build: () => AppUserBloc(),
      act: (bloc) => null,
      expect: () => [
        AppUserInitial().copyWith(currentLocation: coordinates),
      ],
    );
  });
}
