import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:mi_libro_vecino_api/models/library_model.dart';
import 'package:mi_libro_vecino_api/models/user_model.dart';
import 'package:mi_libro_vecino_api/repositories/library_repository.dart';
import 'package:mi_libro_vecino_api/repositories/user_repository.dart';
import 'package:mi_libro_vecino_api/utils/constants/enums/ubigeo_enums.dart';
import 'package:paulonia_error_service/paulonia_error_service.dart';

part 'libraries_state.dart';

class LibrariesCubit extends Cubit<LibrariesState> {
  LibrariesCubit() : super(const LibrariesInitial());

  Future<void> loadLibraries(String ubigeoCode) async {
    emit(const LibrariesLoading());
    try {
      late UbigeoType type;
      if (ubigeoCode.length == 2) {
        type = UbigeoType.department;
      } else if (ubigeoCode.length == 4) {
        type = UbigeoType.province;
      } else {
        type = UbigeoType.district;
      }
      final libraries = await _libraryRepository.getLibrariesByUbigeo(
        type,
        ubigeoCode,
        resetPagination: true,
        limit: pageSize,
      );
      emit(LibrariesLoaded(libraries));
    } catch (e, stacktrace) {
      PauloniaErrorService.sendError(e, stacktrace);
      emit(const LibrariesError());
    }
  }

  /// Id [isAllLibraries] is true, it means that all libraries
  /// from repository are already loaded.
  Future<void> loadMoreLibraries(String ubigeoCode) async {
    if (isAllLibraries) {
      return;
    }
    try {
      late UbigeoType type;
      if (ubigeoCode.length == 2) {
        type = UbigeoType.department;
      } else if (ubigeoCode.length == 4) {
        type = UbigeoType.province;
      } else {
        type = UbigeoType.district;
      }
      final libraries = await _libraryRepository.getLibrariesByUbigeo(
        type,
        ubigeoCode,
        cache: true,
        limit: pageSize,
      );
      if (libraries.length < pageSize) isAllLibraries = true;
      state.libraries?.addAll(libraries);
      emit(LibrariesLoaded(state.libraries));
    } catch (e) {
      return;
    }
  }

  Future<void> getLibrary(String id) async {
    emit(const LibrariesLoading());
    try {
      final library = await _libraryRepository.getLibraryById(id);
      emit(LibrariesLoaded(state.libraries, currentLibrary: library));
    } catch (e) {
      emit(const LibrariesError());
    }
  }

  Future<UserModel?> getOwner(String id) async {
    try {
      final owner = await _userRepository.getFromId(id);
      return owner;
    } catch (e) {
      return null;
    }
  }

  final LibraryRepository _libraryRepository = Get.find<LibraryRepository>();
  final UserRepository _userRepository = Get.find<UserRepository>();
  bool isAllLibraries = false;
  final int pageSize = 7;
}
