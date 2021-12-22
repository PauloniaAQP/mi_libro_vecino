import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mi_libro_vecino/search/cubit/search_cubit.dart';

void main() {
  group('Search cubit test', () {
    SearchCubit searchCubit;
    var query = 'are';

    setUp(() {
      searchCubit = SearchCubit();
      query = 'are';
    });

    tearDown(() {
      // searchCubit.close();
      // searchCubit.onSearchQueryChanged(query);
    });

    test('Initial state isSearching is false and suggestions list is empty',
        () {
      expect(SearchCubit().state.isSearching, false);
      expect(SearchCubit().state.suggestions.isEmpty, true);
    });

    blocTest<SearchCubit, SearchState>(
      'The cubit should be on search mode',
      build: () => SearchCubit(),
      act: (cubit) => cubit.onSearchQueryChanged(query),
      expect: () => [
        const SearchQueryChanged(['Arequipa'])
      ],
    );
  });
}
