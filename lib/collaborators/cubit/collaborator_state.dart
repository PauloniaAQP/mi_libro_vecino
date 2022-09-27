part of 'collaborator_cubit.dart';

class CollaboratorState extends Equatable {
  const CollaboratorState({
    required this.personalInfoForm,
    required this.libraryInfoForm,
    required this.openingController,
    required this.closingController,
    required this.libraryRolController,
    required this.services,
    required this.location,
    this.userImage,
    this.libraryImage,
    this.library,
  });

  static const String fullnameController = 'fullname';
  static const String phoneNumberController = 'phoneNumber';

  static const String libraryNameController = 'phoneNumber';
  static const String websiteController = 'website';
  static const String descriptionController = 'description';
  static const String openTimeController = 'openTime';
  static const String closeTimeController = 'closeTime';
  static const String addressController = 'address';
  static const String mapAddressController = 'mapAddress';
  static const String libraryLabelsController = 'libraryLabels';

  final TextEditingController openingController;
  final TextEditingController closingController;

  /// This controller has only int values
  /// and is used to select the library type index
  /// from LibraryType -> [mediator,library,editorial,bookshop]
  /// This controller is used to select the library type in the PBottomDrown
  final TextEditingController libraryRolController;

  final Map<String, bool> services;

  final FormGroup personalInfoForm;
  final FormGroup libraryInfoForm;

  final Coordinates location;
  final Uint8List? libraryImage;
  final Uint8List? userImage;
  final LibraryModel? library;

  @override
  List<Object> get props => [location, services, library ?? false];

  bool isEqualLibrary(CollaboratorState other) {
    final mapOriginLib = libraryInfoForm.value;
    final mapOtherLib = other.libraryInfoForm.value;
    return other.location == location &&
        other.services == services &&
        libraryImage == other.libraryImage &&
        mapOriginLib == mapOtherLib &&
        libraryRolController == other.libraryRolController &&
        openingController == other.openingController &&
        closingController == other.closingController;
  }

  bool isEqualUser(CollaboratorState other) {
    final mapOriginLib = personalInfoForm.value;
    final mapOtherLib = other.personalInfoForm.value;
    return userImage == other.userImage && mapOriginLib == mapOtherLib;
  }

  CollaboratorState copyWith({
    Map<String, bool>? services,
    Coordinates? location,
    Uint8List? libraryImage,
    Uint8List? userImage,
    LibraryModel? library,
  }) {
    return CollaboratorState(
      libraryInfoForm: libraryInfoForm,
      closingController: closingController,
      openingController: openingController,
      libraryRolController: libraryRolController,
      services: services ?? this.services,
      personalInfoForm: personalInfoForm,
      location: location ?? this.location,
      libraryImage: libraryImage ?? this.libraryImage,
      userImage: userImage ?? this.userImage,
      library: library ?? this.library,
    );
  }
}

class CollaboratorInitial extends CollaboratorState {
  CollaboratorInitial()
      : super(
          services: {
            'Presto libros': false,
            'Vendo libros': false,
            'Edito libros': false,
            'Recomiendo libros': false,
          },
          openingController: TextEditingController(),
          closingController: TextEditingController(),
          libraryRolController: TextEditingController(),
          personalInfoForm: FormGroup({
            CollaboratorState.fullnameController: FormControl<String>(
              validators: [
                Validators.required,
              ],
            ),
            CollaboratorState.phoneNumberController: FormControl<String>(
              validators: [
                Validators.required,
                Validators.minLength(9),
                Validators.number,
              ],
            ),
          }),
          libraryInfoForm: FormGroup({
            CollaboratorState.libraryNameController: FormControl<String>(
              validators: [
                Validators.required,
              ],
            ),
            CollaboratorState.websiteController: FormControl<String>(),
            CollaboratorState.descriptionController: FormControl<String>(
              validators: [
                Validators.required,
              ],
            ),
            CollaboratorState.openTimeController: FormControl<String>(
              validators: [
                Validators.required,
              ],
            ),
            CollaboratorState.closeTimeController: FormControl<String>(
              validators: [
                Validators.required,
              ],
            ),
            CollaboratorState.addressController: FormControl<String>(
              validators: [
                Validators.required,
              ],
            ),
            CollaboratorState.libraryLabelsController: FormControl<String>(),
          }),
          location: Coordinates(0, 0),
        );
}

class CollaboratorLoaded extends CollaboratorState {
  const CollaboratorLoaded({
    required FormGroup personalInfoForm,
    required FormGroup libraryInfoForm,
    required TextEditingController openingController,
    required TextEditingController closingController,
    required TextEditingController libraryRolController,
    required Map<String, bool> services,
    required Coordinates location,
  }) : super(
          personalInfoForm: personalInfoForm,
          libraryInfoForm: libraryInfoForm,
          openingController: openingController,
          closingController: closingController,
          libraryRolController: libraryRolController,
          services: services,
          location: location,
        );
}

class CollaboratorError extends CollaboratorState {
  const CollaboratorError({
    required FormGroup personalInfoForm,
    required FormGroup libraryInfoForm,
    required TextEditingController openingController,
    required TextEditingController closingController,
    required TextEditingController libraryRolController,
    required Map<String, bool> services,
    required Coordinates location,
  }) : super(
          personalInfoForm: personalInfoForm,
          libraryInfoForm: libraryInfoForm,
          openingController: openingController,
          closingController: closingController,
          libraryRolController: libraryRolController,
          services: services,
          location: location,
        );

  CollaboratorError.fromState(CollaboratorState state)
      : super(
          personalInfoForm: state.personalInfoForm,
          libraryInfoForm: state.libraryInfoForm,
          openingController: state.openingController,
          closingController: state.closingController,
          libraryRolController: state.libraryRolController,
          services: state.services,
          location: state.location,
        );
}
