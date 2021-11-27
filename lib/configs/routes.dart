import 'package:dalotee/data/model/response/card_model.dart';
import 'package:dalotee/presentation/bottom_navigation/bottom_navigation.dart';
import 'package:dalotee/presentation/pages/daily_tab/daily_detail/daily_detail.dart';
import 'package:dalotee/presentation/pages/daily_tab/daily_page.dart';
import 'package:dalotee/presentation/pages/daily_tab/daily_selected/daily_selected_page.dart';
import 'package:flutter/material.dart';

class RoutePaths {
  static const String DAILY_PAGE = "/daily_page";
  static const String DAILY_DETAIL = "/daily_detail";
  static const String DAILY_SELECTED = "/daily_selected";
  static const String BOTTOM_NAVIGATION = 'bottom_navigation';
}

class Routes {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.BOTTOM_NAVIGATION:
        return MaterialPageRoute(
            builder: (_) => BottomNavigation(), settings: settings);
      case RoutePaths.DAILY_PAGE:
        return MaterialPageRoute(
            builder: (_) => DailyPage(), settings: settings);
      case RoutePaths.DAILY_SELECTED:
        CardData card = settings.arguments as CardData;
        return MaterialPageRoute(
            builder: (_) => DailySelectedPage(
                  cardChosen: card,
                ),
            settings: settings);
      case RoutePaths.DAILY_DETAIL:
        CardData card = settings.arguments as CardData;
        return MaterialPageRoute(
            builder: (_) => DailyDetailPage(
                  card: card,
                ),
            settings: settings);
      default:
        return null;
    }
  }
}
