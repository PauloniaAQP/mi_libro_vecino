part of 'app_user_bloc.dart';

class AppUserState extends Equatable {
  const AppUserState({
    required this.status,
    this.currentLocation,
    this.currentUser,
  });

  final AuthenticationStatus status;
  final Coordinates? currentLocation;
  final UserModel? currentUser;

  @override
  List<Object> get props => [status, currentLocation ?? Coordinates(0, 0)];

  AppUserState copyWith({
    AuthenticationStatus? status,
    Coordinates? currentLocation,
    UserModel? currentUser,
  }) {
    return AppUserState(
      status: status ?? this.status,
      currentLocation: currentLocation ?? this.currentLocation,
      currentUser: currentUser ?? this.currentUser,
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
  }) : super(status: AuthenticationStatus.authenticated, currentUser: user);

  final UserModel user;
  final bool isAdmin;

  @override
  List<Object> get props => [user.id];
}
