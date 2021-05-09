import 'package:flutter/material.dart';

class NavigationService {
  factory NavigationService() => _instance;
  static final NavigationService _instance = NavigationService._internal();
  NavigationService._internal();

  final GlobalKey<NavigatorState> _navigationKey = GlobalKey<NavigatorState>();
  static get navigationKey => NavigationService()._navigationKey;
  static Future<dynamic> navigateTo(String routeName, {arguments}) async => NavigationService()._navigationKey.currentState!.pushNamed(routeName, arguments: arguments);

  static Future<dynamic> navigateToReplace(String routeName, {arguments}) async => NavigationService()._navigationKey.currentState!.pushReplacementNamed(routeName, arguments: arguments);

  static dynamic goBack([dynamic popValue]) => NavigationService()._navigationKey.currentState!.pop(popValue);

  static Future<bool> maybePop<T>([T? data]) => NavigationService()._navigationKey.currentState!.maybePop(data);

  static void popToHome() => NavigationService()._navigationKey.currentState!.popUntil((route) => route.isFirst);

  static Future<dynamic> navigateToWidget(Widget page, {arguments}) async => NavigationService()._navigationKey.currentState!.push(customPageRouteBuilder(page));
  static Future<dynamic> replaceWidget(Widget page, {arguments}) async => NavigationService()._navigationKey.currentState!.pushReplacement(customPageRouteBuilder(page));
}

PageRouteBuilder customPageRouteBuilder(Widget widget, {RouteSettings? settings}) {
  return PageRouteBuilder(
    settings: settings,
    transitionDuration: Duration(milliseconds: 700),
    transitionsBuilder: (context, animation, secAnimation, child) {
      final begin = Offset(0.0, 1.0);
      final end = Offset.zero;
      final curve = Curves.ease;

      final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      return SlideTransition(position: animation.drive(tween), child: child);
      // return FadeTransition(
      //   opacity: animation,
      //   child: child,
      // );
    },
    pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secAnimation) => widget,
  );
}

Widget customPageRouteBuilderNew(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
  final begin = Offset(0.0, 1.0);
  final end = Offset.zero;
  final curve = Curves.ease;

  final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
  return SlideTransition(position: animation.drive(tween), child: child);
}
