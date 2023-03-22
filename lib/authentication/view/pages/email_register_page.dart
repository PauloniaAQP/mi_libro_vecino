import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mi_libro_vecino/authentication/cubit/register_cubit.dart';
import 'package:mi_libro_vecino/l10n/l10n.dart';
import 'package:mi_libro_vecino/router/app_routes.dart';
import 'package:mi_libro_vecino/ui_utils/colors.dart';
import 'package:mi_libro_vecino/ui_utils/constans/assets.dart';
import 'package:mi_libro_vecino/ui_utils/general_widgets/p_text_field.dart';
import 'package:reactive_forms/reactive_forms.dart';

class EmailRegisterPage extends StatefulWidget {
  const EmailRegisterPage({
    Key? key,
  }) : super(key: key);

  @override
  State<EmailRegisterPage> createState() => _EmailRegisterPageState();
}

class _EmailRegisterPageState extends State<EmailRegisterPage> {
  bool _isObscureText1 = true;
  bool _isObscureText2 = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {
              GoRouter.of(context).go(Routes.login);
            },
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
                          CustomValidators.alreadyExists: 'El email ya existe',
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
                          // TODO(oscarnar): Internationalization
                          ValidationMessage.mustMatch:
                              'Las contraseñas no coinciden',
                        },
                        obscureText: _isObscureText1,
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(8),
                          child: InkWell(
                            child: _isObscureText1
                                ? Image.asset(Assets.eye, width: 10)
                                : Image.asset(Assets.eyeSlash, width: 10),
                            onTap: () {
                              setState(
                                () => _isObscureText1 = !_isObscureText1,
                              );
                            },
                          ),
                        ),
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
                          ValidationMessage.mustMatch:
                              'Las contraseñas no coinciden',
                        },
                        obscureText: _isObscureText2,
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(8),
                          child: InkWell(
                            child: _isObscureText1
                                ? Image.asset(Assets.eye, width: 10)
                                : Image.asset(Assets.eyeSlash, width: 10),
                            onTap: () {
                              setState(
                                () => _isObscureText2 = !_isObscureText2,
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: 'Al registrarte está aceptando nuestros ',
                              style: TextStyle(color: Colors.black),
                            ),
                            TextSpan(
                              text: 'Términos y condiciones de uso',
                              style: const TextStyle(color: Colors.blue),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  context.go(Routes.termsAndPrivacy);
                                },
                            ),
                          ],
                        ),
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
