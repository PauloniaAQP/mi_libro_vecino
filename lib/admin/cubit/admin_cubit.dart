import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'admin_state.dart';

class AdminCubit extends Cubit<AdminState> {
  AdminCubit() : super(AdminInitial());

  void onTapClearSearch() {
    emit(state.copyWith(isSearching: false));
  }

  void onSearchQueryChanged(String query) {
    if (query == '') {
      emit(AdminInitial());
    } else {
      emit(state.copyWith(isSearching: true));
    }
  }
}
