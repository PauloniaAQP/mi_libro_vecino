part of 'libraries_cubit.dart';

abstract class LibrariesState extends Equatable {
  const LibrariesState({
    this.libraries,
    this.currentLibrary,
  });

  final List<LibraryModel>? libraries;
  final LibraryModel? currentLibrary;

  @override
  List<LibraryModel> get props => [];
}

class LibrariesInitial extends LibrariesState {
  const LibrariesInitial() : super();
}

class LibrariesLoaded extends LibrariesState {
  const LibrariesLoaded(
    List<LibraryModel>? libraries, {
    LibraryModel? currentLibrary,
  }) : super(libraries: libraries, currentLibrary: currentLibrary);
}

class LibrariesLoading extends LibrariesState {
  const LibrariesLoading() : super();
}

class LibrariesError extends LibrariesState {
  const LibrariesError() : super();
}
