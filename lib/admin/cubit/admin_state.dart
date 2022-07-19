part of 'admin_cubit.dart';

class AdminState extends Equatable {
  const AdminState({
    this.isSearching = false,
    required this.textEditControler,
    this.pendingLibraries,
    this.acceptedLibraries,
    this.acceptedOwners,
    this.pendingOwners,
  });

  final bool isSearching;
  final TextEditingController textEditControler;

  final List<LibraryModel>? pendingLibraries;
  final List<LibraryModel>? acceptedLibraries;
  final List<UserModel>? pendingOwners;
  final List<UserModel>? acceptedOwners;

  @override
  List<Object> get props =>
      [isSearching, pendingLibraries ?? false, acceptedLibraries ?? false];

  AdminState copyWith({
    bool? isSearching,
    List<LibraryModel>? pendingLibraries,
    List<LibraryModel>? acceptedLibraries,
    List<UserModel>? pendingOwners,
    List<UserModel>? acceptedOwners,
    UserModel? user,
  }) {
    return AdminState(
      isSearching: isSearching ?? this.isSearching,
      textEditControler: textEditControler,
      pendingLibraries: pendingLibraries ?? this.pendingLibraries,
      acceptedLibraries: acceptedLibraries ?? this.acceptedLibraries,
      pendingOwners: pendingOwners ?? this.pendingOwners,
      acceptedOwners: acceptedOwners ?? this.acceptedOwners,
    );
  }
}

class AdminInitial extends AdminState {
  AdminInitial() : super(textEditControler: TextEditingController());
}
