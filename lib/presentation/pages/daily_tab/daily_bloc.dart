import 'package:dalotee/data/app_repository.dart';
import 'package:dalotee/data/model/response/card_model.dart';
import 'package:dalotee/generated/assets/assets.gen.dart';
import 'package:dalotee/presentation/pages/daily_tab/daily_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DailyPageBloc extends BlocBase<DailyPageState> {
  final AppRepository appRepository;

  DailyPageBloc({required this.appRepository}) : super(DailyPageState());

  Future<void> getListCard() async {
    emit(DailyPageLoadingState());
    List<CardData> listCard = [
      CardData(
          front: Assets.images.theFoolCard.path,
          back: Assets.images.backCard.path),
      CardData(
          front: Assets.images.theFoolCard.path,
          back: Assets.images.backCard.path),
      CardData(
          front: Assets.images.theFoolCard.path,
          back: Assets.images.backCard.path)
    ];
    if (listCard != null) {
      emit(DailyPageGetDataSuccessState(listCard));
    } else
      emit(DailyPageGetDataFailState());
  }
}
