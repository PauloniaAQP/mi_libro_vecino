part of 'app_user_bloc.dart';

abstract class AppUserEvent extends Equatable {
  const AppUserEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationStatusChanged extends AppUserEvent {
  const AuthenticationStatusChanged(this.status);

  final AuthenticationStatus status;

  @override
  List<Object> get props => [status];
}

class LocationChanged extends AppUserEvent {
  const LocationChanged(this.location);

  final Coordinates location;

  @override
  List<Object> get props => [location];
}

class UpdateUser extends AppUserEvent {
  const UpdateUser();

  @override
  List<Object> get props => [];
}

class AppUserRegistering extends AppUserEvent {
  const AppUserRegistering();

  @override
  List<Object> get props => [];
}

class AppUserRegistered extends AppUserEvent {
  const AppUserRegistered();

  @override
  List<Object> get props => [];
}
