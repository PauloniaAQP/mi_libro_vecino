part of 'app_user_bloc.dart';

class AppUserState extends Equatable {
  const AppUserState({
    required this.status,
    this.currentLocation,
  });

  final AuthenticationStatus status;
  final Coordinates? currentLocation;

  @override
  List<Object> get props => [status, currentLocation ?? Coordinates(0, 0)];

  AppUserState copyWith({
    AuthenticationStatus? status,
    Coordinates? currentLocation,
  }) {
    return AppUserState(
      status: status ?? this.status,
      currentLocation: currentLocation ?? this.currentLocation,
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
