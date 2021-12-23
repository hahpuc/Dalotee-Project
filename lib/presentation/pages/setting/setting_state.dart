import 'package:dalotee/bloc/base/base_state.dart';
import 'package:dalotee/data/model/response/user_response.dart';

class SettingPageState extends BaseState {}

class SettingPageLoadingState extends SettingPageState {}

class SettingPageGetDataSuccessState extends SettingPageState {
  final UserResponseData user;
  SettingPageGetDataSuccessState(this.user);
}

class SettingPageGetDataFailState extends SettingPageState {}
