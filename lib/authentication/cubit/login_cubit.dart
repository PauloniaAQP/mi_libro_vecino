import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:reactive_forms/reactive_forms.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
}
