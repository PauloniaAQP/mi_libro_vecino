import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mi_libro_vecino_api/models/user_model.dart';
import 'package:mi_libro_vecino_api/services/auth_service.dart';

part 'app_user_event.dart';
part 'app_user_state.dart';

class AppUserBloc extends Bloc<AppUserEvent, AppUserState> {
  AppUserBloc() : super(const AppUserInitial()) {
    on<AppUserEvent>((event, emit) {
      // TODO: implement event handler
    });
    _authenticationStatusSubscription = AuthService.status.listen(
      (status) => add(AuthenticationStatusChanged(status)),
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

  void _initialCheck() {
    if (AuthService.isLoggedIn()) {
      add(
        const AuthenticationStatusChanged(AuthenticationStatus.authenticated),
      );
    }
  }
}
