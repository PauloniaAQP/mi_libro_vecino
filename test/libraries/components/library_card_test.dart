import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mi_libro_vecino/libraries/components/library_card.dart';
import 'package:mi_libro_vecino/libraries/cubit/libraries_cubit.dart';
import 'package:mi_libro_vecino/ui_utils/constans/assets.dart';
import 'package:mocktail/mocktail.dart';
import 'package:paulonia_cache_image/paulonia_cache_image.dart';

import '../../helpers/pump_app.dart';

class MockLibrariesCubit extends MockCubit<LibrariesState>
    implements LibrariesCubit {}

void main() {
  group('Library card widget', () {
    late LibrariesCubit librariesCubit;

    setUp(() {
      PCacheImage.init();
      librariesCubit = MockLibrariesCubit();
    });

    testWidgets('renders Library card widget', (tester) async {
      const state = LibrariesInitial();
      when(() => librariesCubit.state).thenReturn(state);
      await tester.pumpApp(
        BlocProvider.value(
          value: librariesCubit,
          child: LibraryCard(
            gsUrl: Assets.testImg,
            labels: const [],
            onTap: () {},
            subtitle: '',
            title: '',
          ),
        ),
      );
      expect(
        find.byKey(
          const Key('libraryCardInkwellKey'),
        ),
        findsOneWidget,
      );
    });
  });
}
