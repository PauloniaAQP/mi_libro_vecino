import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

part 'collaborator_state.dart';

class CollaboratorCubit extends Cubit<CollaboratorState> {
  CollaboratorCubit() : super(CollaboratorInitial());
}
