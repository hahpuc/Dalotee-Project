import 'package:dalotee/data/app_repository.dart';
import 'package:dalotee/data/model/response/user_response.dart';
import 'package:dalotee/presentation/pages/profile_tab/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePageBloc extends BlocBase<ProfilePageState> {
  final AppRepository appRepository;

  ProfilePageBloc({required this.appRepository}) : super(ProfilePageState());

  UserResponseData user = UserResponseData(
      userId: 1, name: "Nguyen Thanh Long", birthDay: DateTime(2000, 04, 04));
  Future<void> getData() async {
    emit(ProfilePageLoadingState());
    if (user != null) {
      print('SSSSSSSSSSSSSSSSSSS');
      emit(ProfilePageGetDataSuccessState(user));
    } else
      emit(ProfilePageGetDataFailState());
  }
}
