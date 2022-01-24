import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mi_libro_vecino/l10n/l10n.dart';
import 'package:mi_libro_vecino/register/cubit/register_cubit.dart';
import 'package:mi_libro_vecino/ui_utils/general_widgets/p_text_field.dart';
import 'package:reactive_forms/reactive_forms.dart';

class PersonalNamePage extends StatelessWidget {
  const PersonalNamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.registerPagePersonalInformationTitle,
          style: Theme.of(context).textTheme.headline3!.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ),
        const SizedBox(height: 35),
        BlocBuilder<RegisterCubit, RegisterState>(
          builder: (context, state) {
            return ReactiveForm(
              formGroup: state.personInfoForm,
              child: Column(
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
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
