import 'package:flutter/material.dart';
import 'package:mi_libro_vecino/ui_utils/colors.dart';
import 'package:mi_libro_vecino/ui_utils/typography.dart';

class PTheme {
  static ThemeData get standard {
    return ThemeData(
      colorScheme: _colorScheme,
      backgroundColor: PColors.whiteBackground,
      scaffoldBackgroundColor: PColors.white,
      textTheme: _textTheme,
      elevatedButtonTheme: _elevatedButtonTheme,
      appBarTheme: _appBarTheme,
      inputDecorationTheme: _inputDecorationTheme,
      chipTheme: _chipTheme,
      scrollbarTheme: _scrollBarTheme,
      buttonTheme: _buttonTheme,
    );
  }

  static ColorScheme get _colorScheme {
    return const ColorScheme(
      primary: PColors.blue,
      primaryVariant: PColors.blue,
      secondary: PColors.blue,
      secondaryVariant: PColors.blueVariant,
      surface: PColors.whiteBackground,
      background: PColors.whiteBackground,
      error: PColors.red,
      onPrimary: PColors.whiteBackground,
      onSecondary: PColors.whiteBackground,
      onSurface: PColors.whiteBackground,
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
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
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

  static InputDecorationTheme get _inputDecorationTheme {
    return const InputDecorationTheme(
      border: InputBorder.none,
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: PColors.red,
          width: 2,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: PColors.transparent,
          width: 2,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: PColors.blueVariant,
          width: 2,
        ),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: PColors.transparent,
          width: 2,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: PColors.red,
          width: 2,
        ),
      ),
      alignLabelWithHint: true,
      floatingLabelBehavior: FloatingLabelBehavior.always,
      labelStyle: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w500,
      ),
      floatingLabelStyle: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w500,
        height: 1,
      ),
      errorStyle: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  static ChipThemeData get _chipTheme {
    return const ChipThemeData(
      backgroundColor: Color(0xFFEDFAFF),
      selectedColor: PColors.blue,
      disabledColor: PColors.gray3,
      labelStyle: TextStyle(
        fontSize: 14,
        color: PColors.blue,
        fontWeight: FontWeight.w500,
      ),
      brightness: Brightness.light,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      secondaryLabelStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      secondarySelectedColor: PColors.blue,
    );
  }

  static ScrollbarThemeData get _scrollBarTheme {
    return ScrollbarThemeData(
      thumbColor:
          MaterialStateProperty.all(const Color.fromARGB(141, 117, 117, 117)),
      // isAlwaysShown: true,
      thumbVisibility: MaterialStateProperty.all(true),
    );
  }

  static ButtonThemeData get _buttonTheme {
    return const ButtonThemeData(
      alignedDropdown: true,
    );
  }
}
