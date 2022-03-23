part of 'register_cubit.dart';

enum RegisterStatus {
  initial,
  loading,
  success,
  error,
}

class RegisterState extends Equatable {
  const RegisterState({
    this.personPhoto,
    this.ageRange,
    this.libraryCategories = const <String>[],
    this.libraryPhoto,
    this.personPhotoBytes,
    this.libraryPhotoBytes,
    this.address,
    required this.index,
    required this.libraryInfoForm,
    required this.personInfoForm,
    required this.registerForm,
    required this.services,
    required this.openingController,
    required this.closingController,
    required this.libraryRolController,
    this.status = RegisterStatus.initial,
  });

  final int index;

  final XFile? personPhoto;
  final Uint8List? personPhotoBytes;
  final String? ageRange;
  final List<String> libraryCategories;
  final XFile? libraryPhoto;
  final Uint8List? libraryPhotoBytes;
  final String? address;

  static const String addressController = 'address';
  static const String mapAddressController = 'mapAddress';
  static const String descriptionController = 'description';
  static const String websiteController = 'website';
  static const String libraryNameController = 'name';
  static const String fullnameController = 'fullname';
  static const String phoneController = 'phone';
  static const String emailController = 'email';
  static const String passwordController = 'password';
  static const String confirmPasswordController = 'confirmPassword';
  static const String openTimeController = 'openTime';
  static const String closeTimeController = 'closeTime';
  static const String libraryLabelsController = 'libraryLabels';

  final TextEditingController openingController;
  final TextEditingController closingController;

  /// This controller has only int values
  /// and is used to select the library type index
  /// from LibraryType -> [mediator,library,editorial,bookshop]
  /// This controller is used to select the library type in the PBottomDrown
  final TextEditingController libraryRolController;

  final Map<String, bool> services;

  final FormGroup registerForm;
  final FormGroup personInfoForm;
  final FormGroup libraryInfoForm;

  final RegisterStatus status;

  @override
  List<Object> get props => [services, index];

  RegisterState copyWith({
    XFile? personPhoto,
    Uint8List? personPhotoBytes,
    TimeOfDay? openTime,
    TimeOfDay? closeTime,
    String? ageRange,
    List<String>? libraryCategories,
    XFile? libraryPhoto,
    Uint8List? libraryPhotoBytes,
    String? address,
    int? index,
    Map<String, bool>? services,
    RegisterStatus? status,
  }) {
    return RegisterState(
      personPhoto: personPhoto ?? this.personPhoto,
      personPhotoBytes: personPhotoBytes ?? this.personPhotoBytes,
      ageRange: ageRange ?? this.ageRange,
      libraryCategories: libraryCategories ?? this.libraryCategories,
      libraryPhoto: libraryPhoto ?? this.libraryPhoto,
      libraryPhotoBytes: libraryPhotoBytes ?? this.libraryPhotoBytes,
      address: address ?? this.address,
      index: index ?? this.index,
      libraryInfoForm: libraryInfoForm,
      personInfoForm: personInfoForm,
      registerForm: registerForm,
      closingController: closingController,
      openingController: openingController,
      libraryRolController: libraryRolController,
      services: services ?? this.services,
      status: status ?? this.status,
    );
  }
}

/// Initial state is [RegisterInitial]
/// Here we are initializing the form groups
/// after that all states will copy this form
/// groups and update index
class RegisterInitial extends RegisterState {
  RegisterInitial()
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
          index: 0,
          personInfoForm: FormGroup({
            RegisterState.fullnameController: FormControl<String>(
              validators: [
                Validators.required,
              ],
            ),
            RegisterState.phoneController: FormControl<String>(
              validators: [
                Validators.required,
                Validators.minLength(9),
                Validators.number,
              ],
            ),
          }),
          registerForm: FormGroup({
            RegisterState.emailController: FormControl<String>(
              validators: [
                Validators.required,
                Validators.email,
              ],
            ),
            RegisterState.passwordController: FormControl<String>(
              validators: [
                Validators.required,
                Validators.minLength(6),
              ],
            ),
            RegisterState.confirmPasswordController: FormControl<String>(
              validators: [
                Validators.required,
                Validators.minLength(6),
              ],
            ),
          }),
          libraryInfoForm: FormGroup({
            RegisterState.libraryNameController: FormControl<String>(
              validators: [
                Validators.required,
              ],
            ),
            RegisterState.websiteController: FormControl<String>(
              validators: [
                // TODO(oscarnar):  Add regex to websites
              ],
            ),
            RegisterState.descriptionController: FormControl<String>(
              validators: [
                Validators.required,
              ],
            ),
            RegisterState.openTimeController: FormControl<String>(
              validators: [
                Validators.required,
                Validators.pattern(
                  Globals.pTimeRegex,
                  validationMessage: 'El formato debe ser 12:00',
                ),
              ],
            ),
            RegisterState.closeTimeController: FormControl<String>(
              validators: [
                Validators.required,
                Validators.pattern(
                  Globals.pTimeRegex,
                  validationMessage: 'El formato debe ser 12:00',
                ),
              ],
            ),
            RegisterState.libraryLabelsController: FormControl<String>(),
            RegisterState.addressController: FormControl<String>(
              validators: [
                Validators.required,
              ],
            ),
            RegisterState.mapAddressController: FormControl<String>(
              validators: [
                // TODO(oscarnar): Check this, always will have an address(?)
                // Validators.required,
              ],
            ),
          }),
        );
}

class RegisterPhotoLoading extends RegisterState {
  const RegisterPhotoLoading({
    required FormGroup libraryInfoForm,
    required FormGroup personInfoForm,
    required FormGroup registerForm,
    required int index,
    required Map<String, bool> services,
    required TextEditingController openingController,
    required TextEditingController closingController,
    required TextEditingController libraryRolController,
  }) : super(
          index: index,
          libraryInfoForm: libraryInfoForm,
          personInfoForm: personInfoForm,
          registerForm: registerForm,
          services: services,
          openingController: openingController,
          closingController: closingController,
          libraryRolController: libraryRolController,
        );
}
