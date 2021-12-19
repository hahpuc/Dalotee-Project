import 'package:dalotee/bloc/base/base_state.dart';
import 'package:dalotee/data/model/response/get_card_category_response.dart';

class DailySelectedState extends BaseState {}

class DailySelectedLoadingState extends DailySelectedState {}

class DailySelectedLoadingStateSuccess extends DailySelectedState {
  final CardResponseModel data;

  DailySelectedLoadingStateSuccess(this.data);
}

class DailySelectedLoadingStateFailed extends DailySelectedState {
  final String msg;

  DailySelectedLoadingStateFailed(this.msg);
}
