// ignore_for_file: lines_longer_than_80_chars

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
import 'package:responsive_builder/responsive_builder.dart';

class LibraryInformationPage extends StatelessWidget {
  const LibraryInformationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state) {
        final libraryRol = getStringRolByType(
          LibraryType.values[int.parse(
            state.libraryRolController.text == ''
                ? '0'
                : state.libraryRolController.text,
          )],
          l10n,
        );
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              l10n.registerPageLibraryInformationTitle + libraryRol,
              style: Theme.of(context).textTheme.headline3!.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 25),
                child: ReactiveForm(
                  formGroup: state.libraryInfoForm,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PTextField(
                          label: context.l10n.registerPageLibraryNameLabel,
                          hintText:
                              context.l10n.registerPageLibraryNameHintText +
                                  libraryRol,
                          formControlName: RegisterState.libraryNameController,
                          validationMessages: {
                            ValidationMessage.required: context.l10n
                                    .registerPageLibraryNameErrorTextRequired +
                                libraryRol,
                          },
                        ),
                        PTextField(
                          label: context.l10n.registerPageLibraryWebLabel,
                          hintText: context.l10n.registerPageLibraryWebHintText,
                          formControlName: RegisterState.websiteController,
                          keyboardType: TextInputType.url,
                        ),
                        PTextField(
                          label:
                              context.l10n.registerPageLibraryDescriptionLabel,
                          hintText: context
                                  .l10n.registerPageLibraryDescriptionHintText +
                              libraryRol,
                          formControlName: RegisterState.descriptionController,
                          keyboardType: TextInputType.number,
                          maxLines: 4,
                          validationMessages: {
                            ValidationMessage.required: context
                                .l10n.registerPageLibraryDescriptionErrorText,
                          },
                        ),
                        ScreenTypeLayout(
                          mobile: Column(
                            children: [
                              PTextField(
                                label: context
                                    .l10n.registerPageLibraryOpeningTimeLabel,
                                hintText: context
                                    .l10n.registerPageLibraryTimeHintText,
                                formControlName:
                                    RegisterState.openTimeController,
                                keyboardType: TextInputType.number,
                                suffixIcon: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                      ),
                                      child: Container(
                                        height: 24,
                                        width: 1,
                                        color: PColors.gray2,
                                      ),
                                    ),
                                    PDropdownButton(
                                      valuesList: const ['AM', 'PM'],
                                      controller: state.openingController,
                                    ),
                                  ],
                                ),
                                validationMessages: {
                                  ValidationMessage.required: context.l10n
                                      .registerPageLibraryTimeErrorTextRequired,
                                },
                              ),
                              PTextField(
                                label: context
                                    .l10n.registerPageLibraryClosingTimeLabel,
                                hintText: context
                                    .l10n.registerPageLibraryTimeHintText,
                                formControlName:
                                    RegisterState.closeTimeController,
                                keyboardType: TextInputType.number,
                                suffixIcon: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                      ),
                                      child: Container(
                                        height: 24,
                                        width: 1,
                                        color: PColors.gray2,
                                      ),
                                    ),
                                    PDropdownButton(
                                      valuesList: const ['AM', 'PM'],
                                      controller: state.closingController,
                                    ),
                                  ],
                                ),
                                validationMessages: {
                                  ValidationMessage.required: context.l10n
                                      .registerPageLibraryTimeErrorTextRequired,
                                },
                              ),
                            ],
                          ),
                          desktop: Row(
                            children: [
                              Expanded(
                                child: PTextField(
                                  label: context
                                      .l10n.registerPageLibraryOpeningTimeLabel,
                                  hintText: context
                                      .l10n.registerPageLibraryTimeHintText,
                                  formControlName:
                                      RegisterState.openTimeController,
                                  keyboardType: TextInputType.number,
                                  suffixIcon: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                        ),
                                        child: Container(
                                          height: 24,
                                          width: 1,
                                          color: PColors.gray2,
                                        ),
                                      ),
                                      PDropdownButton(
                                        valuesList: const ['AM', 'PM'],
                                        controller: state.openingController,
                                      ),
                                    ],
                                  ),
                                  validationMessages: {
                                    ValidationMessage.required: context.l10n
                                        .registerPageLibraryTimeErrorTextRequired,
                                  },
                                ),
                              ),
                              const SizedBox(width: 30),
                              Expanded(
                                child: PTextField(
                                  label: context
                                      .l10n.registerPageLibraryClosingTimeLabel,
                                  hintText: context
                                      .l10n.registerPageLibraryTimeHintText,
                                  formControlName:
                                      RegisterState.closeTimeController,
                                  keyboardType: TextInputType.number,
                                  suffixIcon: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                        ),
                                        child: Container(
                                          height: 24,
                                          width: 1,
                                          color: PColors.gray2,
                                        ),
                                      ),
                                      PDropdownButton(
                                        valuesList: const ['AM', 'PM'],
                                        controller: state.closingController,
                                      ),
                                    ],
                                  ),
                                  validationMessages: {
                                    ValidationMessage.required: context.l10n
                                        .registerPageLibraryTimeErrorTextRequired,
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: !(state.isScheduleValid ?? true),
                          child: const Text(
                            '''El horario ingresado no es valido, asegurese que el horario de apertura sea menor al horario de cierre''',
                            style: TextStyle(color: PColors.red, fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
