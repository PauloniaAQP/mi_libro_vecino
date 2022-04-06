import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mi_libro_vecino_api/models/user_model.dart';
import 'package:mi_libro_vecino_api/repositories/user_repository.dart';
import 'package:mi_libro_vecino_api/services/auth_service.dart';
import 'package:mi_libro_vecino_api/services/geo_service.dart';
import 'package:mi_libro_vecino_api/utils/utils.dart';
import 'package:paulonia_error_service/paulonia_error_service.dart';

part 'app_user_event.dart';
part 'app_user_state.dart';

class AppUserBloc extends Bloc<AppUserEvent, AppUserState> {
  AppUserBloc(this._userRepository) : super(const AppUserInitial()) {
    on<AppUserEvent>((event, emit) {});
    on<AuthenticationStatusChanged>((event, emit) async {
      try {
        if (event.status == AuthenticationStatus.unauthenticated) {
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
            emit(AppUserAuthenticated(user: userModel, isAdmin: isAdmin));
          } else {
            await AuthService.signOut();
          }
        }
      } catch (state, stacktrace) {
        PauloniaErrorService.sendError(state, stacktrace);
      }
    });
    on<LocationChanged>((event, emit) {
      emit(state.copyWith(currentLocation: event.location));
    });
    _authenticationStatusSubscription = AuthService.status.listen(
      (status) {
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
      final location = await GeoService.determineCoordinates();
      add(LocationChanged(location));
    } catch (error) {
      PauloniaErrorService.sendErrorWithoutStacktrace(error);
    }
  }

  final UserRepository _userRepository;
}
