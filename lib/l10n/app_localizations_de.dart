// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'Feldbesuchsprotokoll';

  @override
  String get visits => 'Besuche';

  @override
  String get newVisit => 'Neuer Besuch';

  @override
  String get editVisit => 'Besuch bearbeiten';

  @override
  String get detail => 'Details';

  @override
  String get siteName => 'Standortname';

  @override
  String get enterSiteName => 'Standortnamen eingeben';

  @override
  String get date => 'Datum';

  @override
  String get location => 'Ort';

  @override
  String get enterLocation => 'Ort eingeben';

  @override
  String get notes => 'Notizen';

  @override
  String get enterVisitNotes => 'Besuchsnotizen eingeben';

  @override
  String get saveVisit => 'Besuch speichern';

  @override
  String get saveChanges => 'Änderungen speichern';

  @override
  String get save => 'Speichern';

  @override
  String get retry => 'Erneut versuchen';

  @override
  String get edit => 'Bearbeiten';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get searchVisits => 'Besuche suchen';

  @override
  String get noVisitsLogged => 'Noch keine Besuche erfasst';

  @override
  String get addFirstVisit =>
      'Tippen Sie auf +, um Ihren ersten Standortbesuch zu erfassen.';

  @override
  String get addVisit => 'Besuch hinzufügen';

  @override
  String get noVisitsMatch => 'Keine Besuche entsprechen Ihrer Suche.';

  @override
  String get visitNotFound => 'Besuch nicht gefunden';

  @override
  String get loggedBy => 'Erfasst von';

  @override
  String get justNow => 'gerade eben';

  @override
  String get offlineMessage =>
      'Sie sind offline — Änderungen werden lokal gespeichert';

  @override
  String get requiredField => 'Dieses Feld ist erforderlich';

  @override
  String get language => 'Sprache';

  @override
  String get english => 'Englisch';

  @override
  String get spanish => 'Spanisch';

  @override
  String get french => 'Französisch';

  @override
  String get german => 'Deutsch';

  @override
  String get italian => 'Italienisch';
}
