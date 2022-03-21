part of 'app_user_bloc.dart';

class AppUserState extends Equatable {
  const AppUserState({
    required this.status,
  });

  final AuthenticationStatus status;

  @override
  List<Object> get props => [status];

  AppUserState copyWith({
    AuthenticationStatus? status,
  }) {
    return AppUserState(
      status: status ?? this.status,
    );
  }
}

class AppUserInitial extends AppUserState {
  const AppUserInitial() : super(status: AuthenticationStatus.unauthenticated);
}

class AppUserAuthenticated extends AppUserState {
  const AppUserAuthenticated({
    required this.user,
    this.isAdmin = false,
  }) : super(status: AuthenticationStatus.authenticated);

  final UserModel user;
  final bool isAdmin;

  @override
  List<Object> get props => [user.id];
}
