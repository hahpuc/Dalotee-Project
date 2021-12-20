import 'package:dalotee/bloc/base/base_state.dart';
import 'package:dalotee/data/model/response/spread/get_questions_response.dart';

class ListQuestionState extends BaseState {}

class ListQuestionLoadingState extends ListQuestionState {}

class ListQuestionSuccessState extends ListQuestionState {
  List<QuestionResponse> data;
  ListQuestionSuccessState(this.data);
}

class ListQuestionFailedState extends ListQuestionState {
  String msg;
  ListQuestionFailedState(this.msg);
}
