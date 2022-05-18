import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mi_libro_vecino/ui_utils/functions.dart';
import 'package:mi_libro_vecino_api/models/library_model.dart';
import 'package:mi_libro_vecino_api/repositories/library_repository.dart';
import 'package:mi_libro_vecino_api/repositories/user_repository.dart';
import 'package:mi_libro_vecino_api/services/auth_service.dart';
import 'package:mi_libro_vecino_api/utils/constants/enums/library_enums.dart';
import 'package:mi_libro_vecino_api/utils/utils.dart';
import 'package:paulonia_error_service/paulonia_error_service.dart';
import 'package:reactive_forms/reactive_forms.dart';

part 'collaborator_state.dart';

class CollaboratorCubit extends Cubit<CollaboratorState> {
  CollaboratorCubit() : super(CollaboratorInitial());

  /// here the user and library should be loaded from the database
  /// If user is not logged in, the user should be redirected to the login page
  void initialCheck() {
    if (!AuthService.isLoggedIn()) {
      emit(CollaboratorError.fromState(state));
    }
  }

  /// If [wasFilled] is true, don't check nothing
  /// If [force] is active, check everything
  /// If user is not logged in, this emit an error to then
  /// be redirected to the login page
  Future<void> fillData({bool force = false}) async {
    if (force) wasFilled = false;
    if (wasFilled) return;

    if (AuthService.currentUser == null) {
      emit(CollaboratorError.fromState(state));
      return;
    }

    try {
      final user = await _userRepository
          .getUserFromCredentials(AuthService.currentUser!);
      final library = await _libraryRepository.getLibraryByOwnerId(user!.id);
      state.libraryInfoForm
          .control(CollaboratorState.libraryNameController)
          .value = library?.name;
      state.libraryInfoForm.control(CollaboratorState.websiteController).value =
          library?.website == 'null' ? '' : library?.website;
      state.libraryInfoForm
          .control(CollaboratorState.descriptionController)
          .value = library?.description;
      final closeTime = ApiUtils.timeOfDayToString(library!.closingHour);
      final openTime = ApiUtils.timeOfDayToString(library.openingHour);
      state.libraryInfoForm
          .control(CollaboratorState.openTimeController)
          .value = openTime.substring(0, 5);
      state.libraryInfoForm
          .control(CollaboratorState.closeTimeController)
          .value = closeTime.substring(0, 5);

      state.openingController.text = library.openingHour.hour > 12 ? '1' : '0';
      state.closingController.text = library.closingHour.hour > 12 ? '1' : '0';
      state.libraryRolController.text =
          LibraryType.values.indexOf(library.type).toString();
      state.libraryInfoForm.control(CollaboratorState.addressController).value =
          library.address;
      state.personalInfoForm
          .control(CollaboratorState.fullnameController)
          .value = user.name;
      state.personalInfoForm
          .control(CollaboratorState.phoneNumberController)
          .value = user.phone;
      final libraryImage =
          await (await downloadFileFromGsurl(library.gsUrl)).readAsBytes();
      final userImage =
          await (await downloadFileFromGsurl(user.gsUrl)).readAsBytes();

      wasFilled = true;
      emit(
        state.copyWith(
          location: library.location,
          libraryImage: libraryImage,
          userImage: userImage,
          library: library,
        ),
      );
    } catch (error, stacktrace) {
      PauloniaErrorService.sendError(error, stacktrace);
    }
  }

  void setMapLocation(Coordinates coordinates) {
    emit(state.copyWith(location: coordinates));
  }

  void fillUserData() {}

  Future<void> signOut() async {
    try {
      await AuthService.signOut();
      emit(CollaboratorInitial());
    } catch (error, stacktrace) {
      final newState = CollaboratorInitial();
      emit(CollaboratorError.fromState(newState));
      PauloniaErrorService.sendError(error, stacktrace);
    }
  }

  bool isAuthenticated() => AuthService.isLoggedIn();
  final UserRepository _userRepository = Get.find<UserRepository>();
  final LibraryRepository _libraryRepository = Get.find<LibraryRepository>();
  bool wasFilled = false;
}
