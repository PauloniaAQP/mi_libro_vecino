part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthStarted extends AuthEvent {}

class AuthLoginRequested extends AuthEvent {
  const AuthLoginRequested(this.email, this.password, {this.isAdmin = false});

  final String email;
  final String password;
  final bool isAdmin;

  @override
  List<Object> get props => [email, password, isAdmin];
}

class AuthLogoutRequested extends AuthEvent {
  const AuthLogoutRequested({this.error});

  final LoginState? error;

  @override
  List<Object> get props => [];
}
