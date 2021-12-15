import 'package:flutter/material.dart';
import 'package:mi_libro_vecino/utils_ui/colors.dart';
import 'package:mi_libro_vecino/utils_ui/typography.dart';

class PTheme {
  static ThemeData get standard {
    return ThemeData(
      colorScheme: _colorScheme,
      backgroundColor: PColors.whiteBackground,
      scaffoldBackgroundColor: PColors.whiteBackground,
      textTheme: _textTheme,
    );
  }

  static ColorScheme get _colorScheme {
    return const ColorScheme(
      primary: PColors.blue,
      primaryVariant: PColors.blueVariant,
      secondary: PColors.purple,
      secondaryVariant: PColors.purple,
      surface: PColors.whiteBackground,
      background: PColors.whiteBackground,
      error: PColors.red,
      onPrimary: PColors.blueVariant,
      onSecondary: PColors.blueVariant,
      onSurface: PColors.white,
      onBackground: PColors.whiteBackground,
      onError: PColors.red,
      brightness: Brightness.light,
    );
  }

  static TextTheme get _textTheme {
    return TextTheme(
      headline1: PTextStyle.headline1,
      headline2: PTextStyle.headline2,
      headline3: PTextStyle.headline3,
      headline4: PTextStyle.headline4,
      subtitle1: PTextStyle.subtitle1,
      subtitle2: PTextStyle.subtitle2,
      bodyText1: PTextStyle.bodyText1,
      bodyText2: PTextStyle.bodyText2,
      caption: PTextStyle.caption,
      button: PTextStyle.button,
    );
  }
}
