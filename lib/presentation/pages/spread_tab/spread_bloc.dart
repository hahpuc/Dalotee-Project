import 'package:dalotee/data/app_repository.dart';
import 'package:dalotee/presentation/pages/spread_tab/spread_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SpreadPageBloc extends BlocBase<SpreadPageState> {
  final AppRepository appRepository;

  SpreadPageBloc({required this.appRepository}) : super(SpreadPageState());

  List<String> allQuestionList = [
    'Mối quan hệ tình yêu hiện tại',
    'Mối quan hệ đã kết thúc',
    'Vì sao tôi vẫn còn độc thân',
    'Người yêu tương lai của tôi'
  ];

//   Future<void> getData() async {
//     emit(SpreadPageLoadingState());
//     emit(SpreadPageGetDataSuccessState());
//     // emit(SpreadPageGetDataFailState());
//   }

  Future<void> getContentQuestion(String typeID) async {
    // emit(SearchPageLoadingState());

    var response =
        await appRepository.apiService.getContentQuestionByType(typeID);

    if (response.isSuccessful()) {
      final resultData = response.response?.data;

      emit(SpreadPageGetDataSuccessState(resultData!.data!));
    } else {
      emit(SpreadPageGetDataFailState('Failed to get data'));
    }
  }
}
