import 'package:flutter/material.dart';
import '../../../configs/flavor.dart';

class AppConfigWidget extends InheritedWidget {
  final Widget child;
  final FlavorConfig flavorConfig;

  AppConfigWidget({required this.child, required this.flavorConfig})
      : super(child: child);

  static AppConfigWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppConfigWidget>();
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}
