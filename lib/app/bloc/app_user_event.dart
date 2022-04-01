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
