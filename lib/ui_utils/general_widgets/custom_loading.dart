import 'dart:ui';

import 'package:flutter/material.dart';

class CustomLoading extends StatelessWidget {
  const CustomLoading({Key? key, this.circularLoadingColor = Colors.white})
      : super(key: key);

  final Color circularLoadingColor;

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Container(
        decoration: BoxDecoration(color: Colors.black.withOpacity(.3)),
        child: Center(
          child: CircularProgressIndicator(color: circularLoadingColor),
        ),
      ),
    );
  }
}
