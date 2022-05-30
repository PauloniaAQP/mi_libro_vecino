import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mi_libro_vecino/app/bloc/app_user_bloc.dart';
import 'package:mi_libro_vecino/collaborators/cubit/collaborator_cubit.dart';
import 'package:mi_libro_vecino/collaborators/view/collaborators_page.dart';
import 'package:mocktail/mocktail.dart';
import 'package:paulonia_cache_image/paulonia_cache_image.dart';

import '../../helpers/pump_app.dart';

class MockCollaboratorCubit extends MockCubit<CollaboratorState>
    implements CollaboratorCubit {}

class MockAppUserBloc extends MockCubit<AppUserState> implements AppUserBloc {}

void main() {
  group('Collaborators personal info page', () {
    late CollaboratorCubit collaboratorCubit;
    late AppUserBloc appUserBloc;

    setUp(() {
      PCacheImage.init();
      collaboratorCubit = MockCollaboratorCubit();
      appUserBloc = MockAppUserBloc();
    });

    testWidgets('renders Collaborators info Page', (tester) async {
      final collaboratorState = CollaboratorInitial();
      const appUserState = AppUserInitial();
      when(() => collaboratorCubit.state).thenReturn(collaboratorState);
      when(() => appUserBloc.state).thenReturn(appUserState);
      when(() => collaboratorCubit.fillData()).thenAnswer((_) async {
        return;
      });
      await tester.pumpApp(
        BlocProvider.value(
          value: appUserBloc,
          child: BlocProvider.value(
            value: collaboratorCubit,
            child: const CollaboratorsPage(),
          ),
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
      final collaboratorState = CollaboratorInitial();
      const appUserState = AppUserInitial();
      when(() => collaboratorCubit.state).thenReturn(collaboratorState);
      when(() => appUserBloc.state).thenReturn(appUserState);
      when(() => collaboratorCubit.fillData()).thenAnswer((_) async {
        return;
      });
      await tester.pumpApp(
        BlocProvider.value(
          value: appUserBloc,
          child: BlocProvider.value(
            value: collaboratorCubit,
            child: const CollaboratorsPage(index: 1),
          ),
        ),
      );
      expect(
        find.byKey(
          const Key('collaborators_page_scaffold'),
        ),
        findsOneWidget,
      );
    });
  });
}
