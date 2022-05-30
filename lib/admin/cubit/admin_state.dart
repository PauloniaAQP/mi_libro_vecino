part of 'admin_cubit.dart';

class AdminState extends Equatable {
  const AdminState({
    this.isSearching = false,
    required this.textEditControler,
    this.pendingLibraries,
    this.acceptedLibraries,
  });

  final bool isSearching;
  final TextEditingController textEditControler;

  final List<LibraryModel>? pendingLibraries;
  final List<LibraryModel>? acceptedLibraries;

  @override
  List<Object> get props =>
      [isSearching, pendingLibraries ?? false, acceptedLibraries ?? false];

  AdminState copyWith({
    bool? isSearching,
    List<LibraryModel>? pendingLibraries,
    List<LibraryModel>? acceptedLibraries,
    UserModel? user,
  }) {
    return AdminState(
      isSearching: isSearching ?? this.isSearching,
      textEditControler: textEditControler,
      pendingLibraries: pendingLibraries ?? this.pendingLibraries,
      acceptedLibraries: acceptedLibraries ?? this.acceptedLibraries,
    );
  }
}

class AdminInitial extends AdminState {
  AdminInitial() : super(textEditControler: TextEditingController());
}
