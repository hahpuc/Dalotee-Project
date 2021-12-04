import 'package:dalotee/bloc/base/base_state.dart';

class SearchPageState extends BaseState {}

class SearchPageLoadingState extends SearchPageState {}

class SearchPageGetDataSuccessState extends SearchPageState {
  SearchPageGetDataSuccessState();
}

class SearchPageGetDataFailState extends SearchPageState {}
