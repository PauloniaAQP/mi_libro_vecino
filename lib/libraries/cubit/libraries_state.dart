part of 'libraries_cubit.dart';

abstract class LibrariesState extends Equatable {
  const LibrariesState({
    this.libraries,
  });

  final List<Object>? libraries;

  @override
  List<Object> get props => [];
}

class LibrariesInitial extends LibrariesState {
  const LibrariesInitial() : super();
}
