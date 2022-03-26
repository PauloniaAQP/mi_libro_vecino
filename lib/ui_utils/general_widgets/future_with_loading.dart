import 'package:flutter/material.dart';

Future<T?> futureWithLoading<T>(Future<T?> future, BuildContext context) async {
  T? _result;
  await showDialog<T>(
    context: context,
    barrierDismissible: false,
    builder: (_) => FutureBuilder<T?>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          _result = snapshot.data;
          Navigator.of(context, rootNavigator: true).pop();
        }
        return Stack(
          children: const [
            Center(
              child: SizedBox(
                width: 50,
                height: 50,
                child: CircularProgressIndicator(),
              ),
            ),
          ],
        );
      },
    ),
  );
  return _result;
}
