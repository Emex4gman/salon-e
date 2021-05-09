import 'package:flutter/material.dart';
import 'theme.dart';

class SalonText {
  static Text headlineOne(
    String text, {
    Color color = AppTheme.dark,
    double size = 23,
    TextAlign textAlign: TextAlign.left,
  }) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: size,
        color: color,
      ),
    );
  }

  static Text headlineTwo(
    String text, {
    Color color = AppTheme.dark,
    double size = 17,
    TextAlign textAlign: TextAlign.left,
  }) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: size,
        color: color,
      ),
    );
  }

  static Text headlineThree(
    String text, {
    Color color = AppTheme.dark,
    double size = 14,
    TextAlign textAlign: TextAlign.left,
  }) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: size,
        color: color,
      ),
    );
  }

  static Text body(
    String text, {
    Color color = AppTheme.dark,
    double size = 14,
    TextAlign textAlign: TextAlign.left,
    FontWeight fontWeight: FontWeight.w400,
  }) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(fontWeight: fontWeight, fontSize: size, color: color, fontFamily: "Nunito"),
    );
  }

  static Text disclaimer(
    String text, {
    Color color = AppTheme.dark,
    double size = 14,
    TextAlign textAlign: TextAlign.left,
    FontWeight fontWeight: FontWeight.w400,
  }) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontWeight: fontWeight,
        fontSize: size,
        color: color,
        fontFamily: "Nunito",
        fontStyle: FontStyle.italic,
      ),
    );
  }

  static Text bodyTwo(String text, {Color color = AppTheme.grey, double size = 13}) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: size,
        color: color,
      ),
    );
  }

  static Text button(
    String text, {
    Color color = AppTheme.dark,
    double size = 14,
    TextAlign textAlign = TextAlign.left,
  }) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: size,
        color: color,
      ),
    );
  }
}
