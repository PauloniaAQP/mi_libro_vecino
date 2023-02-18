import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mi_libro_vecino/app/bloc/app_user_bloc.dart';
import 'package:mi_libro_vecino/authentication/bloc/auth_bloc.dart';
import 'package:mi_libro_vecino/authentication/components/login_form.dart';
import 'package:mi_libro_vecino/authentication/view/pages/quotes_page.dart';
import 'package:mi_libro_vecino/l10n/l10n.dart';
import 'package:mi_libro_vecino/router/app_routes.dart';
import 'package:mi_libro_vecino/ui_utils/colors.dart';
import 'package:mi_libro_vecino/ui_utils/constans/assets.dart';
import 'package:mi_libro_vecino/ui_utils/functions.dart';
import 'package:mi_libro_vecino/ui_utils/general_widgets/custom_loading.dart';
import 'package:mi_libro_vecino_api/services/auth_service.dart';
import 'package:mi_libro_vecino_api/utils/constants/enums/library_enums.dart';
import 'package:mi_libro_vecino_api/utils/constants/enums/user_enums.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:responsive_builder/responsive_builder.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({
    Key? key,
    this.isAdmin = false,
  }) : super(key: key);
  final bool isAdmin;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(
        appUserBloc: context.read<AppUserBloc>(),
      ),
      child: LoginView(isAdmin: isAdmin),
    );
  }
}

class LoginView extends StatefulWidget {
  const LoginView({
    Key? key,
    this.isAdmin = false,
  }) : super(key: key);

  final bool isAdmin;
  @override
  LoginViewState createState() => LoginViewState();
}

class LoginViewState extends State<LoginView>
    with AutomaticKeepAliveClientMixin {
  /// Form for login
  static const String emailController = 'email';
  static const String passwordController = 'password';
  late FormGroup loginForm;

  @override
  void initState() {
    super.initState();
    loginForm = FormGroup({
      emailController: FormControl<String>(
        validators: [Validators.required, Validators.email],
      ),
      passwordController: FormControl<String>(
        validators: [Validators.required, Validators.minLength(6)],
      ),
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final l10n = context.l10n;
    return MultiBlocListener(
      listeners: [
        BlocListener<AppUserBloc, AppUserState>(
          listener: (context, state) {
            if (state.status == AuthenticationStatus.authenticated) {
              if (state is AppUserDisabled) {
                if (state.wasRejected) {
                  GoRouter.of(context).go(Routes.errorRegister);
                  return;
                } else {
                  GoRouter.of(context).go(Routes.disabledAccount);
                  return;
                }
              }
              if (state is AppUserAuthenticated) {
                if (state.isAdmin && !widget.isAdmin) {
                  context.read<AuthBloc>().add(
                        const AuthLogoutRequested(
                          error: LoginState.errorUserNotFound,
                        ),
                      );
                  return;
                }
                if (!state.isAdmin && widget.isAdmin) {
                  context.read<AuthBloc>().add(
                        const AuthLogoutRequested(
                          error: LoginState.errorUserNotFound,
                        ),
                      );
                  return;
                }

                if (state.isAdmin) {
                  GoRouter.of(context).go(Routes.admin);
                  return;
                } else {
                  if (state.currentLibrary?.state == LibraryState.inReview) {
                    AuthService.signOut().then((_) {
                      GoRouter.of(context).go(Routes.waiting);
                    });
                    return;
                  } else {
                    GoRouter.of(context).go(Routes.collaborators);
                    return;
                  }
                }
              }
            }
          },
        ),
        BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthError) {
              showDialog<void>(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Error de autenticación'),
                  content: Text(
                    getStringLoginStatus(state.error, l10n),
                  ),
                  actions: <Widget>[
                    ElevatedButton(
                      child: Text(context.l10n.accept),
                      onPressed: () {
                        Navigator.of(context, rootNavigator: true).pop();
                      },
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ],
      child: Scaffold(
        body: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return Stack(
              children: [
                ScreenTypeLayout(
                  mobile: Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: MediaQuery.of(context).size.height * 0.1,
                            horizontal: 50,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Visibility(
                                visible: !widget.isAdmin,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: TextButton(
                                    onPressed: () {
                                      GoRouter.of(context).go(Routes.register);
                                    },
                                    child: Text(
                                      l10n.loginPageNewRegisterBotton,
                                      style: Theme.of(context)
                                          .textTheme
                                          .button!
                                          .apply(
                                            fontSizeDelta: 2,
                                            color: PColors.blue,
                                          ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 30),
                              Text(
                                l10n.loginPageLoginTitle,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2!
                                    .apply(
                                      fontWeightDelta: 100,
                                    ),
                              ),
                              const SizedBox(height: 10),
                              Expanded(
                                child: SingleChildScrollView(
                                  child: LoginForm(
                                    emailController: emailController,
                                    passwordController: passwordController,
                                    loginForm: loginForm,
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
                                      loginForm.markAllAsTouched();
                                      if (loginForm.invalid) return;
                                      context.read<AuthBloc>().add(
                                            AuthLoginRequested(
                                              loginForm
                                                  .control(
                                                    emailController,
                                                  )
                                                  .value
                                                  .toString(),
                                              loginForm
                                                  .control(
                                                    passwordController,
                                                  )
                                                  .value
                                                  .toString(),
                                              isAdmin: widget.isAdmin,
                                            ),
                                          );
                                    },
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
                  desktop: Row(
                    children: [
                      const Expanded(
                        child: QuotesPage(
                          imagesPath: [Assets.loginImage],
                        ),
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
                              Visibility(
                                visible: !widget.isAdmin,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: TextButton(
                                    onPressed: () {
                                      GoRouter.of(context).go(Routes.register);
                                    },
                                    child: Text(
                                      l10n.loginPageNewRegisterBotton,
                                      style: Theme.of(context)
                                          .textTheme
                                          .button!
                                          .apply(
                                            fontSizeDelta: 2,
                                            color: PColors.blue,
                                          ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 30),
                              Text(
                                l10n.loginPageLoginTitle,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2!
                                    .apply(
                                      fontWeightDelta: 100,
                                    ),
                              ),
                              const SizedBox(height: 10),
                              Expanded(
                                child: SingleChildScrollView(
                                  child: LoginForm(
                                    emailController: emailController,
                                    passwordController: passwordController,
                                    loginForm: loginForm,
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
                                      loginForm.markAllAsTouched();
                                      if (loginForm.invalid) return;
                                      context.read<AuthBloc>().add(
                                            AuthLoginRequested(
                                              loginForm
                                                  .control(
                                                    emailController,
                                                  )
                                                  .value
                                                  .toString(),
                                              loginForm
                                                  .control(
                                                    passwordController,
                                                  )
                                                  .value
                                                  .toString(),
                                              isAdmin: widget.isAdmin,
                                            ),
                                          );
                                    },
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
                ),
                if (state is AuthLoading) const CustomLoading()
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
