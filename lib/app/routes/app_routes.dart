import 'package:flutter/material.dart';
import '../../domain/entities/visit.dart';
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
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (_) => VisitListScreen(
            onLocaleChanged: onLocaleChanged,
          ),
        );

      case RouteNames.createVisit:
        return MaterialPageRoute<Visit?>(
          settings: settings,
          builder: (_) => CreateVisitScreen(
            onLocaleChanged: onLocaleChanged,
          ),
        );

      case RouteNames.updateVisit:
        return MaterialPageRoute<Visit?>(
          settings: settings,
          builder: (_) => UpdateVisitScreen(
            onLocaleChanged: onLocaleChanged,
          ),
        );

      case RouteNames.visitDetails:
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (_) => VisitDetailsScreen(
            onLocaleChanged: onLocaleChanged,
          ),
        );

      case RouteNames.language:
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (_) => LanguageScreen(
            onLocaleChanged: onLocaleChanged,
          ),
        );

      default:
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (_) => VisitListScreen(
            onLocaleChanged: onLocaleChanged,
          ),
        );
    }
  }
}