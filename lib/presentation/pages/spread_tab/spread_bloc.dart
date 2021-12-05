import 'package:dalotee/data/app_repository.dart';
import 'package:dalotee/data/model/response/card_model.dart';
import 'package:dalotee/generated/assets/assets.gen.dart';
import 'package:dalotee/presentation/pages/daily_tab/data.dart';
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

  Future<void> getData() async {
    emit(SpreadPageLoadingState());
    emit(SpreadPageGetDataSuccessState());
    // emit(SpreadPageGetDataFailState());
  }

  List<String>? getQuestionWithCategories(String category) {
    // List<String> listQuestion = [];
    // allQuestionList.forEach((element) {
    //   if (element == category) {
    //     listQuestion.add(element);
    //   }
    // });
    // return listQuestion;
    return allQuestionList;
  }

  // List<CardData>? getCardWithName(String name) {
  //   List<CardData> listCard = [];
  //   listAllCard.forEach((element) {
  //     if (element.name == name) {
  //       listCard.add(element);
  //     }
  //   });
  //   return listCard;
  // }
}
