import 'package:flutter/material.dart';
import 'package:mi_libro_vecino/ui_utils/colors.dart';
import 'package:mi_libro_vecino/ui_utils/typography.dart';

class PTheme {
  static ThemeData get standard {
    return ThemeData(
      colorScheme: _colorScheme,
      backgroundColor: PColors.whiteBackground,
      scaffoldBackgroundColor: PColors.whiteBackground,
      textTheme: _textTheme,
      elevatedButtonTheme: _elevatedButtonTheme,
      appBarTheme: _appBarTheme,
    );
  }

  static ColorScheme get _colorScheme {
    return const ColorScheme(
      primary: PColors.purple,
      primaryVariant: PColors.purple,
      secondary: PColors.blue,
      secondaryVariant: PColors.blueVariant,
      surface: PColors.whiteBackground,
      background: PColors.whiteBackground,
      error: PColors.red,
      onPrimary: PColors.whiteBackground,
      onSecondary: PColors.whiteBackground,
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

  static ElevatedButtonThemeData get _elevatedButtonTheme {
    return ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return PColors.blue;
            } else if (states.contains(MaterialState.disabled)) {
              return PColors.gray3;
            }
            return PColors.blue;
          },
        ),
      ),
    );
  }

  static AppBarTheme get _appBarTheme {
    return const AppBarTheme(
      toolbarHeight: 80,
      elevation: 0,
    );
  }
}
