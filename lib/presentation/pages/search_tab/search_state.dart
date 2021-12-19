import 'package:dalotee/bloc/base/base_state.dart';
import 'package:dalotee/data/model/response/card_response.dart';

class SearchPageState extends BaseState {}

class SearchPageLoadingState extends SearchPageState {}

class SearchPageGetDataSuccessState extends SearchPageState {
  List<CardResponseModel> data;
  SearchPageGetDataSuccessState(this.data);
}

class SearchPageGetDataFailState extends SearchPageState {
  String? msg;
  SearchPageGetDataFailState(this.msg);
}
