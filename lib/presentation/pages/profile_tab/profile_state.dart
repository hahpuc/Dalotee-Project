import 'package:dalotee/bloc/base/base_state.dart';
import 'package:dalotee/data/model/response/user_response.dart';

class ProfilePageState extends BaseState {}

class ProfilePageLoadingState extends ProfilePageState {}

class ProfilePageGetDataSuccessState extends ProfilePageState {
  UserResponseData? user;
  ProfilePageGetDataSuccessState(user);
}

class ProfilePageGetDataFailState extends ProfilePageState {}
