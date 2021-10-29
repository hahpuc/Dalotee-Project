import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefRepositoryKeys {
  static const String LANGUAGE = "LANGUAGE";
}

class PrefRepository {
  final SharedPreferences _preferences;
  PrefRepository(this._preferences);

  Locale? getAppLanguage() {
    var langCode = _preferences.getString(PrefRepositoryKeys.LANGUAGE);
    if (langCode == null) return Locale('vi');
    return Locale(langCode);
  }

  Future<bool> setAppLanguage(Locale locale) {
    return _preferences.setString(
        PrefRepositoryKeys.LANGUAGE, locale.languageCode);
  }
}
