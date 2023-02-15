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
import 'package:mi_libro_vecino_api/services/geo_service.dart'
    if (dart.library.io) 'package:mi_libro_vecino_api/services/test_geo_service.dart';
import 'package:mi_libro_vecino_api/utils/constants/enums/library_enums.dart';
import 'package:mi_libro_vecino_api/utils/utils.dart';
import 'package:paulonia_error_service/paulonia_error_service.dart';
import 'package:paulonia_utils/paulonia_utils.dart';
import 'package:reactive_forms/reactive_forms.dart';

part 'collaborator_state.dart';

class CollaboratorCubit extends Cubit<CollaboratorState> {
  CollaboratorCubit() : super(CollaboratorInitial());

  bool get personalInfoWasTouched => _personalInfoWasTouched;
  bool get libraryInfoWasTouched => _libraryInfoWasTouched;

  /// here the user and library should be loaded from the database
  /// If user is not logged in, the user should be redirected to the login page
  void initialCheck() {
    if (!AuthService.isLoggedIn()) {
      emit(CollaboratorError.fromState(state));
    }
  }

  void maskAsTouchedPersonalInfo() {
    _personalInfoWasTouched = true;
  }

  void maskAsTouchedLibraryInfo() {
    _libraryInfoWasTouched = true;
  }

  /// If [wasFilled] is true, don't check nothing
  /// If [force] is active, check everything
  /// If user is not logged in, this emit an error to then
  /// be redirected to the login page
  Future<void> fillData({bool force = false}) async {
    if (PUtils.isOnTest()) {
      return;
    }
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
      state.libraryInfoForm
          .control(CollaboratorState.libraryLabelsController)
          .value = convertTagsToString(library.tags);
      final libraryImage =
          await (await downloadFileFromGsurl(library.gsUrl)).readAsBytes();
      final userImage =
          await (await downloadFileFromGsurl(user.gsUrl)).readAsBytes();

      final services = _getServices(library.services, state.services);

      if (!wasFilled) {
        initialState = state.copyWith(
          location: library.location,
          libraryImage: libraryImage,
          userImage: userImage,
          library: library,
          services: services,
        );
      }
      wasFilled = true;
      emit(
        state.copyWith(
          location: library.location,
          libraryImage: libraryImage,
          userImage: userImage,
          library: library,
          services: services,
        ),
      );

      return;
    } catch (error, stacktrace) {
      PauloniaErrorService.sendError(error, stacktrace);
      return;
    }
  }

  void setMapLocation(Coordinates coordinates) {
    emit(state.copyWith(location: coordinates));
  }

  /// use the map inside forms to check if some value change
  /// but be careful because you need make deep copies of the objects
  /// map.fromMap() maybe works
  bool isActiveSaveUserButton() {
    return state.isEqualUser(initialState);
  }

  bool isActiveSaveLibraryButton() {
    return state.isEqualLibrary(initialState);
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

  String convertTagsToString(List<String> tags) {
    return tags.join(', ');
  }

  Future<void> onTapSaveUser() async {
    state.personalInfoForm.markAllAsTouched();
    if (state.personalInfoForm.invalid) {
      return;
    }
    try {
      final oldUser = await _userRepository
          .getUserFromCredentials(AuthService.currentUser!);
      if (oldUser == null) return;

      await _userRepository.updateUser(
        oldUser,
        name: state.personalInfoForm
            .control(CollaboratorState.fullnameController)
            .value
            .toString(),
        phone: state.personalInfoForm
            .control(CollaboratorState.phoneNumberController)
            .value
            .toString(),
        // photo: state.personPhoto,
      );
    } catch (error, stacktrace) {
      PauloniaErrorService.sendError(error, stacktrace);
    }
  }

  Future<void> onTapSaveLibrary() async {
    state.libraryInfoForm.markAllAsTouched();
    if (state.libraryInfoForm.invalid) {
      return;
    }
    try {
      final libraryValuesMap = state.libraryInfoForm.value;

      final ubigeoModel =
          await GeoService.getUbigeoFromCoordinates(state.location);
      if (ubigeoModel == null) {
        return;
      }

      if (state.library == null) return;

      final newLibraryModel = await _libraryRepository.updateLibrary(
        state.library!,
        ownerId: state.library?.ownerId,
        name: libraryValuesMap[CollaboratorState.libraryNameController]
            .toString(),
        type: LibraryType.values[int.parse(state.libraryRolController.text)],
        openingHour: fromStringToTimeOfDay(
          libraryValuesMap[CollaboratorState.openTimeController].toString(),
        ),
        closingHour: fromStringToTimeOfDay(
          libraryValuesMap[CollaboratorState.closeTimeController].toString(),
        ),
        address:
            libraryValuesMap[CollaboratorState.addressController].toString(),
        location: state.location,
        services: state.services.keys
            .where((key) => state.services[key] == true)
            .toList(),
        tags: libraryValuesMap[CollaboratorState.libraryLabelsController]
            .toString()
            .split(','),

        // TODO(oscarnar): get search keys
        searchKeys: libraryValuesMap[CollaboratorState.libraryLabelsController]
            .toString()
            .split(','),

        departmentId: ubigeoModel.departmentId,
        provinceId: ubigeoModel.provinceId,
        districtId: ubigeoModel.districtId,
        description: libraryValuesMap[CollaboratorState.descriptionController]
            .toString(),
        website:
            libraryValuesMap[CollaboratorState.websiteController].toString(),
        // photo: state.libraryPhoto,
      );
      if (newLibraryModel == null) {
        return;
      } else {
        emit(state.copyWith(library: newLibraryModel));
        return;
      }
    } catch (error, stacktrace) {
      PauloniaErrorService.sendError(error, stacktrace);
    }
  }

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

  Map<String, bool> _getServices(
    List<String> services,
    Map<String, bool> servicesMap,
  ) {
    for (final service in services) {
      servicesMap[service] = true;
    }
    return servicesMap;
  }

  bool isAuthenticated() => AuthService.isLoggedIn();
  final UserRepository _userRepository = Get.find<UserRepository>();
  final LibraryRepository _libraryRepository = Get.find<LibraryRepository>();
  bool wasFilled = false;
  CollaboratorState initialState = CollaboratorInitial();
  bool _personalInfoWasTouched = false;
  bool _libraryInfoWasTouched = false;
}
