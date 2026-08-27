import 'package:flutter/material.dart';

import '../../presentation/screens/create_visit_screen.dart';
import '../../presentation/screens/update_visit_screen.dart';
import '../../presentation/screens/visit_details_screen.dart';
import '../../presentation/screens/visit_list_screen.dart';
import 'route_names.dart';

class AppRoutes {
  AppRoutes._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.visitList:
        return MaterialPageRoute(
          builder: (_) => const VisitListScreen(),
        );

      case RouteNames.createVisit:
        return MaterialPageRoute(
          builder: (_) => const CreateVisitScreen(),
        );

      case RouteNames.updateVisit:
        return MaterialPageRoute(
          builder: (_) => const UpdateVisitScreen(),
          settings: settings,
        );

      case RouteNames.visitDetails:
        return MaterialPageRoute(
          builder: (_) => const VisitDetailsScreen(),
          settings: settings,
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const VisitListScreen(),
        );
    }
  }
}