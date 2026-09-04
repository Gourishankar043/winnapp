// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Registro de visitas de campo';

  @override
  String get visits => 'Visitas';

  @override
  String get newVisit => 'Nueva visita';

  @override
  String get editVisit => 'Editar visita';

  @override
  String get detail => 'Detalle';

  @override
  String get siteName => 'Nombre del sitio';

  @override
  String get enterSiteName => 'Introduce el nombre del sitio';

  @override
  String get date => 'Fecha';

  @override
  String get location => 'Ubicación';

  @override
  String get enterLocation => 'Introduce la ubicación';

  @override
  String get notes => 'Notas';

  @override
  String get enterVisitNotes => 'Introduce las notas de la visita';

  @override
  String get saveVisit => 'Guardar visita';

  @override
  String get saveChanges => 'Guardar cambios';

  @override
  String get save => 'Guardar';

  @override
  String get retry => 'Reintentar';

  @override
  String get edit => 'Editar';

  @override
  String get cancel => 'Cancelar';

  @override
  String get searchVisits => 'Buscar visitas';

  @override
  String get noVisitsLogged => 'Aún no hay visitas registradas';

  @override
  String get addFirstVisit =>
      'Pulsa el botón + para registrar tu primera visita.';

  @override
  String get addVisit => 'Añadir visita';

  @override
  String get noVisitsMatch => 'Ninguna visita coincide con tu búsqueda.';

  @override
  String get visitNotFound => 'Visita no encontrada';

  @override
  String get loggedBy => 'Registrado por';

  @override
  String get justNow => 'ahora mismo';

  @override
  String get offlineMessage =>
      'Estás sin conexión — los cambios se guardan localmente';

  @override
  String get syncSuccess => 'La visita se sincronizó correctamente.';

  @override
  String get syncDraft =>
      'La visita sigue como borrador. Puedes intentar sincronizarla de nuevo.';

  @override
  String get syncFailed =>
      'La sincronización de la visita falló. Inténtalo de nuevo.';

  @override
  String get syncOffline =>
      'No hay conexión a Internet. No se puede sincronizar. La visita permanece guardada como borrador.';

  @override
  String get requiredField => 'Este campo es obligatorio';

  @override
  String get language => 'Idioma';

  @override
  String get english => 'Inglés';

  @override
  String get spanish => 'Español';

  @override
  String get french => 'Francés';

  @override
  String get german => 'Alemán';

  @override
  String get italian => 'Italiano';
}
