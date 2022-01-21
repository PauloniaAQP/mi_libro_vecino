import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mi_libro_vecino/collaborators/cubit/collaborator_cubit.dart';
import 'package:mi_libro_vecino/collaborators/view/collaborators_page.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/pump_app.dart';

class MockCollaboratorCubit extends MockCubit<CollaboratorState>
    implements CollaboratorCubit {}

void main() {
  group('Collaborators personal info page', () {
    late CollaboratorCubit collaboratorCubit;

    setUp(() {
      collaboratorCubit = MockCollaboratorCubit();
    });

    testWidgets('renders Collaborators info Page', (tester) async {
      final state = CollaboratorInitial();
      when(() => collaboratorCubit.state).thenReturn(state);
      await tester.pumpApp(
        BlocProvider.value(
          value: collaboratorCubit,
          child: const CollaboratorsPage(),
        ),
      );
      expect(
        find.text(
          'Información personal',
        ),
        findsOneWidget,
      );
    });

    testWidgets('renders Collaborators lirbary Page', (tester) async {
      final state = CollaboratorInitial();
      when(() => collaboratorCubit.state).thenReturn(state);
      await tester.pumpApp(
        BlocProvider.value(
          value: collaboratorCubit,
          child: const CollaboratorsPage(index: 1),
        ),
      );
      expect(
        find.byKey(
          const Key('collaborators_library_form'),
        ),
        findsOneWidget,
      );
    });
  });
}
