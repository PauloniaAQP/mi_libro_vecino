import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mi_libro_vecino/ui_utils/functions.dart';
import 'package:reactive_forms/reactive_forms.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  void nextPage() {
    emit(state.copyWith(index: state.index + 1));
  }

  void backPage() {
    emit(state.copyWith(index: state.index - 1));
  }

  Future<void> onTapUploadLibraryPhoto() async {
    emit(
      RegisterPhotoLoading(
        libraryInfoForm: state.libraryInfoForm,
        personInfoForm: state.personInfoForm,
        registerForm: state.registerForm,
        index: state.index,
      ),
    );
    final image = await uiPickImage();
    // TODO(oscarnar): Solve this error, convert XFile to File
    emit(state.copyWith(libraryPhoto: File(image!.path)));
  }

  Future<void> onTapUploadPersonalPhoto() async {
    emit(
      RegisterPhotoLoading(
        libraryInfoForm: state.libraryInfoForm,
        personInfoForm: state.personInfoForm,
        registerForm: state.registerForm,
        index: state.index,
      ),
    );  
    final image = await uiPickImage();
    // TODO(oscarnar): Solve this error, read Files on web
    emit(state.copyWith(personPhoto: File(image!.path)));
  }
}
