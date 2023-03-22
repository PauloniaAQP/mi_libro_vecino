import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mi_libro_vecino/l10n/l10n.dart';
import 'package:mi_libro_vecino/router/app_routes.dart';
import 'package:mi_libro_vecino/ui_utils/constans/assets.dart';
import 'package:mi_libro_vecino/ui_utils/general_widgets/p_text_field.dart';
import 'package:reactive_forms/reactive_forms.dart';

class LoginForm extends StatefulWidget {
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
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool _isObscureText = true;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return ReactiveForm(
      formGroup: widget.loginForm,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PTextField(
            label: l10n.loginPageUserLabel,
            hintText: l10n.loginPageUserHintText,
            formControlName: widget.emailController,
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
            formControlName: widget.passwordController,
            hintText: l10n.loginPagePasswordHintText,
            label: l10n.loginPagePasswordLabel,
            validationMessages: {
              ValidationMessage.required:
                  l10n.registerPagePasswordErrorTextRequired,
              ValidationMessage.minLength:
                  l10n.registerPagePasswordErrorTextMinLength,
            },
            obscureText: _isObscureText,
            suffixIcon: Padding(
              padding: const EdgeInsets.all(8),
              child: InkWell(
                child: _isObscureText
                    ? Image.asset(Assets.eye, width: 10)
                    : Image.asset(Assets.eyeSlash, width: 10),
                onTap: () {
                  setState(() => _isObscureText = !_isObscureText);
                },
              ),
            ),
          ),
          const SizedBox(height: 15),
          RichText(
            text: TextSpan(
              children: [
                const TextSpan(
                  text: 'Al iniciar sesión está aceptando nuestros ',
                  style: TextStyle(color: Colors.black),
                ),
                TextSpan(
                  text: 'Términos y condiciones de uso',
                  style: const TextStyle(color: Colors.blue),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () { context.go(Routes.termsAndPrivacy); },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
