part of 'search_cubit.dart';

@immutable
class SearchState extends Equatable {
  const SearchState({
    required this.isSearching,
    this.suggestions = const <UbigeoModel>[],
  });
  final bool isSearching;
  final List<UbigeoModel> suggestions;
  @override
  List<Object?> get props => [isSearching, suggestions];
}

class SearchInitial extends SearchState {
  const SearchInitial() : super(isSearching: false);
}

class SearchQueryChanged extends SearchState {
  const SearchQueryChanged(List<UbigeoModel> suggestions)
      : super(
          isSearching: true,
          suggestions: suggestions,
        );
}
