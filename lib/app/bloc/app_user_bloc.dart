import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:mi_libro_vecino_api/models/library_model.dart';
import 'package:mi_libro_vecino_api/models/user_model.dart';
import 'package:mi_libro_vecino_api/repositories/library_repository.dart';
import 'package:mi_libro_vecino_api/repositories/user_repository.dart';
import 'package:mi_libro_vecino_api/services/auth_service.dart';
import 'package:mi_libro_vecino_api/services/geo_service.dart'
    if (dart.library.io) 'package:mi_libro_vecino_api/services/test_geo_service.dart';
import 'package:mi_libro_vecino_api/utils/utils.dart';
import 'package:paulonia_error_service/paulonia_error_service.dart';
import 'package:paulonia_utils/paulonia_utils.dart';

part 'app_user_event.dart';
part 'app_user_state.dart';

class AppUserBloc extends Bloc<AppUserEvent, AppUserState> {
  AppUserBloc() : super(AppUserInitial()) {
    _userRepository = Get.find<UserRepository>();
    _libraryRepository = Get.find<LibraryRepository>();
    on<AppUserEvent>((event, emit) {});
    on<AppUserRegistering>((event, emit) => emit(const AppUserRegister()));
    on<AppUserRegistered>((event, emit) => emit(AppUserInitial()));
    on<UpdateUser>((event, emit) async {
      final user = AuthService.currentUser;
      if (user == null) {
        PauloniaErrorService.sendErrorWithoutStacktrace(state);
        return;
      }
      final userModel = await _userRepository.getUserFromCredentials(user);
      emit(state.copyWith(currentUser: userModel));
    });
    on<AuthenticationStatusChanged>((event, emit) async {
      emit(const AppUserLoading());
      try {
        if (event.status == AuthenticationStatus.unauthenticated) {
          emit(AppUserInitial());
          await checkLocation();
          return;
        } else {
          final user = AuthService.currentUser;
          if (user == null) {
            PauloniaErrorService.sendErrorWithoutStacktrace(state);
            return;
          }
          final isAdmin = await AuthService.isAdmin(user);
          final userModel = await _userRepository.getUserFromCredentials(user);
          if (userModel != null) {
            final libraryModel =
                await _libraryRepository.getLibraryByOwnerId(userModel.id);
            if (libraryModel == null && !isAdmin) {
              emit(const AppUserDisabled(wasRejected: true));
              await AuthService.signOut();
            } else {
              emit(
                AppUserAuthenticated(
                  user: userModel,
                  isAdmin: isAdmin,
                  library: libraryModel,
                ),
              );
            }
          } else {
            emit(const AppUserDisabled());
            await AuthService.signOut();
          }
        }
      } catch (state, stacktrace) {
        PauloniaErrorService.sendError(state, stacktrace);
        emit(AppUserInitial());
      }
    });
    on<LocationChanged>((event, emit) {
      emit(state.copyWith(currentLocation: event.location));
    });
    _authenticationStatusSubscription = AuthService.status.listen(
      (status) {
        if (state is AppUserRegister) return;
        add(AuthenticationStatusChanged(status));
      },
    );
    _initialCheck();
  }

  late StreamSubscription<AuthenticationStatus>
      _authenticationStatusSubscription;

  @override
  Future<void> close() {
    _authenticationStatusSubscription.cancel();
    return super.close();
  }

  Future<void> _initialCheck() async {
    if (AuthService.isLoggedIn()) {
      add(
        const AuthenticationStatusChanged(AuthenticationStatus.authenticated),
      );
    }
    await checkLocation();
  }

  Future<void> checkLocation() async {
    try {
      late Coordinates location;
      if (PUtils.isOnTest()) {
        location = Coordinates(-16.4006143, -71.5348195);
      } else {
        location = await GeoService.determineCoordinates();
      }
      add(LocationChanged(location));
    } catch (error) {
      PauloniaErrorService.sendErrorWithoutStacktrace(error);
    }
  }

  late final UserRepository _userRepository;
  late final LibraryRepository _libraryRepository;
}
