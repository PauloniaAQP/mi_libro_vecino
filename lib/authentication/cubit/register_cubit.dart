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
import 'package:mi_libro_vecino_api/services/geo_service.dart'
    if (dart.library.io) 'package:mi_libro_vecino_api/services/test_geo_service.dart';
import 'package:mi_libro_vecino_api/utils/constants/enums/library_enums.dart';
import 'package:mi_libro_vecino_api/utils/utils.dart';
import 'package:paulonia_error_service/paulonia_error_service.dart';
import 'package:reactive_forms/reactive_forms.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  void nextPage() {
    if (_validateFieldsInPage(state.index)) {
      emit(state.copyWith(index: state.index + 1));
    }
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
      RegisterPhotoLoading(state),
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
      RegisterPhotoLoading(state),
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
    state.registerForm.markAllAsTouched();
    state.personInfoForm.markAllAsTouched();
    state.libraryInfoForm.markAllAsTouched();
    if (!state.registerForm.valid &&
        !state.personInfoForm.valid &&
        !state.libraryInfoForm.valid) {
      return;
    }
    try {
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
      var user = await AuthService.emailPasswordSignUp(
        userEmail,
        userPassword,
        userName,
      );
      if (user == null) {
        try {
          user = await AuthService.emailPasswordSignIn(userEmail, userPassword);
        } catch (error, stacktrace) {
          PauloniaErrorService.sendError(error, stacktrace);
          final newState = RegisterInitial();
          emit(newState.copyWith(status: RegisterStatus.error));
          return;
        }
      }
      if (user == null) {
        final newState = RegisterInitial();
        emit(newState.copyWith(status: RegisterStatus.error));
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
        photo: state.personPhoto,
      );

      if (userModel == null) {
        await AuthService.removeUser(user);
        final newState = RegisterInitial();
        emit(newState.copyWith(status: RegisterStatus.error));
        return;
      }
      final libraryValuesMap = state.libraryInfoForm.value;

      final ubigeoModel =
          await GeoService.getUbigeoFromCoordinates(state.location);
      if (ubigeoModel == null) {
        await _userRepository.removeUserById(userModel.id);
        await AuthService.removeUser(user);
        final newState = RegisterInitial();
        emit(newState.copyWith(status: RegisterStatus.error));
        return;
      }

      if (!AuthService.isLoggedIn()) {
        final userLogged =
            await AuthService.emailPasswordSignIn(userEmail, userPassword);
        if (userLogged == null) {
          await _userRepository.removeUserById(userModel.id);
          await AuthService.removeUser(user);
          final newState = RegisterInitial();
          emit(newState.copyWith(status: RegisterStatus.error));
          return;
        }
      }

      final libraryModel = await _libraryRepository.createLibrary(
        userId: user.uid,
        name: libraryValuesMap[RegisterState.libraryNameController].toString(),
        type: LibraryType.values[int.parse(state.libraryRolController.text)],
        openingHour: fromStringToTimeOfDay(
          libraryValuesMap[RegisterState.openTimeController].toString(),
        ),
        closingHour: fromStringToTimeOfDay(
          libraryValuesMap[RegisterState.closeTimeController].toString(),
        ),
        address: libraryValuesMap[RegisterState.addressController].toString(),
        location: state.location!,
        services: state.services.keys
            .where((key) => state.services[key] == true)
            .toList(),
        tags: libraryValuesMap[RegisterState.libraryLabelsController]
                ?.toString()
                .split(',') ??
            [],

        // TODO(oscarnar): get search keys
        searchKeys: state.libraryCategories,

        departmentId: ubigeoModel.departmentId,
        provinceId: ubigeoModel.provinceId!,
        districtId: ubigeoModel.districtId!,
        description:
            libraryValuesMap[RegisterState.descriptionController].toString(),
        website: libraryValuesMap[RegisterState.websiteController].toString(),
        photo: state.libraryPhoto,
      );
      if (libraryModel == null) {
        await AuthService.removeUser(user);
        await _userRepository.removeUserById(userModel.id);
        final newState = RegisterInitial();
        emit(newState.copyWith(status: RegisterStatus.error));
        return;
      } else {
        final newState = RegisterInitial();
        await AuthService.signOut();
        emit(newState.copyWith(status: RegisterStatus.success));
        return;
      }
    } catch (error, stacktrace) {
      PauloniaErrorService.sendError(error, stacktrace);
      final newState = RegisterInitial();
      emit(newState.copyWith(status: RegisterStatus.error));
    }
  }

  void setMapLocation(Coordinates coordinates) {
    emit(state.copyWith(location: coordinates));
  }

  /// Validate fields in the current index page
  /// Photos are optional
  bool _validateFieldsInPage(int index) {
    switch (index) {
      case 0:
        state.registerForm.markAllAsTouched();
        return state.registerForm.valid;
      case 1:
        state.personInfoForm.markAllAsTouched();
        return state.personInfoForm.valid;
      case 2:
        return true;
      case 3:
        final nameValid = state.libraryInfoForm
                .controls[RegisterState.libraryNameController]?.valid ??
            false;
        final websiteValid = state.libraryInfoForm
                .controls[RegisterState.websiteController]?.valid ??
            false;
        final descriptionValid = state.libraryInfoForm
                .controls[RegisterState.descriptionController]?.valid ??
            false;
        final openValid = state.libraryInfoForm
                .controls[RegisterState.openTimeController]?.valid ??
            false;
        final closeValid = state.libraryInfoForm
                .controls[RegisterState.closeTimeController]?.valid ??
            false;
        var openTimeOfDay = fromStringToTimeOfDay(
          state.libraryInfoForm
              .control(RegisterState.openTimeController)
              .value
              .toString(),
        );
        var closeTimeOfDay = fromStringToTimeOfDay(
          state.libraryInfoForm
              .control(RegisterState.closeTimeController)
              .value
              .toString(),
        );

        /// Check if hour is PM to normalize it (24 hours)
        if (state.openingController.text == '1') {
          openTimeOfDay =
              openTimeOfDay.replacing(hour: openTimeOfDay.hour + 12);
        }
        if (state.closingController.text == '1') {
          closeTimeOfDay =
              closeTimeOfDay.replacing(hour: closeTimeOfDay.hour + 12);
        }
        final isScheduleValid = closeTimeOfDay.difference(openTimeOfDay) > 0;
        emit(state.copyWith(isScheduleValid: isScheduleValid));
        return nameValid &&
            websiteValid &&
            descriptionValid &&
            openValid &&
            closeValid &&
            isScheduleValid;
      case 4:
        return state.services.values.any((value) => value == true);
      case 5:
        return state.libraryInfoForm.controls[RegisterState.addressController]
                ?.valid ??
            false;
      case 6:
        return true;
      default:
        return false;
    }
  }

  UserRepository get _userRepository => Get.find();
  LibraryRepository get _libraryRepository => Get.find();
}

extension on TimeOfDay {
  int difference(TimeOfDay other) {
    final totalThis = hour * 60 + minute;
    final totalOther = other.hour * 60 + other.minute;
    return totalThis - totalOther;
  }
}
