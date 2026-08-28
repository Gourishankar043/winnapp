import 'package:flutter/material.dart';

import '../../presentation/screens/create_visit_screen.dart';
import '../../presentation/screens/language_screen.dart';
import '../../presentation/screens/update_visit_screen.dart';
import '../../presentation/screens/visit_details_screen.dart';
import '../../presentation/screens/visit_list_screen.dart';
import 'route_names.dart';

class AppRoutes {
  AppRoutes._();

  static Route<dynamic> onGenerateRoute(
      RouteSettings settings, {
        required ValueChanged<Locale> onLocaleChanged,
      }) {
    switch (settings.name) {
      case RouteNames.visitList:
        return MaterialPageRoute(
          builder: (_) => VisitListScreen(
            onLocaleChanged: onLocaleChanged,
          ),
          settings: settings,
        );

      case RouteNames.createVisit:
        return MaterialPageRoute(
          builder: (_) => CreateVisitScreen(
            onLocaleChanged: onLocaleChanged,
          ),
          settings: settings,
        );

      case RouteNames.updateVisit:
        return MaterialPageRoute(
          builder: (_) => UpdateVisitScreen(
            onLocaleChanged: onLocaleChanged,
          ),
          settings: settings,
        );

      case RouteNames.visitDetails:
        return MaterialPageRoute(
          builder: (_) => VisitDetailsScreen(
            onLocaleChanged: onLocaleChanged,
          ),
          settings: settings,
        );

      case RouteNames.language:
        return MaterialPageRoute(
          builder: (_) => LanguageScreen(
            onLocaleChanged: onLocaleChanged,
          ),
          settings: settings,
        );

      default:
        return MaterialPageRoute(
          builder: (_) => VisitListScreen(
            onLocaleChanged: onLocaleChanged,
          ),
          settings: settings,
        );
    }
  }
}