import 'package:flutter/material.dart';
import 'package:dalotee/bloc/base/base_bloc.dart';
import 'package:dalotee/bloc/locale/locale_state.dart';
import 'package:dalotee/data/local/pref_repository.dart';

class LocaleBloc extends BaseBloc<LocaleState> {
  PrefRepository _prefRepository;

  LocaleBloc(this._prefRepository) : super(LocaleState(Locale("vi"))) {
    _initLocale();
  }

  void changeLocale(Locale locale) async {
    await _prefRepository.setAppLanguage(locale);
    emit(LocaleState(locale));
  }

  void getLocale() async {
    var currentLocale = _prefRepository.getAppLanguage();
    if (currentLocale != null) {
      emit(LocaleState(currentLocale));
    }
  }

  void _initLocale() async {
    var currentLocale = _prefRepository.getAppLanguage();
    if (currentLocale == null) {
      currentLocale = Locale('vi');
      await _prefRepository.setAppLanguage(currentLocale);
    }
    emit(LocaleState(currentLocale));
  }
}
