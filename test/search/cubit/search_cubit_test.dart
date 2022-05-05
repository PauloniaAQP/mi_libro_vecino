import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mi_libro_vecino/search/cubit/search_cubit.dart';
import 'package:mi_libro_vecino_api/services/ubigeo_service.dart';

void main() {
  group('Search cubit test', () {
    late String query;
    late UbigeoService ubigeoService;
    setUp(() async {
      TestWidgetsFlutterBinding.ensureInitialized();
      query = 'qwerty';
      ubigeoService = UbigeoService();
      await ubigeoService.init();
    });

    test('Initial state isSearching is false and suggestions list is empty',
        () {
      expect(SearchCubit(ubigeoService).state.isSearching, false);
      expect(SearchCubit(ubigeoService).state.suggestions.isEmpty, true);
    });

    blocTest<SearchCubit, SearchState>(
      'The cubit should be on search mode',
      build: () => SearchCubit(ubigeoService),
      act: (cubit) => cubit.onSearchQueryChanged(query),
      expect: () => [const SearchQueryChanged([])],
    );
  });
}
