import 'package:dalotee/bloc/base/base_bloc.dart';
import 'package:dalotee/data/app_repository.dart';
import 'package:dalotee/presentation/pages/daily_tab/daily_selected/daily_selected_state.dart';

class DailySelectedBloc extends BaseBloc<DailySelectedState> {
  final AppRepository appRepository;
  DailySelectedBloc({required this.appRepository})
      : super(DailySelectedState());

  Future<void> getCardByNumber(int number) async {
    var response =
        await appRepository.apiService.getCardByNumber(number.toString());

    if (response.isSuccessful()) {
      final resultData = response.response?.data;

      emit(DailySelectedLoadingStateSuccess(resultData!.data![0]));
    } else {
      emit(DailySelectedLoadingStateFailed('Failed to get data'));
    }
  }
}
