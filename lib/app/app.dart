import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../core/components/feedback/offline_banner.dart';
import '../core/localization/language_storage.dart';
import '../core/theme/app_theme.dart';
import '../l10n/app_localizations.dart';
import '../presentation/bloc/network/network_bloc.dart';
import '../presentation/bloc/network/network_event.dart';
import '../presentation/bloc/network/network_state.dart';
import '../presentation/bloc/visit/visit_bloc.dart';
import 'di/injection.dart';
import 'routes/app_routes.dart';
import 'routes/route_names.dart';

class App extends StatefulWidget {
  const App({super.key});
  @override
  State<App> createState() => _AppState();
}
class _AppState extends State<App> {
  late Locale _locale;
  @override
  void initState() {
    super.initState();
    final languageCode = getIt<LanguageStorage>().getLanguageCode();
    _locale = Locale(languageCode);
  }
  Future<void> _changeLocale(Locale locale) async {
    await getIt<LanguageStorage>().saveLanguageCode(locale.languageCode);
    if (!mounted) return;
    setState(() => _locale = locale);
  }
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NetworkBloc>(
          create: (_) => getIt<NetworkBloc>()..add(const CheckNetworkStatus()),
        ),
        BlocProvider<VisitBloc>(create: (_) => getIt<VisitBloc>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Field Visit Log',
        theme: AppTheme.lightTheme,
        locale: _locale,
        supportedLocales: const [
          Locale('en'),
          Locale('es'),
          Locale('fr'),
          Locale('de'),
          Locale('it'),
        ],
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        initialRoute: RouteNames.visitList,
        onGenerateRoute: (settings) => AppRoutes.onGenerateRoute(
          settings,
          onLocaleChanged: _changeLocale,
        ),
        builder: (context, child) {
          return BlocBuilder<NetworkBloc, NetworkState>(
            builder: (context, state) {
              final isOffline = state is NetworkOffline;
              return Column(
                children: [
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    child: isOffline
                        ? const OfflineBanner(key: ValueKey('offline-banner'))
                        : const SizedBox.shrink(key: ValueKey('online-state')),
                  ),
                  Expanded(child: child ?? const SizedBox.shrink()),
                ],
              );
            },
          );
        },
      ),
    );
  }
}