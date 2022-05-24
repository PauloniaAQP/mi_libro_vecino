import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mi_libro_vecino_api/services/auth_service.dart';
import 'package:mi_libro_vecino_api/utils/constants/enums/user_enums.dart'
    as status;
import 'package:reactive_forms/reactive_forms.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<status.LoginState?> login({bool isAdmin = false}) async {
    state.loginForm.markAllAsTouched();
    if (state.loginForm.invalid) return null;
    emit(LoginLoading(loginForm: state.loginForm));
    final email =
        state.loginForm.control(LoginState.emailController).value.toString();
    final password =
        state.loginForm.control(LoginState.passwordController).value.toString();
    try {
      final user = await AuthService.emailPasswordSignIn(
        email,
        password,
        isAdmin: isAdmin,
      );
      if (user != null) {
        emit(LoginSuccess(loginForm: state.loginForm));
        return status.LoginState.success;
      }
      return status.LoginState.unknownError;
    } catch (e) {
      return e as status.LoginState;
    }
  }

  void cleanPassword() {
    state.loginForm.control(LoginState.passwordController).value = '';
  }
}
