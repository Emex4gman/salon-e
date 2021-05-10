import 'dart:async';

import 'package:flutter/material.dart';
import './app_translate.dart';

class AppTranslationsDelegate extends LocalizationsDelegate<AppTranslations> {
  final Locale? newLocale;

  const AppTranslationsDelegate({this.newLocale});

  @override
  bool isSupported(Locale locale) {
    return application.supportedLanguagesCodes.contains(locale.languageCode);
  }

  @override
  Future<AppTranslations> load(Locale locale) {
    return AppTranslations.load(newLocale ?? locale);
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppTranslations> old) {
    return true;
  }
}

class Application {
  static final Application _application = Application._internal();

  factory Application() => _application;

  Application._internal();

  final List<String> supportedLanguages = [
    "English",
    "French",
  ];

  final List<String> supportedLanguagesCodes = [
    "en",
    "fr",
  ];

  //returns the list of supported Locales
  Iterable<Locale> supportedLocales() => supportedLanguagesCodes.map<Locale>((language) => Locale(language, ""));

  //function to be invoked when changing the language
  LocaleChangeCallback? onLocaleChanged;
}

Application application = Application();

typedef void LocaleChangeCallback(Locale locale);
