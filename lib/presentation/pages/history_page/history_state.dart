import 'package:dalotee/bloc/base/base_state.dart';
import 'package:dalotee/data/model/response/user_response.dart';

class HistoryPageState extends BaseState {}

class HistoryPageLoadingState extends HistoryPageState {}

class HistoryPageSuccessState extends HistoryPageState {
  final UserResponseData user;
  HistoryPageSuccessState(this.user);
}

class HistoryPageFailedState extends HistoryPageState {}
