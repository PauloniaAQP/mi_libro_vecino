part of 'app_user_bloc.dart';

class AppUserState extends Equatable {
  const AppUserState({
    required this.status,
    this.currentLocation,
    this.currentUser,
    this.currentLibrary,
    this.isAdmin = false,
  });

  final AuthenticationStatus status;
  final Coordinates? currentLocation;
  final UserModel? currentUser;
  final LibraryModel? currentLibrary;
  final bool isAdmin;

  @override
  List<Object> get props =>
      [status, currentLocation ?? Coordinates(-16.4006143, -71.5348195)];

  AppUserState copyWith({
    AuthenticationStatus? status,
    Coordinates? currentLocation,
    UserModel? currentUser,
    LibraryModel? currentLibrary,
  }) {
    return AppUserState(
      status: status ?? this.status,
      currentLocation: currentLocation ?? this.currentLocation,
      currentUser: currentUser ?? this.currentUser,
      currentLibrary: currentLibrary ?? this.currentLibrary,
    );
  }
}

class AppUserInitial extends AppUserState {
  AppUserInitial()
      : super(
          status: AuthenticationStatus.unauthenticated,
          currentLocation: Coordinates(-16.4006143, -71.5348195),
        );
}

class AppUserAuthenticated extends AppUserState {
  const AppUserAuthenticated({
    required this.user,
    this.library,
    bool isAdmin = false,
  }) : super(
          status: AuthenticationStatus.authenticated,
          currentUser: user,
          isAdmin: isAdmin,
          currentLibrary: library,
        );

  final UserModel user;
  final LibraryModel? library;

  @override
  List<Object> get props => [user.id];
}

class AppUserDisabled extends AppUserState {
  const AppUserDisabled({
    this.wasRejected = false,
  }) : super(status: AuthenticationStatus.authenticated);

  final bool wasRejected;

  @override
  List<Object> get props => [wasRejected];
}

class AppUserLoading extends AppUserState {
  const AppUserLoading() : super(status: AuthenticationStatus.authenticating);
}

class AppUserRegister extends AppUserState {
  const AppUserRegister() : super(status: AuthenticationStatus.authenticating);
}
