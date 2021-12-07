import 'package:dalotee/presentation/bottom_navigation/bottom_navigation.dart';
import 'package:dalotee/presentation/pages/daily_detail/card_detail.dart';
import 'package:dalotee/presentation/pages/daily_tab/daily_page.dart';
import 'package:dalotee/presentation/pages/daily_tab/daily_selected/daily_selected_page.dart';
import 'package:dalotee/presentation/pages/spread_tab/question_spread/question_spread_page.dart';
import 'package:dalotee/presentation/pages/spread_tab/spread_card/spread_card_page.dart';
import 'package:flutter/material.dart';

class RoutePaths {
  static const String DAILY_PAGE = "/daily_page";
  static const String CARD_DETAIL = "/daily_detail";
  static const String DAILY_SELECTED = "/daily_selected";
  static const String BOTTOM_NAVIGATION = 'bottom_navigation';
  static const String SPREAD_LIST_QUESTION = '/spread_question';
  static const String SPREAD_CARD = '/spread_card';
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
        return MaterialPageRoute(
            builder: (_) => DailySelectedPage(), settings: settings);
      case RoutePaths.CARD_DETAIL:
        return MaterialPageRoute(
            builder: (_) => CardDetailPage(), settings: settings);
      case RoutePaths.SPREAD_LIST_QUESTION:
        return MaterialPageRoute(
            builder: (_) => QuestionSpreadPage(), settings: settings);
      case RoutePaths.SPREAD_CARD:
        return MaterialPageRoute(
            builder: (_) => SpreadCardPage(), settings: settings);
      default:
        return null;
    }
  }
}
