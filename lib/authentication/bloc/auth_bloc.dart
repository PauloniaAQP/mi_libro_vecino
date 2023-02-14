import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mi_libro_vecino/app/bloc/app_user_bloc.dart';
import 'package:mi_libro_vecino_api/services/auth_service.dart';
import 'package:mi_libro_vecino_api/utils/constants/enums/user_enums.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required this.appUserBloc}) : super(const AuthInitial()) {
    on<AuthLoginRequested>(_loginRequestedToState);
    on<AuthLogoutRequested>(_logoutRequestedToState);
  }

  final AppUserBloc appUserBloc;
  late final StreamSubscription appUserSubscription;

  FutureOr<void> _loginRequestedToState(
    AuthLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    try {
      final user = await AuthService.emailPasswordSignIn(
        event.email,
        event.password,
        isAdmin: event.isAdmin,
      );
      if (user == null) {
        final error = ArgumentError(LoginState.unknownError);
        throw error;
      }

      /// We need to listen if AppUserBloc is loaded (fetching user data)
      appUserSubscription = appUserBloc.stream.listen((state) {
        if (state is AppUserAuthenticated) {
          emit(const AuthSuccess());
        }
      });
    } catch (error) {
      emit(AuthError(error: error as LoginState));
    }
  }

  FutureOr<void> _logoutRequestedToState(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) {
    emit(const AuthLoading());
    AuthService.signOut();
    if (event.error != null) {
      emit(AuthError(error: event.error ?? LoginState.unknownError));
    } else {
      emit(const AuthInitial());
    }
  }

  @override
  Future<void> close() {
    appUserSubscription.cancel();
    return super.close();
  }
}
