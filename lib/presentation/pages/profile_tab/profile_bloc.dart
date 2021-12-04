import 'package:dalotee/data/app_repository.dart';
import 'package:dalotee/data/model/response/user_response.dart';
import 'package:dalotee/presentation/pages/profile_tab/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePageBloc extends BlocBase<ProfilePageState> {
  final AppRepository appRepository;

  ProfilePageBloc({required this.appRepository}) : super(ProfilePageState());

  Future<void> getData() async {
    emit(ProfilePageLoadingState());
    UserResponseData user = UserResponseData(
        avatar:
            'https://file.tinnhac.com/resize/600x-/2020/06/25/20200625233354-bf15.jpg',
        userId: 1,
        name: "Nguyen Thanh Long",
        birthDay: DateTime(2000, 04, 04));
    // ignore: unnecessary_null_comparison
    if (user != null) {
      emit(ProfilePageGetDataSuccessState(user));
    } else
      emit(ProfilePageGetDataFailState());
  }
}
