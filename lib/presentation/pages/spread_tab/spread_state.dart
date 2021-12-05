import 'package:dalotee/bloc/base/base_state.dart';

class SpreadPageState extends BaseState {}

class SpreadPageLoadingState extends SpreadPageState {}

class SpreadPageGetDataSuccessState extends SpreadPageState {
  SpreadPageGetDataSuccessState();
}

class SpreadPageGetDataFailState extends SpreadPageState {}
