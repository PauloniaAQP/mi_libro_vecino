import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:mi_libro_vecino_api/models/ubigeo_model.dart';
import 'package:mi_libro_vecino_api/services/ubigeo_service.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(this.ubigeoService) : super(const SearchInitial());

  void onSearchQueryChanged(String query) {
    if (query == '') {
      emit(const SearchInitial());
    } else {
      ubigeoService.init();
      final searchResults = ubigeoService.searchUbigeo(query);

      emit(SearchQueryChanged(searchResults));
    }
  }

  void cleanSearchQuery() {
    emit(const SearchInitial());
  }

  UbigeoService ubigeoService;
}
