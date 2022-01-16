import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mi_libro_vecino/libraries/cubit/libraries_cubit.dart';
import 'package:mi_libro_vecino/libraries/view/libraries_page.dart';
import 'package:mi_libro_vecino/search/cubit/search_cubit.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/pump_app.dart';

class MockLibrariesCubit extends MockCubit<LibrariesState>
    implements LibrariesCubit {}

class MockSearchCubit extends MockCubit<SearchState> implements SearchCubit {}

void main() {
  group('Libraries list page', () {
    late LibrariesCubit librariesCubit;
    late SearchCubit searchCubit;

    setUp(() {
      librariesCubit = MockLibrariesCubit();
      searchCubit = MockSearchCubit();
    });

    testWidgets('renders libraries list Page', (tester) async {
      const state = LibrariesInitial();
      const searchState = SearchInitial();
      when(() => librariesCubit.state).thenReturn(state);
      when(() => searchCubit.state).thenReturn(searchState);
      await tester.pumpApp(
        BlocProvider.value(
          value: searchCubit,
          child: BlocProvider.value(
            value: librariesCubit,
            child: const LibrariesPage(),
          ),
        ),
      );
      expect(
        find.text(
          'Soy colaborador',
        ),
        findsOneWidget,
      );
    });
  });
}
