import 'package:dalotee/bloc/base/base_bloc.dart';
import 'package:dalotee/data/app_repository.dart';
import 'package:dalotee/data/model/response/get_card_category_response.dart';
import 'package:dalotee/presentation/pages/spread_tab/spread_card/spread_card_state.dart';

class SpreadCardBloc extends BaseBloc<SpreadCardState> {
  final AppRepository appRepository;
  SpreadCardBloc({required this.appRepository}) : super(SpreadCardState());

  Future<void> getCardByNumber(int number1, int number2, int number3) async {
    List<CardResponseModel> listCard = [];

    var responseCard1 =
        await appRepository.apiService.getCardByNumber(number1.toString());

    if (responseCard1.isSuccessful()) {
      final resultData = responseCard1.response?.data;

      listCard.add(resultData!.data![0]);
    } else {
      emit(SpreadCardLoadingStateFailed('Failed to get data'));
    }

    var responseCard2 =
        await appRepository.apiService.getCardByNumber(number2.toString());

    if (responseCard2.isSuccessful()) {
      final resultData = responseCard2.response?.data;

      listCard.add(resultData!.data![0]);
    } else {
      emit(SpreadCardLoadingStateFailed('Failed to get data'));
    }

    var responseCard3 =
        await appRepository.apiService.getCardByNumber(number3.toString());

    if (responseCard3.isSuccessful()) {
      final resultData = responseCard3.response?.data;

      listCard.add(resultData!.data![0]);
    } else {
      emit(SpreadCardLoadingStateFailed('Failed to get data'));
    }

    emit(SpreadCardLoadingStateSuccess(listCard));
  }
}
