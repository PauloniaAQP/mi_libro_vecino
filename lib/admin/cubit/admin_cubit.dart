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

  /// This function loads the data from the repository
  /// If you want to force get data from database, you should
  /// use [cache] parameter as false.
  Future<void> fillData({bool cache = true}) async {
    try {
      _libraryRepository.getPendingLibraries(cache: cache).listen((libraries) {
        emit(state.copyWith(pendingLibraries: libraries));
      });
      final acceptedLibraries = await _libraryRepository.getAcceptedLibraries(
        cache: cache,
        resetPagination: true,
        limit: _pageSize,
      );
      if (acceptedLibraries.length < _pageSize) {
        isAllLibraries = true;
      }
      emit(state.copyWith(acceptedLibraries: acceptedLibraries));
    } catch (error, stracktrace) {
      PauloniaErrorService.sendError(error, stracktrace);
    }
  }

  /// Id [isAllLibraries] is true, it means that all libraries
  /// from repository are already loaded.
  Future<void> loadMoreLibraries({bool cache = true}) async {
    if (isAllLibraries) {
      return;
    }
    try {
      final newAcceptedLibraries = await _libraryRepository
          .getAcceptedLibraries(cache: cache, limit: _pageSize);
      state.acceptedLibraries?.addAll(newAcceptedLibraries);
      if (newAcceptedLibraries.length < _pageSize) {
        isAllLibraries = true;
      }
      emit(state.copyWith(acceptedLibraries: state.acceptedLibraries));
    } catch (error, stacktrace) {
      PauloniaErrorService.sendError(error, stacktrace);
      return;
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
      unawaited(fillData(cache: false));
      return;
    } else {
      return;
    }
  }

  Future<bool> removeLibrary(String id) async {
    final library = await _libraryRepository.getFromId(id);
    if (library == null) return false;
    final userId = library.ownerId;
    try {
      await _libraryRepository.removeLibrary(id);
      await _userRepository.removeUserById(userId);

      // TODO(oscanar): remove user from firebase with userId
      // await AuthService.removeUser();
      unawaited(fillData());
      return true;
    } catch (error, stracktrace) {
      PauloniaErrorService.sendError(error, stracktrace);
      return false;
    }
  }

  Future<void> signOut() async {
    try {
      await AuthService.signOut();
    } catch (error, stacktrace) {
      PauloniaErrorService.sendError(error, stacktrace);
    }
  }

  final UserRepository _userRepository = Get.find<UserRepository>();
  final LibraryRepository _libraryRepository = Get.find<LibraryRepository>();
  bool isAllLibraries = false;
  final _pageSize = 7;
}
