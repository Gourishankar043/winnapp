// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Field Visit Log';

  @override
  String get visits => 'Visits';

  @override
  String get newVisit => 'New visit';

  @override
  String get editVisit => 'Edit visit';

  @override
  String get detail => 'Detail';

  @override
  String get siteName => 'Site name';

  @override
  String get enterSiteName => 'Enter site name';

  @override
  String get date => 'Date';

  @override
  String get location => 'Location';

  @override
  String get enterLocation => 'Enter location';

  @override
  String get notes => 'Notes';

  @override
  String get enterVisitNotes => 'Enter visit notes';

  @override
  String get saveVisit => 'Save visit';

  @override
  String get saveChanges => 'Save changes';

  @override
  String get save => 'Save';

  @override
  String get retry => 'Retry';

  @override
  String get edit => 'Edit';

  @override
  String get cancel => 'Cancel';

  @override
  String get searchVisits => 'Search visits';

  @override
  String get noVisitsLogged => 'No visits logged yet';

  @override
  String get addFirstVisit =>
      'Tap the + button to record your first site visit.';

  @override
  String get addVisit => 'Add visit';

  @override
  String get noVisitsMatch => 'No visits match your search.';

  @override
  String get visitNotFound => 'Visit not found';

  @override
  String get loggedBy => 'Logged by';

  @override
  String get justNow => 'just now';

  @override
  String get offlineMessage => 'You\'re offline — changes save locally';

  @override
  String get syncSuccess => 'Visit synced successfully.';

  @override
  String get syncFailed => 'Visit sync failed. Please try again.';

  @override
  String get syncOffline =>
      'No internet connection. Unable to sync. Visit remains saved as a draft.';

  @override
  String get requiredField => 'This field is required';

  @override
  String get language => 'Language';

  @override
  String get english => 'English';

  @override
  String get spanish => 'Español';

  @override
  String get french => 'Français';

  @override
  String get german => 'Deutsch';

  @override
  String get italian => 'Italiano';
}
