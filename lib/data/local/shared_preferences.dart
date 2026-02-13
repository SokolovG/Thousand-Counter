import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesManager {
  final SharedPreferences _prefs;
  SharedPreferencesManager(this._prefs);

  Future<void> setString(String key, String value) async {
    await _prefs.setString(key, value);
  }

  String? getString(String key) {
    return _prefs.getString(key);
  }
}
