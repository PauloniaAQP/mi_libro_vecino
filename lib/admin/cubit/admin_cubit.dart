import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mi_libro_vecino_api/models/library_model.dart';
import 'package:mi_libro_vecino_api/models/user_model.dart';
import 'package:mi_libro_vecino_api/repositories/library_repository.dart';
import 'package:mi_libro_vecino_api/repositories/user_repository.dart';
import 'package:mi_libro_vecino_api/services/auth_service.dart';
import 'package:paulonia_error_service/paulonia_error_service.dart';

part 'admin_state.dart';

class AdminCubit extends Cubit<AdminState> {
  AdminCubit() : super(AdminInitial());

  void onTapClearSearch() {
    emit(state.copyWith(isSearching: false));
  }

  void onSearchQueryChanged(String query) {
    if (query == '') {
      emit(state.copyWith(isSearching: false));
    } else {
      emit(state.copyWith(isSearching: true));
    }
  }

  Future<void> init() async {
    if (initDataCharged) return;

    // TODO(oscarnar): Fix issues in library repository
    // When gets pending libraries, we don't get accepted
    // And is the same when gets accepted first
    try {
      final user = await _userRepository
          .getUserFromCredentials(AuthService.currentUser!);
      final acceptedLibraries = await _libraryRepository.getAcceptedLibraries();
      _libraryRepository.getPendingLibraries().listen((libraries) {
        emit(
          state.copyWith(
            pendingLibraries: libraries,
            user: user,
          ),
        );
      });

      emit(state.copyWith(acceptedLibraries: acceptedLibraries, user: user));
      initDataCharged = true;
    } catch (error, stracktrace) {
      PauloniaErrorService.sendError(error, stracktrace);
    }
  }

  Future<LibraryModel?> getLibrary(String libraryId) async {
    try {
      final library = await _libraryRepository.getLibraryById(libraryId);
      return library;
    } catch (error, stracktrace) {
      PauloniaErrorService.sendError(error, stracktrace);
      return null;
    }
  }

  Future<UserModel?> getUser(String userId) async {
    try {
      final user = await _userRepository.getFromId(userId);
      return user;
    } catch (error, stracktrace) {
      PauloniaErrorService.sendError(error, stracktrace);
      return null;
    }
  }

  Future<void> acceptLibrary(String id) async {
    final response = await _libraryRepository.acceptLibrary(id);
    if (response == true) {
      initDataCharged = false;
      emit(state);
    } else {
      return;
    }
  }

  Future<void> removeLibrary(String id) async {
    await _libraryRepository.removeLibrary(id);

    // TODO(oscarnar): User should be remove with the library?
    initDataCharged = false;
    emit(state);
  }

  Future<void> signOut() async {
    try {
      await AuthService.signOut();
    } catch (error, stacktrace) {
      PauloniaErrorService.sendError(error, stacktrace);
    }
  }

  bool initDataCharged = false;
  final UserRepository _userRepository = Get.find<UserRepository>();
  final LibraryRepository _libraryRepository = Get.find<LibraryRepository>();
}
