import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mi_libro_vecino/app/bloc/app_user_bloc.dart';
import 'package:mi_libro_vecino/authentication/components/login_form.dart';
import 'package:mi_libro_vecino/authentication/cubit/login_cubit.dart';
import 'package:mi_libro_vecino/authentication/view/pages/quotes_page.dart';
import 'package:mi_libro_vecino/l10n/l10n.dart';
import 'package:mi_libro_vecino/router/app_routes.dart';
import 'package:mi_libro_vecino/ui_utils/colors.dart';
import 'package:mi_libro_vecino/ui_utils/functions.dart';
import 'package:mi_libro_vecino_api/services/auth_service.dart';
import 'package:mi_libro_vecino_api/utils/constants/enums/user_enums.dart'
    as status;

class LoginPage extends StatefulWidget {
  const LoginPage({
    Key? key,
    this.isAdmin = false,
  }) : super(key: key);

  final bool isAdmin;
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();

    /// If the user is already logged in, we redirect to
    /// the correct page, there are issues with the bloc listener
    SchedulerBinding.instance?.addPostFrameCallback((_) {
      if (context.read<AppUserBloc>().state.status ==
          AuthenticationStatus.authenticated) {
        if (context.read<AppUserBloc>().state.isAdmin) {
          GoRouter.of(context).go(Routes.admin);
        } else {
          GoRouter.of(context).go(Routes.collaborators);
        }
      }
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
              /// Here we close the loaging dialog only if login is successful
              /// This code is here because we need to close the loading dialog
              /// just before the user is redirected to the next page
              if (context.read<LoginCubit>().state is LoginSuccess) {
                Navigator.of(context).pop();
              }
              context.read<LoginCubit>().cleanData();
              if (state.isAdmin) {
                GoRouter.of(context).go(Routes.admin);
              } else {
                GoRouter.of(context).go(Routes.collaborators);
              }
            }
          },
        ),
        BlocListener<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LoginLoading) {
              showDialog<void>(
                context: context,
                barrierDismissible: false,
                builder: (_) => Stack(
                  children: const [
                    Center(
                      child: SizedBox(
                        width: 50,
                        height: 50,
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ],
      child: Scaffold(
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
                            style: Theme.of(context).textTheme.button!.apply(
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
                      style: Theme.of(context).textTheme.headline2!.apply(
                            fontWeightDelta: 100,
                          ),
                    ),
                    const SizedBox(height: 10),
                    const Expanded(
                      child: SingleChildScrollView(
                        child: LoginForm(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: SizedBox(
                        height: 56,
                        width: 400,
                        child: ElevatedButton(
                          onPressed: () {
                            context
                                .read<LoginCubit>()
                                .login(isAdmin: widget.isAdmin)
                                .then((value) {
                              if (value == null) {
                                return;
                              } else {
                                if (value == status.LoginState.success) {
                                  // context.read<LoginCubit>().cleanData();
                                  return;
                                } else {
                                  Navigator.of(context).pop();
                                  showDialog<void>(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title:
                                          const Text('Error de autenticación'),
                                      content: Text(
                                        getStringLoginStatus(value, l10n),
                                      ),
                                      actions: <Widget>[
                                        ElevatedButton(
                                          child: Text(context.l10n.accept),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              }
                            });
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
    );
  }

  @override
  bool get wantKeepAlive => true;
}
