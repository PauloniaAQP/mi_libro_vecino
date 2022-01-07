import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'libraries_state.dart';

class LibrariesCubit extends Cubit<LibrariesState> {
  LibrariesCubit() : super(LibrariesInitial());
}
