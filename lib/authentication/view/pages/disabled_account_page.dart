import 'package:flutter/material.dart';
import 'package:mi_libro_vecino/l10n/l10n.dart';
import 'package:mi_libro_vecino/ui_utils/colors.dart';
import 'package:mi_libro_vecino/ui_utils/constans/assets.dart';

class DisabledAcountPage extends StatelessWidget {
  const DisabledAcountPage({Key? key}) : super(key: key);

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
          padding: const EdgeInsets.symmetric(vertical: 20),
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
                'Cuenta inhabilitada',
                style: Theme.of(context).textTheme.headline1!.copyWith(
                      color: PColors.white,
                    ),
                overflow: TextOverflow.ellipsis,
                maxLines: 5,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Text(
                'Puedes volver a registrarse o contáctate con el administrado para recibir ayuda.',
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
                    key: const Key('disabled_page_button'),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(PColors.white),
                    ),
                    // TODO(oscarnar): Add a button to go somewhere.
                    onPressed: () {},
                    child: Text(
                      'CONTACTAR',
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
