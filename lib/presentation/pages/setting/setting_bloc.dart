import 'package:dalotee/data/app_repository.dart';
import 'package:dalotee/data/model/response/user_response.dart';
import 'package:dalotee/presentation/pages/setting/setting_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingPageBloc extends BlocBase<SettingPageState> {
  final AppRepository appRepository;

  SettingPageBloc({required this.appRepository}) : super(SettingPageState());

  Future<void> getData() async {
    emit(SettingPageLoadingState());
    UserResponseData user = UserResponseData(
        avatar:
            'https://file.tinnhac.com/resize/600x-/2020/06/25/20200625233354-bf15.jpg',
        userId: 1,
        name: "Nguyen Thanh Long",
        birthDay: DateTime(2000, 04, 04),
        phoneNumber: "08785674");
    // ignore: unnecessary_null_comparison
    if (user != null) {
      emit(SettingPageGetDataSuccessState(user));
    } else
      emit(SettingPageGetDataFailState());
  }
}
