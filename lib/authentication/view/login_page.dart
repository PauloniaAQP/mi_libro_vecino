import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mi_libro_vecino/authentication/cubit/login_cubit.dart';
import 'package:mi_libro_vecino/authentication/view/pages/quotes_page.dart';
import 'package:mi_libro_vecino/l10n/l10n.dart';
import 'package:mi_libro_vecino/router/app_routes.dart';
import 'package:mi_libro_vecino/ui_utils/colors.dart';
import 'package:mi_libro_vecino/ui_utils/general_widgets/p_text_field.dart';
import 'package:reactive_forms/reactive_forms.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final l10n = context.l10n;
    return Scaffold(
      body: Row(
        children: [
          const Expanded(
            child: QuotesPage(),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 80,
                horizontal: 100,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        GoRouter.of(context).go(Routes.register);
                      },
                      child: Text(
                        l10n.loginPageNewRegisterBotton,
                        style: Theme.of(context).textTheme.button!.apply(
                              fontSizeDelta: 2,
                              color: PColors.blue,
                            ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    l10n.loginPageLoginTitle,
                    style: Theme.of(context).textTheme.headline2!.apply(
                          fontWeightDelta: 100,
                        ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(vertical: 25),
                      child: BlocBuilder<LoginCubit, LoginState>(
                        builder: (context, state) {
                          return ReactiveForm(
                            formGroup: state.loginForm,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                PTextField(
                                  label: l10n.loginPageUserLabel,
                                  hintText: l10n.loginPageUserHintText,
                                  formControlName: LoginState.emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  validationMessages: {
                                    ValidationMessage.required: l10n
                                        .registerPageEnterEmailErrorTextRequired,
                                    ValidationMessage.email: l10n
                                        .registerPageEnterEmailErrorTextEmail,
                                  },
                                ),
                                const SizedBox(height: 15),
                                PTextField(
                                  formControlName:
                                      LoginState.passwordController,
                                  hintText: l10n.loginPagePasswordHintText,
                                  label: l10n.loginPagePasswordLabel,
                                  validationMessages: {
                                    ValidationMessage.required: l10n
                                        .registerPagePasswordErrorTextRequired,
                                    ValidationMessage.minLength: l10n
                                        .registerPagePasswordErrorTextMinLength,
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
                        onPressed: () {},
                        child: Text(
                          l10n.loginPageLoginButton,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
