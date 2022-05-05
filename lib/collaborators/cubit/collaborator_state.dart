part of 'collaborator_cubit.dart';

class CollaboratorState extends Equatable {
  const CollaboratorState({
    required this.personalInfoForm,
    required this.libraryInfoForm,
    required this.openingController,
    required this.closingController,
    required this.libraryRolController,
    required this.services,
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

  @override
  List<Object> get props => [services];

  CollaboratorState copyWith({
    Map<String, bool>? services,
  }) {
    return CollaboratorState(
      libraryInfoForm: libraryInfoForm,
      closingController: closingController,
      openingController: openingController,
      libraryRolController: libraryRolController,
      services: services ?? this.services,
      personalInfoForm: personalInfoForm,
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
            CollaboratorState.websiteController: FormControl<String>(
              validators: [],
            ),
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
            CollaboratorState.mapAddressController: FormControl<String>(
              validators: [
                Validators.required,
              ],
            ),
            CollaboratorState.libraryLabelsController: FormControl<String>(
              validators: [
                Validators.required,
              ],
            ),
          }),
        );
}
