import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mi_libro_vecino/libraries/components/libraries_list.dart';
import 'package:mi_libro_vecino/libraries/cubit/libraries_cubit.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/pump_app.dart';

class MockLibrariesCubit extends MockCubit<LibrariesState>
    implements LibrariesCubit {}

void main() {
  group('Libraries list page', () {
    late LibrariesCubit librariesCubit;

    setUp(() {
      librariesCubit = MockLibrariesCubit();
    });

    testWidgets('renders libraries list Page', (tester) async {
      const state = LibrariesInitial();
      when(() => librariesCubit.state).thenReturn(state);
      await tester.pumpApp(
        BlocProvider.value(
          value: librariesCubit,
          child: const LibrariesList(),
        ),
      );
      expect(
        find.byKey(
          const Key('librariesListKey'),
        ),
        findsOneWidget,
      );
    });
  });
}
