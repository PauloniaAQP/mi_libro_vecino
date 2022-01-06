import 'package:flutter/material.dart';
import 'package:mi_libro_vecino/l10n/l10n.dart';
import 'package:mi_libro_vecino/ui_utils/constans/assets.dart';

class WaitingPage extends StatelessWidget {
  const WaitingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(),
        Image.asset(
          Assets.waitingIcon,
          fit: BoxFit.cover,
          height: 185,
          width: 185,
        ),
        Text(
          l10n.registerPageWaitingMessage,
          style: Theme.of(context).textTheme.bodyText2!.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
          overflow: TextOverflow.ellipsis,
          maxLines: 5,
          textAlign: TextAlign.center,
        ),
        const Spacer(),
        Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            height: 56,
            width: 400,
            child: ElevatedButton(
              key: const Key('waiting_page_button'),
              onPressed: () {},
              child: Text(
                l10n.registerPageBackToStartButton,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        )
      ],
    );
  }
}
