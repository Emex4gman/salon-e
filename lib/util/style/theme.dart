import 'package:flutter/material.dart';

const Map<int, Color> color = {
  50: Color.fromRGBO(12, 86, 233, 1),
  100: Color.fromRGBO(12, 86, 233, 1),
  200: Color.fromRGBO(12, 86, 233, 1),
  300: Color.fromRGBO(12, 86, 233, 1),
  400: Color.fromRGBO(12, 86, 233, 1),
  500: Color.fromRGBO(12, 86, 233, 1),
  600: Color.fromRGBO(12, 86, 233, 1),
  700: Color.fromRGBO(12, 86, 233, 1),
  800: Color.fromRGBO(12, 86, 233, 1),
  900: Color.fromRGBO(12, 86, 233, 1),
};

class AppTheme {
  AppTheme._();
  //#51,51,51,1, 100%
  static const Color primaryColor = Color(0xffd32f2f);
  static const Color dark = Color(0xFF263238);
  static const Color light = Color(0xFFffffff);
  static const Color grey = Color(0xFF4f4f4f);

  static const Color inputBorder = grey;
  static const Color inputBorderFocus = grey;

  static ThemeData themeData = ThemeData(
    accentIconTheme: const IconThemeData(color: Colors.black),
    iconTheme: const IconThemeData(color: primaryColor),
    fontFamily: 'Nunito',
    buttonTheme: const ButtonThemeData(buttonColor: primaryColor),
    textTheme: const TextTheme(
      headline1: const TextStyle(color: primaryColor, fontWeight: FontWeight.w800, fontSize: 14),
      headline2: const TextStyle(color: dark, fontWeight: FontWeight.w800, fontSize: 14),
      bodyText1: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: primaryColor),
      bodyText2: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: dark),
      overline: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: primaryColor, letterSpacing: 0),
      subtitle1: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: primaryColor),
      subtitle2: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: dark),
      caption: const TextStyle(fontSize: 25, fontWeight: FontWeight.w700, color: primaryColor),
      button: const TextStyle(color: primaryColor),
    ),
    scaffoldBackgroundColor: light,
    backgroundColor: light,
    primarySwatch: Colors.red,
    buttonColor: primaryColor,
    primaryColor: primaryColor,
    // ignore: deprecated_member_use
    cursorColor: primaryColor,
  );
}
