import 'package:dalotee/bloc/base/base_state.dart';
import 'package:dalotee/data/model/response/get_card_category_response.dart';

class SpreadCardState extends BaseState {}

class SpreadCardLoadingState extends SpreadCardState {}

class SpreadCardLoadingStateSuccess extends SpreadCardState {
  final List<CardResponseModel> data;

  SpreadCardLoadingStateSuccess(this.data);
}

class SpreadCardLoadingStateFailed extends SpreadCardState {
  final String msg;

  SpreadCardLoadingStateFailed(this.msg);
}
