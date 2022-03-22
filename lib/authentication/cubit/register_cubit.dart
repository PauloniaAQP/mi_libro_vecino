import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mi_libro_vecino/ui_utils/functions.dart';
import 'package:mi_libro_vecino_api/repositories/library_repository.dart';
import 'package:mi_libro_vecino_api/repositories/user_repository.dart';
import 'package:mi_libro_vecino_api/services/auth_service.dart';
import 'package:mi_libro_vecino_api/utils/constants/enums/library_enums.dart';
import 'package:mi_libro_vecino_api/utils/utils.dart';
import 'package:reactive_forms/reactive_forms.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  void nextPage() {
    emit(state.copyWith(index: state.index + 1));
  }

  void backPage() {
    emit(state.copyWith(index: state.index - 1));
  }

  /// For this function we need to make a deep copy of
  /// the services map in order to bloc can differentiate
  /// both states and rebuild the view
  void updateServices({required String key}) {
    final map = Map<String, bool>.from(state.services)
      ..update(key, (value) => !value);
    emit(
      state.copyWith(
        services: map,
      ),
    );
  }

  Future<void> onTapUploadLibraryPhoto() async {
    emit(
      RegisterPhotoLoading(
        libraryInfoForm: state.libraryInfoForm,
        personInfoForm: state.personInfoForm,
        registerForm: state.registerForm,
        index: state.index,
        services: state.services,
        closingController: state.closingController,
        libraryRolController: state.libraryRolController,
        openingController: state.openingController,
      ),
    );
    final image = await uiPickImage();
    // TODO(oscarnar): Solve this error, convert XFile to File
    emit(state.copyWith(libraryPhoto: File(image!.path)));
  }

  Future<void> onTapUploadPersonalPhoto() async {
    emit(
      RegisterPhotoLoading(
        libraryInfoForm: state.libraryInfoForm,
        personInfoForm: state.personInfoForm,
        registerForm: state.registerForm,
        index: state.index,
        services: state.services,
        closingController: state.closingController,
        libraryRolController: state.libraryRolController,
        openingController: state.openingController,
      ),
    );
    final image = await uiPickImage();
    // TODO(oscarnar): Solve this error, read Files on web
    emit(state.copyWith(personPhoto: File(image!.path)));
  }

  Future<void> onTapRegisterAndContinue() async {
    emit(
      state.copyWith(status: RegisterStatus.loading),
    );
    print('entrando a registrar');
    state.registerForm.markAllAsTouched();
    state.personInfoForm.markAllAsTouched();
    state.libraryInfoForm.markAllAsTouched();
    print(state.registerForm.valid);
    print(state.personInfoForm.valid);
    print(state.libraryInfoForm.valid);
    if (state.registerForm.valid &&
        state.personInfoForm.valid &&
        state.libraryInfoForm.valid) {
      print('forms have been validated');
      final userName = state.personInfoForm
          .control(RegisterState.fullnameController)
          .value
          .toString();
      final userEmail = state.registerForm
          .control(RegisterState.emailController)
          .value
          .toString();
      final userPassword = state.registerForm
          .control(RegisterState.passwordController)
          .value
          .toString();
      print('enter to auth service');
      final user = await AuthService.emailPasswordSignUp(
        userEmail,
        userPassword,
        userName,
      );
      if (user == null) {
        print('user is null');
        emit(state.copyWith(status: RegisterStatus.error));
        return;
      }
      //// YOU NEED TO PUT USER REPOSITORY (INTIALIZED)1
      print('User has been created');
      final userModel = await _userRepository.createUser(
        userId: user.uid,
        name: userName,
        email: userEmail,
        phone: state.personInfoForm
            .control(RegisterState.phoneController)
            .value
            .toString(),
      );
      if (userModel == null) {
        emit(state.copyWith(status: RegisterStatus.error));
        print('Error with user model creation');
        return;
      }
      print('User has been created into repository');
      final libraryValuesMap = state.personInfoForm.value;

      final libraryModel = await _libraryRepository.createLibrary(
        userId: userModel.id,
        name: libraryValuesMap[RegisterState.fullnameController].toString(),
        type: LibraryType.values[int.parse(state.libraryRolController.text)],
        openingHour: fromStringToTimeOfDay(
          libraryValuesMap[RegisterState.openTimeController].toString(),
        ),
        closingHour: fromStringToTimeOfDay(
          libraryValuesMap[RegisterState.closeTimeController].toString(),
        ),
        address: libraryValuesMap[RegisterState.addressController].toString(),

        /// TODO: get coodinates from map
        location: Coordinates(-51, -71),
        services: state.services.keys
            .where((key) => state.services[key] == true)
            .toList(),
        tags: state.libraryCategories,

        /// TODO: get search keys
        searchKeys: state.libraryCategories,

        /// TODO: get ubigeo code
        departmentId: '04',
        provinceId: '04',
        districtId: '04',
        description:
            libraryValuesMap[RegisterState.descriptionController].toString(),
        website: libraryValuesMap[RegisterState.websiteController].toString(),
        // photo: ,
      );
      print(libraryModel);
    }
  }

  UserRepository get _userRepository => Get.find();
  LibraryRepository get _libraryRepository => Get.find();
}
