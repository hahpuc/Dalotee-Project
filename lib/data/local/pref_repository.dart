import 'dart:convert';

import 'package:dalotee/data/model/response/get_card_category_response.dart';
import 'package:dalotee/data/model/response/history_response.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefRepositoryKeys {
  static const String LANGUAGE = "LANGUAGE";
  static const String History = "HISTORY";
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

  Future<bool> addCartToHistory(CardResponseModel data) {
    List<HistoryResponse> currentHistory = getListHistoryInLocal();

    HistoryResponse card =
        HistoryResponse(time: DateTime.now().toString(), data: data);

    currentHistory.add(card);

    return _preferences.setStringList(PrefRepositoryKeys.History,
        currentHistory.map((e) => jsonEncode(e)).toList());
  }

  Future<bool> setUpListHistoryInLocal() {
    List<HistoryResponse> list = [];

    return _preferences.setStringList(
        PrefRepositoryKeys.History, list.map((e) => jsonEncode(e)).toList());
  }

  List<HistoryResponse> getListHistoryInLocal() {
    List<String>? list = _preferences.getStringList(PrefRepositoryKeys.History);

    List<HistoryResponse> listResult = [];
    if (list != null) {
      listResult =
          list.map((e) => HistoryResponse.fromJson(jsonDecode(e))).toList();
    }
    return listResult;
  }

  Future<bool> clearHistory() {
    List<HistoryResponse> list = [];
    return _preferences.setStringList(
        PrefRepositoryKeys.History, list.map((e) => jsonEncode(e)).toList());
  }
}
