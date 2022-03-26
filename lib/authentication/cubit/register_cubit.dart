import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mi_libro_vecino/ui_utils/constans/globals.dart';
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
    Uint8List? imageBytes;
    if (image != null) {
      imageBytes = await image.readAsBytes();
    }
    emit(
      state.copyWith(
        libraryPhoto: image,
        libraryPhotoBytes: imageBytes,
      ),
    );
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
    Uint8List? imageBytes;
    if (image != null) {
      imageBytes = await image.readAsBytes();
    }
    emit(
      state.copyWith(
        personPhoto: image,
        personPhotoBytes: imageBytes,
      ),
    );
  }

  Future<void> onTapRegisterAndContinue() async {
    emit(state.copyWith(status: RegisterStatus.loading));
    state.registerForm.markAllAsTouched();
    state.personInfoForm.markAllAsTouched();
    state.libraryInfoForm.markAllAsTouched();
    if (!state.registerForm.valid &&
        !state.personInfoForm.valid &&
        !state.libraryInfoForm.valid) {
      emit(state.copyWith(status: RegisterStatus.error));
      return;
    }

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
    final user = await AuthService.emailPasswordSignUp(
      userEmail,
      userPassword,
      userName,
    );
    if (user == null) {
      emit(state.copyWith(status: RegisterStatus.error));
      return;
    }
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
      return;
    }
    final libraryValuesMap = state.libraryInfoForm.value;

    final libraryModel = await _libraryRepository.createLibrary(
      userId: userModel.id,
      name: libraryValuesMap[RegisterState.libraryNameController].toString(),
      type: LibraryType.values[int.parse(state.libraryRolController.text)],
      openingHour: fromStringToTimeOfDay(
        libraryValuesMap[RegisterState.openTimeController].toString(),
      ),
      closingHour: fromStringToTimeOfDay(
        libraryValuesMap[RegisterState.closeTimeController].toString(),
      ),
      address: libraryValuesMap[RegisterState.addressController].toString(),

      // TODO(oscarnar): get coodinates from map
      location: Coordinates(-51, -71),
      services: state.services.keys
          .where((key) => state.services[key] == true)
          .toList(),
      tags: state.libraryCategories,

      // TODO(oscarnar): get search keys
      searchKeys: state.libraryCategories,

      // TODO(oscarnar): get ubigeo code
      departmentId: '04',
      provinceId: '04',
      districtId: '04',
      description:
          libraryValuesMap[RegisterState.descriptionController].toString(),
      website: libraryValuesMap[RegisterState.websiteController].toString(),
      // TODO(oscarnar): Test photo upload functionality
      // photo: ,
    );
    if (libraryModel == null) {
      emit(state.copyWith(status: RegisterStatus.error));
      return;
    } else {
      emit(state.copyWith(status: RegisterStatus.success));
      return;
    }
  }

  // TODO: remove this function
  Future<void> testSuccess() async {
    await Future.delayed(
      const Duration(seconds: 2),
      () => 'HOla',
    );
    emit(state.copyWith(status: RegisterStatus.success));
  }

  UserRepository get _userRepository => Get.find();
  LibraryRepository get _libraryRepository => Get.find();
}
