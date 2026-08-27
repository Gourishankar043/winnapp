import 'package:shared_preferences/shared_preferences.dart';

class LanguageStorage {
  static const String _languageKey = 'selected_language';

  final SharedPreferences preferences;

  LanguageStorage({
    required this.preferences,
  });

  String getLanguageCode() {
    return preferences.getString(_languageKey) ?? 'en';
  }

  Future<void> saveLanguageCode(String languageCode) async {
    await preferences.setString(
      _languageKey,
      languageCode,
    );
  }
}