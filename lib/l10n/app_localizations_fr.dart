// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Journal des visites de terrain';

  @override
  String get visits => 'Visites';

  @override
  String get newVisit => 'Nouvelle visite';

  @override
  String get editVisit => 'Modifier la visite';

  @override
  String get detail => 'Détail';

  @override
  String get siteName => 'Nom du site';

  @override
  String get enterSiteName => 'Saisissez le nom du site';

  @override
  String get date => 'Date';

  @override
  String get location => 'Emplacement';

  @override
  String get enterLocation => 'Saisissez l\'emplacement';

  @override
  String get notes => 'Notes';

  @override
  String get enterVisitNotes => 'Saisissez les notes de visite';

  @override
  String get saveVisit => 'Enregistrer la visite';

  @override
  String get saveChanges => 'Enregistrer les modifications';

  @override
  String get save => 'Enregistrer';

  @override
  String get retry => 'Réessayer';

  @override
  String get edit => 'Modifier';

  @override
  String get cancel => 'Annuler';

  @override
  String get searchVisits => 'Rechercher des visites';

  @override
  String get noVisitsLogged => 'Aucune visite enregistrée';

  @override
  String get addFirstVisit =>
      'Appuyez sur + pour enregistrer votre première visite.';

  @override
  String get addVisit => 'Ajouter une visite';

  @override
  String get noVisitsMatch => 'Aucune visite ne correspond à votre recherche.';

  @override
  String get visitNotFound => 'Visite introuvable';

  @override
  String get loggedBy => 'Enregistré par';

  @override
  String get justNow => 'à l\'instant';

  @override
  String get offlineMessage =>
      'Vous êtes hors ligne — les modifications sont enregistrées localement';

  @override
  String get syncSuccess => 'La visite a été synchronisée avec succès.';

  @override
  String get syncFailed =>
      'La synchronisation de la visite a échoué. Veuillez réessayer.';

  @override
  String get syncOffline =>
      'Aucune connexion Internet. Impossible de synchroniser. La visite reste enregistrée comme brouillon.';

  @override
  String get requiredField => 'Ce champ est obligatoire';

  @override
  String get language => 'Langue';

  @override
  String get english => 'Anglais';

  @override
  String get spanish => 'Español';

  @override
  String get french => 'Français';

  @override
  String get german => 'Allemand';

  @override
  String get italian => 'Italien';
}
