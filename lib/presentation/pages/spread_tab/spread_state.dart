import 'package:dalotee/bloc/base/base_state.dart';
import 'package:dalotee/data/model/response/spread/get_content_question_response.dart';

class SpreadPageState extends BaseState {}

class SpreadPageLoadingState extends SpreadPageState {}

class SpreadPageGetDataSuccessState extends SpreadPageState {
  List<ContentQuestionResponse> data;
  SpreadPageGetDataSuccessState(this.data);
}

class SpreadPageGetDataFailState extends SpreadPageState {
  String msg;
  SpreadPageGetDataFailState(this.msg);
}
