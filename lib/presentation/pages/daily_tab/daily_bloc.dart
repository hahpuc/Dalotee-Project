import 'package:dalotee/data/app_repository.dart';
import 'package:dalotee/data/model/response/card_model.dart';
import 'package:dalotee/presentation/pages/daily_tab/daily_state.dart';
import 'package:dalotee/presentation/pages/daily_tab/data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DailyPageBloc extends BlocBase<DailyPageState> {
  final AppRepository appRepository;

  DailyPageBloc({required this.appRepository}) : super(DailyPageState());

  Future<void> getListCard() async {
    emit(DailyPageLoadingState());
    List<CardData> listCard = [card, card, card, card];
    // ignore: unnecessary_null_comparison
    if (listCard != null) {
      emit(DailyPageGetDataSuccessState(listCard));
    } else
      emit(DailyPageGetDataFailState());
  }
}