import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/components/feedback/offline_banner.dart';
import '../core/theme/app_theme.dart';
import '../presentation/bloc/network/network_bloc.dart';
import '../presentation/bloc/network/network_event.dart';
import '../presentation/bloc/network/network_state.dart';
import '../presentation/bloc/visit/visit_bloc.dart';
import 'di/injection.dart';
import 'routes/app_routes.dart';
import 'routes/route_names.dart';

class App extends StatelessWidget {
  const App({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NetworkBloc>(
          create: (_) => getIt<NetworkBloc>()
            ..add(
              const CheckNetworkStatus(),
            ),
        ),
        BlocProvider<VisitBloc>(
          create: (_) => getIt<VisitBloc>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Field Visit Log',
        theme: AppTheme.lightTheme,
        initialRoute: RouteNames.visitList,
        onGenerateRoute: AppRoutes.onGenerateRoute,

        builder: (context, child) {
          return BlocBuilder<NetworkBloc, NetworkState>(
            builder: (context, state) {
              final isOffline = state is NetworkOffline;

              return Column(
                children: [
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    child: isOffline
                        ? const OfflineBanner(
                      key: ValueKey('offline-banner'),
                    )
                        : const SizedBox.shrink(
                      key: ValueKey('online-state'),
                    ),
                  ),
                  Expanded(
                    child: child ?? const SizedBox.shrink(),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}