import 'package:dalotee/common/mixins/after_layout.dart';
import 'package:dalotee/configs/service_locator.dart';
import 'package:dalotee/data/model/response/user_response.dart';
import 'package:dalotee/generated/assets/fonts.gen.dart';
import 'package:dalotee/presentation/pages/profile_tab/profile_bloc.dart';
import 'package:dalotee/presentation/pages/profile_tab/profile_state.dart';
import 'package:dalotee/presentation/widgets/base/custom_appbar.dart';
import 'package:dalotee/presentation/widgets/base/custom_text.dart';
import 'package:dalotee/values/colors.dart';
import 'package:dalotee/values/font_sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProfilePageState();
  }
}

class _ProfilePageState extends State<ProfilePage> with AfterLayoutMixin {
  ProfilePageBloc _bloc = ProfilePageBloc(appRepository: locator.get());

  @override
  void afterFirstFrame(BuildContext context) {
    _bloc.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.colorPrimary,
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  CustomAppBar _buildAppBar() {
    return CustomAppBar(
      leading: Container(),
      title: CustomText(
        "Trang cá nhân",
        fontFamily: FontFamily.gelasio,
        fontSize: FontSize.BIG,
      ),
    );
  }

  _blocListener(BuildContext context, ProfilePageState state) async {
    if (state is ProfilePageLoadingState) {
      EasyLoading.show(status: 'loading', maskType: EasyLoadingMaskType.black);
    } else {
      EasyLoading.dismiss();
    }
  }

  Widget _buildBody() {
    return BlocProvider(
      create: (context) => _bloc,
      child: BlocListener<ProfilePageBloc, ProfilePageState>(
        listener: _blocListener,
        child: BlocBuilder<ProfilePageBloc, ProfilePageState>(
          bloc: _bloc,
          builder: (context, state) {
            if (state is ProfilePageGetDataSuccessState) {
              print(state.user.toString());
              UserResponseData? user = state.user;
              if (user != null) {
                return Column(
                  children: [
                    CircleAvatar(
                      maxRadius: 50,
                    ),
                    CustomText(user.name!)
                  ],
                );
              } else {
                EasyLoading.show(
                    status: 'loading', maskType: EasyLoadingMaskType.black);
              }
            }
            return Container();
          },
        ),
      ),
    );
  }
}
