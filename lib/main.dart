import 'package:flutter/material.dart';
import 'package:salon_e/ui/loading_screen.dart';
import 'package:salon_e/util/style/theme.dart';
import 'sevices/navigation_service.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Salon E",
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''),
        const Locale('ar', ''),
        const Locale('fr_CA', ''),
      ],
      debugShowCheckedModeBanner: false,
      theme: AppTheme.themeData,
      home: LoadingScreen(),
      navigatorKey: NavigationService.navigationKey,
    );
  }
}
