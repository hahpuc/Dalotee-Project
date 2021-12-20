import 'package:dalotee/data/app_repository.dart';
import 'package:dalotee/presentation/pages/spread_tab/question_spread/question_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListQuestionBloc extends BlocBase<ListQuestionState> {
  final AppRepository appRepository;

  ListQuestionBloc({required this.appRepository}) : super(ListQuestionState());

  Future<void> getContentQuestion(String typeID) async {
    // emit(SearchPageLoadingState());

    var response =
        await appRepository.apiService.getQuestionsByContentID(typeID);

    if (response.isSuccessful()) {
      final resultData = response.response?.data;

      emit(ListQuestionSuccessState(resultData!.data!));
    } else {
      emit(ListQuestionFailedState('Failed to get data'));
    }
  }
}
