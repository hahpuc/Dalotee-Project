import 'package:dalotee/bloc/base/base_bloc.dart';
import 'package:dalotee/data/app_repository.dart';
import 'package:dalotee/presentation/pages/demo/demo_state.dart';
import 'package:dalotee/utils/ext_utils.dart';

class DemoBloc extends BaseBloc<DemoState> {
  final AppRepository appRepository;
  DemoBloc({required this.appRepository}) : super(DemoState());

  int _count = 0;

  void increaseValue() {
    _count = _count + 1;
    emit(DemoIntState(value: _count));
  }

  void getValue() {
    emit(DemoIntState(value: _count));
  }

  Future<void> requestNetwork() async {
    emit(DemoLoadingState());
    var result = await appRepository.getDemo();
    if (result.isSuccessful()) {
      emit(DemoNetworkState(data: result.response!.toMap().toString()));
    } else {
      emit(DemoNetworkState(data: result.exception!.apiErrorMessage()));
    }
  }
}
