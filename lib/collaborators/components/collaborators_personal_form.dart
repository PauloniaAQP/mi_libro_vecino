import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mi_libro_vecino/app/bloc/app_user_bloc.dart';
import 'package:mi_libro_vecino/collaborators/cubit/collaborator_cubit.dart';
import 'package:mi_libro_vecino/l10n/l10n.dart';
import 'package:mi_libro_vecino/ui_utils/general_widgets/future_with_loading.dart';
import 'package:mi_libro_vecino/ui_utils/general_widgets/p_text_field.dart';
import 'package:reactive_forms/reactive_forms.dart';

class CollaboratorsPersonalForm extends StatefulWidget {
  const CollaboratorsPersonalForm({
    Key? key,
  }) : super(key: key);

  @override
  State<CollaboratorsPersonalForm> createState() =>
      _CollaboratorsPersonalFormState();
}

class _CollaboratorsPersonalFormState extends State<CollaboratorsPersonalForm> {
  late bool _isTouched;

  @override
  void initState() {
    super.initState();
    _isTouched = context.read<CollaboratorCubit>().personalInfoWasTouched;
  }

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
                state.personalInfoForm.valueChanges.listen((event) {
                  context.read<CollaboratorCubit>().maskAsTouchedPersonalInfo();
                  setState(() {
                    _isTouched = context
                        .read<CollaboratorCubit>()
                        .personalInfoWasTouched;
                  });
                });
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
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
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
              onPressed: (!_isTouched)
                  ? null
                  : () {
                      futureWithLoading(
                        context.read<CollaboratorCubit>().onTapSaveUser().then(
                              (value) => context
                                  .read<AppUserBloc>()
                                  .add(const UpdateUser()),
                            ),
                        context,
                      ).then(
                        (value) => setState(() => _isTouched = false),
                      );
                    },
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
