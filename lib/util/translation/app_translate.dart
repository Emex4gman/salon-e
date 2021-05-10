import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class AppTranslations {
  Locale? locale;
  static Map<dynamic, dynamic> _localisedValues = {};

  AppTranslations(Locale locale) {
    this.locale = locale;
    _localisedValues = {};
  }

  static AppTranslations of(BuildContext context) {
    return Localizations.of<AppTranslations>(context, AppTranslations) as AppTranslations;
  }

  static Future<AppTranslations> load(Locale locale) async {
    AppTranslations appTranslations = AppTranslations(locale);
    String jsonContent = await rootBundle.loadString("assets/locale/${locale.languageCode}.json");
    _localisedValues = json.decode(jsonContent);
    return appTranslations;
  }

  get currentLanguage => locale!.languageCode;

  String text(String key) {
    if (_localisedValues[key] == null) debugPrint("$key not found");
    return _localisedValues[key] ?? key;
  }
}

// extension Trans on BuildContext {
//   String tr(String key) {
//     return AppTranslations.of(this).text(key);
//   }
// }
