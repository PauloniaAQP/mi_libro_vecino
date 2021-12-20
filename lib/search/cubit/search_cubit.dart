import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(const SearchInitial());

  static final List<String> _places = [
    'Arequipa',
    'Lima',
    'Cusco',
    'Machu Picchu',
    'Caylloma',
    'Cayma',
  ];

  void onSearchQueryChanged(String query) {
    if (query == '') {
      emit(const SearchInitial());
    } else {
      final searchResults = _places
          .where(
            (String item) => item.toLowerCase().startsWith(
                  query.toLowerCase(),
                ),
          )
          .toList();
      emit(SearchQueryChanged(searchResults));
    }
  }
}
