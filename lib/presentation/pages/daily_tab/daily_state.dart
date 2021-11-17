import 'package:dalotee/bloc/base/base_state.dart';
import 'package:dalotee/data/model/response/card_model.dart';

class DailyPageState extends BaseState {}

class DailyPageLoadingState extends DailyPageState {}

class DailyPageGetDataSuccessState extends DailyPageState {
  final List<CardData> listCard;
  DailyPageGetDataSuccessState(this.listCard);
}

class DailyPageGetDataFailState extends DailyPageState {}
