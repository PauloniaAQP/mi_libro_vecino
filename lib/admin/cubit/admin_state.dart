part of 'admin_cubit.dart';

class AdminState extends Equatable {
  const AdminState({
    this.isSearching = false,
    required this.textEditControler,
    this.pendingLibraries = const [],
    this.acceptedLibraries = const [],
    this.user,
  });

  final bool isSearching;
  final TextEditingController textEditControler;

  final List<LibraryModel> pendingLibraries;
  final List<LibraryModel> acceptedLibraries;
  final UserModel? user;

  @override
  List<Object> get props => [isSearching];

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
      user: user ?? this.user,
    );
  }
}

class AdminInitial extends AdminState {
  AdminInitial() : super(textEditControler: TextEditingController());
}
