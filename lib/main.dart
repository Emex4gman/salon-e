import 'package:flutter/material.dart';
import 'package:salon_e/ui/loading_screen.dart';
import 'package:salon_e/util/style/theme.dart';
import 'sevices/navigation_service.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'util/translation/app_translate.dart';
import 'util/translation/app_translate_delegate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late AppTranslationsDelegate _newLocaleDelegate;
  @override
  void initState() {
    super.initState();
    _newLocaleDelegate = AppTranslationsDelegate(newLocale: null);
    application.onLocaleChanged = onLocaleChange;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Salon E",
      localizationsDelegates: [
        _newLocaleDelegate,
        const AppTranslationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: application.supportedLocales(),
      debugShowCheckedModeBanner: false,
      theme: AppTheme.themeData,
      home: LoadingScreen(),
      navigatorKey: NavigationService.navigationKey,
    );
  }

  void onLocaleChange(Locale locale) {
    setState(() {
      _newLocaleDelegate = AppTranslationsDelegate(newLocale: locale);
    });
  }
}

extension Trans on BuildContext {
  String tr(String key) {
    return AppTranslations.of(this).text(key);
  }
}
