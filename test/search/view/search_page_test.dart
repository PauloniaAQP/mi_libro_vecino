import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mi_libro_vecino/search/cubit/search_cubit.dart';
import 'package:mi_libro_vecino/search/search.dart';
import 'package:mi_libro_vecino/search/widgets/search_widget.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/pump_app.dart';

class MockSearchCubit extends MockCubit<SearchState> implements SearchCubit {}

void main() {
  group('Search page', () {
    late SearchCubit searchCubit;

    setUp(() {
      searchCubit = MockSearchCubit();
    });

    testWidgets('renders Search Page', (tester) async {
      const state = SearchState(
        isSearching: false,
      );
      when(() => searchCubit.state).thenReturn(state);
      await tester.pumpApp(
        BlocProvider.value(
          value: searchCubit,
          child: const SearchPage(),
        ),
      );
      expect(
        find.text(
          'Copyright 2021 Mi Libro Vecino. Todos los derechos reservados',
        ),
        findsOneWidget,
      );
    });
  });

  group('Search widget', () {
    late SearchCubit searchCubit;

    setUp(() {
      searchCubit = MockSearchCubit();
    });

    testWidgets('renders Search widget', (tester) async {
      const state = SearchState(
        isSearching: false,
      );
      when(() => searchCubit.state).thenReturn(state);
      await tester.pumpApp(
        BlocProvider.value(
          value: searchCubit,
          child: SearchWidget(),
        ),
      );
      expect(
        find.byType(FloatingActionButton),
        findsOneWidget,
      );
    });

    testWidgets('enter text into Search widget', (tester) async {
      const term = 'are';
      const state = SearchState(
        isSearching: false,
      );
      when(() => searchCubit.state).thenReturn(state);
      await tester.pumpApp(
        BlocProvider.value(
          value: searchCubit,
          child: SearchWidget(),
        ),
      );
      await tester.enterText(find.byType(TextField), term);
      expect(find.text(term), findsOneWidget);
      verify(() => searchCubit.onSearchQueryChanged(term)).called(1);
    });
  });
}
