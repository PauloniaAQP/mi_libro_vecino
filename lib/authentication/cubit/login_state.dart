part of 'login_cubit.dart';

class LoginState extends Equatable {
  const LoginState({
    required this.loginForm,
  });

  static const String emailController = 'email';
  static const String passwordController = 'password';
  final FormGroup loginForm;

  @override
  List<Object> get props => [loginForm];

  LoginState copyWith({
    required FormGroup loginForm,
  }) {
    return LoginState(
      loginForm: this.loginForm,
    );
  }
}

class LoginInitial extends LoginState {
  LoginInitial()
      : super(
          loginForm: FormGroup({
            LoginState.emailController: FormControl<String>(
              validators: [
                Validators.required,
                Validators.email,
              ],
            ),
            LoginState.passwordController: FormControl<String>(
              validators: [
                Validators.required,
                Validators.minLength(6),
              ],
            ),
          }),
        );
}

class LoginSuccess extends LoginState {
  const LoginSuccess({required FormGroup loginForm})
      : super(loginForm: loginForm);
}

class LoginLoading extends LoginState {
  const LoginLoading({required FormGroup loginForm})
      : super(loginForm: loginForm);
}

class LoginError extends LoginState {
  const LoginError({required FormGroup loginForm, required this.loginStatus})
      : super(loginForm: loginForm);
  final status.LoginState loginStatus;
}
