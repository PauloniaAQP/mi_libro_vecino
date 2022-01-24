import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mi_libro_vecino/l10n/l10n.dart';
import 'package:mi_libro_vecino/register/cubit/register_cubit.dart';
import 'package:mi_libro_vecino/ui_utils/colors.dart';
import 'package:mi_libro_vecino/ui_utils/general_widgets/p_text_field.dart';
import 'package:reactive_forms/reactive_forms.dart';

class EmailRegisterPage extends StatelessWidget {
  const EmailRegisterPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {},
            child: Text(
              context.l10n.registerPageLoginButton,
              style: Theme.of(context).textTheme.button!.apply(
                    fontSizeDelta: 2,
                    color: PColors.blue,
                  ),
            ),
          ),
        ),
        const SizedBox(height: 30),
        Text(
          context.l10n.registerPageNewRegisterTitle,
          style: Theme.of(context).textTheme.headline2!.apply(
                fontWeightDelta: 100,
              ),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 25),
            child: BlocBuilder<RegisterCubit, RegisterState>(
              builder: (context, state) {
                return ReactiveForm(
                  formGroup: state.registerForm,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PTextField(
                        label: context.l10n.registerPageUserLabel,
                        hintText: context.l10n.registerPageEnterEmailHintText,
                        formControlName: RegisterState.emailController,
                        keyboardType: TextInputType.name,
                        validationMessages: {
                          ValidationMessage.required: context
                              .l10n.registerPageEnterEmailErrorTextRequired,
                          ValidationMessage.email:
                              context.l10n.registerPageEnterEmailErrorTextEmail,
                        },
                      ),
                      const SizedBox(height: 15),
                      PTextField(
                        formControlName: RegisterState.passwordController,
                        hintText: context.l10n.registerPagePasswordHintText,
                        label: context.l10n.registerPagePasswordLabel,
                        validationMessages: {
                          ValidationMessage.required: context
                              .l10n.registerPagePasswordErrorTextRequired,
                          ValidationMessage.minLength: context
                              .l10n.registerPagePasswordErrorTextMinLength,
                        },
                        obscureText: true,
                      ),
                      const SizedBox(height: 15),
                      PTextField(
                        formControlName:
                            RegisterState.confirmPasswordController,
                        hintText:
                            context.l10n.registerPageConfirmPasswordHintText,
                        label: context.l10n.registerPageConfirmPasswordLabel,
                        validationMessages: {
                          ValidationMessage.required: context.l10n
                              .registerPageConfirmPasswordErrorTextRequired,
                          ValidationMessage.minLength: context.l10n
                              .registerPageConfirmPasswordErrorTextMinLength,
                        },
                        obscureText: true,
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
              onPressed: () {
                context.read<RegisterCubit>().nextPage();
              },
              child: Text(
                context.l10n.registerPageRegisterAndContinueButton,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
