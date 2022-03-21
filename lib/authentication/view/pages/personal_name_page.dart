import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mi_libro_vecino/authentication/cubit/register_cubit.dart';
import 'package:mi_libro_vecino/l10n/l10n.dart';
import 'package:mi_libro_vecino/ui_utils/colors.dart';
import 'package:mi_libro_vecino/ui_utils/functions.dart';
import 'package:mi_libro_vecino/ui_utils/general_widgets/p_dropdown_button.dart';
import 'package:mi_libro_vecino/ui_utils/general_widgets/p_text_field.dart';
import 'package:mi_libro_vecino_api/utils/constants/enums/library_enums.dart';
import 'package:reactive_forms/reactive_forms.dart';

class PersonalNamePage extends StatelessWidget {
  const PersonalNamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final rolesList = <String>[
      l10n.registerPageRolMediator,
      l10n.registerPageRolLibrary,
      l10n.registerPageRolEditorial,
      l10n.registerPageRolBookshop,
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.registerPagePersonalInformationTitle,
          style: Theme.of(context).textTheme.headline3!.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 25),
            child: BlocBuilder<RegisterCubit, RegisterState>(
              builder: (context, state) {
                return ReactiveForm(
                  formGroup: state.personInfoForm,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      PTextField(
                        label: l10n.registerPagePersonalNameLabel,
                        hintText: l10n.registerPagePersonalNameHintText,
                        formControlName: RegisterState.fullnameController,
                        keyboardType: TextInputType.name,
                        validationMessages: {
                          ValidationMessage.required:
                              l10n.registerPagePersonalNameErrorTextRequired,
                        },
                      ),
                      const SizedBox(height: 20),
                      PTextField(
                        label: l10n.registerPagePersonalPhoneLabel,
                        hintText: l10n.registerPagePersonalPhoneHintText,
                        formControlName: RegisterState.phoneController,
                        keyboardType: TextInputType.number,
                        validationMessages: {
                          ValidationMessage.required:
                              l10n.registerPagePersonalPhoneErrorTextRequired,
                          ValidationMessage.minLength:
                              l10n.registerPagePersonalPhoneErrorTextMinLength,
                          ValidationMessage.number:
                              l10n.registerPagePersonalPhoneErrorTextNumber,
                        },
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Text(
                          context.l10n.registerPageLibraryRolLabel,
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13,
                                    color: PColors.gray1,
                                  ),
                        ),
                      ),
                      PDropdownButton(
                        valuesList: List.generate(
                          LibraryType.values.length,
                          (index) => getStringRolByType(
                              LibraryType.values[index], l10n),
                        ),
                        controller: state.libraryRolController,
                        isExpanded: true,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
