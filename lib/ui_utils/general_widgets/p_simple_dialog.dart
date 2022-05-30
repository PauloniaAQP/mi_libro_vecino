import 'package:flutter/material.dart';
import 'package:mi_libro_vecino/l10n/l10n.dart';

Future<void> pSimpleDialog({
  required BuildContext context,
  required String title,
  required String body,
}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        content: Container(
          width: 600,
          padding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 25,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2!
                      .copyWith(fontSize: 20),
                ),
                const SizedBox(height: 38),
                Text(
                  body,
                  maxLines: 3,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                const SizedBox(height: 38),
                TextButton(
                  child: Text(
                    context.l10n.accept,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                      fontSize: 18,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
