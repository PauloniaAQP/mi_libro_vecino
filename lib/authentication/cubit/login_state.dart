part of 'login_cubit.dart';

abstract class LoginState extends Equatable {
  const LoginState({
    required this.loginForm,
  });

  static const String emailController = 'email';
  static const String passwordController = 'password';
  final FormGroup loginForm;

  @override
  List<Object> get props => [loginForm];
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
