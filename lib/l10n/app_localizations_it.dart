// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get appTitle => 'Registro delle visite sul campo';

  @override
  String get visits => 'Visite';

  @override
  String get newVisit => 'Nuova visita';

  @override
  String get editVisit => 'Modifica visita';

  @override
  String get detail => 'Dettaglio';

  @override
  String get siteName => 'Nome del sito';

  @override
  String get enterSiteName => 'Inserisci il nome del sito';

  @override
  String get date => 'Data';

  @override
  String get location => 'Posizione';

  @override
  String get enterLocation => 'Inserisci la posizione';

  @override
  String get notes => 'Note';

  @override
  String get enterVisitNotes => 'Inserisci le note della visita';

  @override
  String get saveVisit => 'Salva visita';

  @override
  String get saveChanges => 'Salva modifiche';

  @override
  String get save => 'Salva';

  @override
  String get retry => 'Riprova';

  @override
  String get edit => 'Modifica';

  @override
  String get cancel => 'Annulla';

  @override
  String get searchVisits => 'Cerca visite';

  @override
  String get noVisitsLogged => 'Nessuna visita registrata';

  @override
  String get addFirstVisit => 'Tocca + per registrare la tua prima visita.';

  @override
  String get addVisit => 'Aggiungi visita';

  @override
  String get noVisitsMatch => 'Nessuna visita corrisponde alla ricerca.';

  @override
  String get visitNotFound => 'Visita non trovata';

  @override
  String get loggedBy => 'Registrato da';

  @override
  String get justNow => 'proprio ora';

  @override
  String get offlineMessage =>
      'Sei offline — le modifiche vengono salvate localmente';

  @override
  String get syncSuccess => 'Visita sincronizzata correttamente.';

  @override
  String get syncFailed =>
      'La sincronizzazione della visita non è riuscita. Riprova.';

  @override
  String get syncOffline =>
      'Nessuna connessione Internet. Impossibile sincronizzare. La visita rimane salvata come bozza.';

  @override
  String get requiredField => 'Questo campo è obbligatorio';

  @override
  String get language => 'Lingua';

  @override
  String get english => 'Inglese';

  @override
  String get spanish => 'Spagnolo';

  @override
  String get french => 'Francese';

  @override
  String get german => 'Tedesco';

  @override
  String get italian => 'Italiano';
}
