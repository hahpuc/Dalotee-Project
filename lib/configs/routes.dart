import 'package:flutter/material.dart';

class RoutePaths {
  static const String DEMO = "/demo";
  static const String HOME = "/home";
}

class Routes {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // case RoutePaths.DEMO:
      //   String title = settings.arguments as String;
      //   return MaterialPageRoute(
      //       builder: (_) => DemoPage(title: title), settings: settings);
      // case RoutePaths.HOME:
      //   return MaterialPageRoute(
      //       builder: (_) => HomePage(), settings: settings);
      default:
        return null;
    }
  }
}
