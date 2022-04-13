import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mi_libro_vecino/authentication/cubit/register_cubit.dart';
import 'package:mi_libro_vecino_api/services/auth_service.dart';
import 'package:mi_libro_vecino_api/utils/utils.dart' as utils;
import 'package:mocktail/mocktail.dart';

import '../../firebase_mock.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockUserCredential extends Mock implements UserCredential {}

class MockAuthService extends Mock implements AuthService {}

class MockUiPick extends Mock {
  Future<XFile?> uiPickImage();
}

void main() {
  setupFirebaseAuthMocks();
  group('Register cubit test', () {
    late utils.Coordinates coordinates;
    late RegisterState testState;

    setUp(() async {
      await Firebase.initializeApp();
      coordinates = utils.Coordinates(-17, -51);
      testState = RegisterInitial();
      testState.libraryInfoForm.updateValue(
        {
          RegisterState.addressController: 'address',
          RegisterState.closeTimeController: '12:12',
          RegisterState.libraryNameController: 'library name',
          RegisterState.openTimeController: '12:12',
          RegisterState.fullnameController: 'fullname',
          RegisterState.websiteController: 'website',
          RegisterState.descriptionController: 'description',
        },
      );
      testState.personInfoForm.updateValue(
        {
          RegisterState.phoneController: '123456789',
          RegisterState.fullnameController: 'fullname',
        },
      );
      testState.registerForm.updateValue(
        {
          RegisterState.emailController: 'test@asd.com',
          RegisterState.passwordController: '123456789',
          RegisterState.confirmPasswordController: '123456789',
        },
      );
    });

    test('Initial testState index is 0', () {
      expect(RegisterCubit().state.index, 0);
    });

    blocTest<RegisterCubit, RegisterState>(
      'The cubit should be on index 1',
      build: () => RegisterCubit(),
      act: (cubit) => cubit.setMapLocation(coordinates),
      expect: () => [
        RegisterInitial().copyWith(location: coordinates),
      ],
    );

    blocTest<RegisterCubit, RegisterState>(
      'Update services',
      build: () => RegisterCubit(),
      act: (cubit) {
        cubit.updateServices(key: 'Presto libros');
      },
      expect: () => [
        testState.copyWith(
          services: {
            'Presto libros': true,
            'Vendo libros': false,
            'Edito libros': false,
            'Recomiendo libros': false,
          },
        ),
      ],
    );

    // TODO(oscarnar): test for pick image (u can use the mocktail library)
    // blocTest<RegisterCubit, RegisterState>(
    //   'tap on upload library photo',
    //   build: () => RegisterCubit()..emit(testState),
    //   act: (cubit) {
    //     cubit.onTapUploadLibraryPhoto();
    //   },
    //   expect: () => [RegisterPhotoLoading(testState)],
    // );

    // blocTest<RegisterCubit, RegisterState>(
    //   'tap on upload personal photo',
    //   build: () => RegisterCubit()..emit(testState),
    //   act: (cubit) {
    //     cubit.onTapUploadPersonalPhoto();
    //   },
    //   expect: () => [RegisterPhotoLoading(testState)],
    // );

    blocTest<RegisterCubit, RegisterState>(
      'The cubit should register a new library and account',
      build: () => RegisterCubit()..emit(testState),
      act: (cubit) {
        cubit.onTapRegisterAndContinue();
      },
      // expect: () => [
      //   // testState.copyWith(status: RegisterStatus.success),
      // ],
    );
  });
}
