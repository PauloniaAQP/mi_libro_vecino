import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mi_libro_vecino/l10n/l10n.dart';
import 'package:mi_libro_vecino/register/components/suffix_time.dart';
import 'package:mi_libro_vecino/register/cubit/register_cubit.dart';
import 'package:mi_libro_vecino/ui_utils/colors.dart';
import 'package:mi_libro_vecino/ui_utils/general_widgets/p_text_field.dart';
import 'package:reactive_forms/reactive_forms.dart';

class LibraryInformationPage extends StatelessWidget {
  const LibraryInformationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          context.l10n.registerPageLibraryInformationTitle,
          style: Theme.of(context).textTheme.headline3!.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ),
        const SizedBox(height: 35),
        BlocBuilder<RegisterCubit, RegisterState>(
          builder: (context, state) {
            return ReactiveForm(
              formGroup: state.libraryInfoForm,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PTextField(
                      label: context.l10n.registerPageLibraryNameLabel,
                      hintText: context.l10n.registerPageLibraryNameHintText,
                      formControlName: RegisterState.libraryNameController,
                      validationMessages: {
                        ValidationMessage.required: context
                            .l10n.registerPageLibraryNameErrorTextRequired,
                      },
                    ),
                    PTextField(
                      label: context.l10n.registerPageLibraryWebLabel,
                      hintText: context.l10n.registerPageLibraryWebHintText,
                      formControlName: RegisterState.websiteController,
                      keyboardType: TextInputType.url,
                    ),
                    PTextField(
                      label: context.l10n.registerPageLibraryDescriptionLabel,
                      hintText:
                          context.l10n.registerPageLibraryDescriptionHintText,
                      formControlName: RegisterState.descriptionController,
                      keyboardType: TextInputType.number,
                      validationMessages: {
                        ValidationMessage.required: context
                            .l10n.registerPageLibraryDescriptionErrorText,
                      },
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: PTextField(
                            label: context
                                .l10n.registerPageLibraryOpeningTimeLabel,
                            hintText:
                                context.l10n.registerPageLibraryTimeHintText,
                            formControlName: RegisterState.openTimeController,
                            keyboardType: TextInputType.number,
                            suffixIcon: const SuffixTime(),
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
                            hintText:
                                context.l10n.registerPageLibraryTimeHintText,
                            formControlName: RegisterState.closeTimeController,
                            keyboardType: TextInputType.number,
                            suffixIcon: const SuffixTime(),
                            validationMessages: {
                              ValidationMessage.required: context.l10n
                                  .registerPageLibraryTimeErrorTextRequired,
                            },
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Text(
                        context.l10n.registerPageLibraryAgeRangeLabel,
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                              color: PColors.gray1,
                            ),
                      ),
                    ),
                    // TODO(oscarnar): Add dropdown with options
                    // If is posible, make our own dropdown
                    ReactiveTextField<String>(
                      formControlName: RegisterState.ageRangeController,
                      keyboardType: TextInputType.none,
                      readOnly: true,
                      mouseCursor: MaterialStateMouseCursor.clickable,
                      decoration: InputDecoration(
                        hintStyle:
                            Theme.of(context).textTheme.bodyText2!.copyWith(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: PColors.gray4,
                                ),
                        suffixIcon: const Icon(
                          Icons.arrow_drop_down_rounded,
                        ),
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: PColors.black,
                          ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
