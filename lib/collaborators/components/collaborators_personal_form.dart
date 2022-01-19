import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mi_libro_vecino/collaborators/cubit/collaborator_cubit.dart';
import 'package:mi_libro_vecino/l10n/l10n.dart';
import 'package:mi_libro_vecino/ui_utils/general_widgets/p_text_field.dart';
import 'package:reactive_forms/reactive_forms.dart';

class CollaboratorsPersonalForm extends StatelessWidget {
  const CollaboratorsPersonalForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 5,
          child: SingleChildScrollView(
            child: BlocBuilder<CollaboratorCubit, CollaboratorState>(
              builder: (context, state) {
                return ReactiveForm(
                  formGroup: state.personalInfoForm,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PTextField(
                        label: l10n.registerPagePersonalNameLabel,
                        hintText: l10n.registerPagePersonalNameHintText,
                        formControlName: CollaboratorState.fullnameController,
                        keyboardType: TextInputType.text,
                        validationMessages: {
                          ValidationMessage.required:
                              l10n.registerPagePersonalNameErrorTextRequired,
                        },
                      ),
                      const SizedBox(height: 15),
                      PTextField(
                        formControlName:
                            CollaboratorState.phoneNumberController,
                        hintText: l10n.registerPagePersonalPhoneHintText,
                        label: l10n.registerPagePersonalPhoneLabel,
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
          ),
        ),
        const SizedBox(height: 10),
        Center(
          child: SizedBox(
            height: 56,
            width: 400,
            child: ElevatedButton(
              onPressed: () {},
              child: Text(
                l10n.collaboratorsPageSaveButton,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        const Spacer(),
      ],
    );
  }
}
