part of 'admin_cubit.dart';

class AdminState extends Equatable {
  const AdminState({
    this.isSearching = false,
    required this.textEditControler,
  });

  final bool isSearching;
  final TextEditingController textEditControler;

  @override
  List<Object> get props => [isSearching];

  AdminState copyWith({
    bool? isSearching,
  }) {
    return AdminState(
      isSearching: isSearching ?? this.isSearching,
      textEditControler: textEditControler,
    );
  }

}

class AdminInitial extends AdminState {
  AdminInitial() : super(textEditControler: TextEditingController());
}
