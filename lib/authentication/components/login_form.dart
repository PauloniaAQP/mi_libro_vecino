import 'package:flutter/material.dart';
import 'package:mi_libro_vecino/l10n/l10n.dart';
import 'package:mi_libro_vecino/ui_utils/general_widgets/p_text_field.dart';
import 'package:reactive_forms/reactive_forms.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    Key? key,
    required this.loginForm,
    required this.emailController,
    required this.passwordController,
  }) : super(key: key);

  final FormGroup loginForm;
  final String emailController;
  final String passwordController;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return ReactiveForm(
      formGroup: loginForm,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PTextField(
            label: l10n.loginPageUserLabel,
            hintText: l10n.loginPageUserHintText,
            formControlName: emailController,
            keyboardType: TextInputType.emailAddress,
            validationMessages: {
              ValidationMessage.required:
                  l10n.registerPageEnterEmailErrorTextRequired,
              ValidationMessage.email:
                  l10n.registerPageEnterEmailErrorTextEmail,
            },
          ),
          const SizedBox(height: 15),
          PTextField(
            formControlName: passwordController,
            hintText: l10n.loginPagePasswordHintText,
            label: l10n.loginPagePasswordLabel,
            validationMessages: {
              ValidationMessage.required:
                  l10n.registerPagePasswordErrorTextRequired,
              ValidationMessage.minLength:
                  l10n.registerPagePasswordErrorTextMinLength,
            },
            obscureText: true,
          ),
        ],
      ),
    );
  }
}
