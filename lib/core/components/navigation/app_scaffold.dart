import 'package:flutter/material.dart';

import 'app_drawer.dart';

class AppScaffold extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget body;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  final ValueChanged<Locale> onLocaleChanged;

  const AppScaffold({
    super.key,
    required this.body,
    required this.onLocaleChanged,
    this.appBar,
    this.floatingActionButton,
    this.bottomNavigationBar,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      drawer: AppDrawer(
        onLocaleChanged: onLocaleChanged,
      ),
      body: body,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}