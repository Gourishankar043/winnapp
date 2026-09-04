import 'package:flutter/material.dart';
import '../../../app/routes/route_names.dart';
import '../../../l10n/app_localizations.dart';

class AppDrawer extends StatelessWidget {
  final ValueChanged<Locale> onLocaleChanged;
  const AppDrawer({super.key, required this.onLocaleChanged});
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context);
    return Drawer(
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(l10n.appTitle, style: Theme.of(context).textTheme.headlineSmall),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.list_alt_outlined),
              title: Text(l10n.visits),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamedAndRemoveUntil(context, RouteNames.visitList, (route) => false);
              },
            ),
            ListTile(
              leading: const Icon(Icons.add_circle_outline),
              title: Text(l10n.addVisit),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, RouteNames.createVisit);
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.language),
              title: Text(l10n.language),
              subtitle: Text(_languageName(l10n, locale.languageCode)),
              onTap: () => _showLanguageSelector(context, l10n, locale),
            ),
          ],
        ),
      ),
    );
  }

  void _showLanguageSelector(BuildContext context, AppLocalizations l10n, Locale currentLocale) {
    showModalBottomSheet<void>(
      context: context,
      builder: (sheetContext) => SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: [
            _languageTile(sheetContext, l10n.english, 'en', currentLocale),
            _languageTile(sheetContext, l10n.spanish, 'es', currentLocale),
            _languageTile(sheetContext, l10n.french, 'fr', currentLocale),
            _languageTile(sheetContext, l10n.german, 'de', currentLocale),
            _languageTile(sheetContext, l10n.italian, 'it', currentLocale),
          ],
        ),
      ),
    );
  }
  Widget _languageTile(BuildContext context, String title, String languageCode, Locale currentLocale) {
    final isSelected = currentLocale.languageCode == languageCode;
    return ListTile(
      title: Text(title),
      trailing: isSelected ? const Icon(Icons.check) : null,
      onTap: () {
        onLocaleChanged(Locale(languageCode));
        Navigator.pop(context);
      },
    );
  }
  String _languageName(AppLocalizations l10n, String languageCode) {
    switch (languageCode) {
      case 'es':
        return l10n.spanish;
      case 'fr':
        return l10n.french;
      case 'de':
        return l10n.german;
      case 'it':
        return l10n.italian;
      case 'en':
      default:
        return l10n.english;
    }
  }
}