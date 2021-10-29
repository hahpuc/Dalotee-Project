import 'package:flutter/material.dart';
import 'package:dalotee/bloc/base/base_state.dart';

class LocaleState extends BaseState {
  final Locale locale;

  LocaleState(this.locale);
}
