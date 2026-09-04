import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
class LanguageScreen extends StatelessWidget {
  final ValueChanged<Locale>? onLocaleChanged;
  const LanguageScreen({
    super.key,
    this.onLocaleChanged,
  });
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final currentLocale = Localizations.localeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          localizations.language,
        ),
      ),
      body: ListView(
        children: [
          _LanguageTile(
            title: localizations.english,
            locale: const Locale('en'),
            selected: currentLocale.languageCode == 'en',
            onTap: onLocaleChanged,
          ),
          _LanguageTile(
            title: localizations.spanish,
            locale: const Locale('es'),
            selected: currentLocale.languageCode == 'es',
            onTap: onLocaleChanged,
          ),
          _LanguageTile(
            title: localizations.french,
            locale: const Locale('fr'),
            selected: currentLocale.languageCode == 'fr',
            onTap: onLocaleChanged,
          ),
          _LanguageTile(
            title: localizations.german,
            locale: const Locale('de'),
            selected: currentLocale.languageCode == 'de',
            onTap: onLocaleChanged,
          ),
          _LanguageTile(
            title: localizations.italian,
            locale: const Locale('it'),
            selected: currentLocale.languageCode == 'it',
            onTap: onLocaleChanged,
          ),
        ],
      ),
    );
  }
}
class _LanguageTile extends StatelessWidget {
  final String title;
  final Locale locale;
  final bool selected;
  final ValueChanged<Locale>? onTap;
  const _LanguageTile({
    required this.title,
    required this.locale,
    required this.selected,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      trailing: selected
          ? const Icon(Icons.check)
          : null,
      onTap: () {
        onTap?.call(locale);
        Navigator.pop(context);
      },
    );
  }
}