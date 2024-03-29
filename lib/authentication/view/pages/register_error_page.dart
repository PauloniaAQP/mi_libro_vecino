import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mi_libro_vecino/l10n/l10n.dart';
import 'package:mi_libro_vecino/router/app_routes.dart';
import 'package:mi_libro_vecino/ui_utils/colors.dart';
import 'package:mi_libro_vecino/ui_utils/constans/assets.dart';

class RegisterErrorPage extends StatelessWidget {
  const RegisterErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const SizedBox(width: 5),
            const Image(
              image: AssetImage(Assets.facebookLogo),
              height: 32,
            ),
            Expanded(
              child: Text(
                l10n.registerFacebookAccount,
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: PColors.white,
                    ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                Assets.errorRegisterImg,
                fit: BoxFit.contain,
                height: 250,
              ),
              const SizedBox(height: 50),
              Text(
                l10n.registerPageErrorMessage,
                style: Theme.of(context).textTheme.headline1!.copyWith(
                      color: PColors.white,
                    ),
                overflow: TextOverflow.ellipsis,
                maxLines: 5,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Text(
                l10n.registerPageErrorMessageSubtitle,
                style: Theme.of(context).textTheme.button!.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: PColors.white,
                    ),
                overflow: TextOverflow.ellipsis,
                maxLines: 5,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 60),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  height: 56,
                  width: 400,
                  child: ElevatedButton(
                    key: const Key('register_error_page_button'),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(PColors.white),
                    ),
                    onPressed: () => context.go(Routes.search),
                    child: Text(
                      l10n.registerPageBackToStartButton,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.button!.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
