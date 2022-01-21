import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'admin_state.dart';

class AdminCubit extends Cubit<AdminState> {
  AdminCubit() : super(AdminInitial());
}
