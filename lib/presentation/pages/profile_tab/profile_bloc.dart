import 'dart:developer';

import 'package:dalotee/data/app_repository.dart';
import 'package:dalotee/data/model/response/user_response.dart';
import 'package:dalotee/presentation/pages/profile_tab/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePageBloc extends BlocBase<ProfilePageState> {
  final AppRepository appRepository;
  ProfilePageBloc({required this.appRepository}) : super(ProfilePageState());

  Future<void> getData(UserResponseData? user) async {
    emit(ProfilePageLoadingState());
    if (user != null) {
      emit(ProfilePageGetDataSuccessState(user));
    } else
      emit(ProfilePageGetDataFailState());
  }
}
