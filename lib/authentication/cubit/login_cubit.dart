import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mi_libro_vecino_api/services/auth_service.dart';
import 'package:reactive_forms/reactive_forms.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> login() async {
    emit(LoginLoading(loginForm: state.loginForm));
    final email =
        state.loginForm.control(LoginState.emailController).value.toString();
    final password =
        state.loginForm.control(LoginState.passwordController).value.toString();
    final user = await AuthService.emailPasswordSignIn(email, password);
    switch (user) {
      case null:
        emit(LoginError(loginForm: state.loginForm));
        break;
      default:
        emit(LoginSuccess(loginForm: state.loginForm));
    }
  }
}
