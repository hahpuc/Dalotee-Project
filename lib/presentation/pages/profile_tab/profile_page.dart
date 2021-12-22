import 'package:dalotee/common/mixins/after_layout.dart';
import 'package:dalotee/configs/routes.dart';
import 'package:dalotee/configs/service_locator.dart';
import 'package:dalotee/data/local/pref_repository.dart';
import 'package:dalotee/data/model/response/user_response.dart';
import 'package:dalotee/generated/assets/fonts.gen.dart';
import 'package:dalotee/presentation/pages/profile_tab/profile_bloc.dart';
import 'package:dalotee/presentation/pages/profile_tab/profile_state.dart';
import 'package:dalotee/presentation/widgets/base/custom_appbar.dart';
import 'package:dalotee/presentation/widgets/base/custom_text.dart';
import 'package:dalotee/values/colors.dart';
import 'package:dalotee/values/dimens.dart';
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
      actions: [
        IconButton(
            onPressed: () {
              locator.get<PrefRepository>().clearHistory();
            },
            icon: Icon(
              Icons.settings,
              color: Colors.black,
            ))
      ],
      title: CustomText(
        "Trang cá nhân",
        fontFamily: FontFamily.gelasio,
        fontSize: FontSize.BIG_1,
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
              UserResponseData? user = state.user;
              if (user != null) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildAvatar(user),
                    _buildName(user),
                    _buildOption(user),
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

  _buildAvatar(UserResponseData user) {
    if (user.avatar != null) {
      return Container(
        margin: EdgeInsets.only(top: AppDimen.spacing_3),
        child: ClipOval(
          child: Image.network(user.avatar!,
              width: 100, height: 100, fit: BoxFit.cover),
        ),
      );
    } else {
      return CircleAvatar(
        backgroundColor: AppColor.colorPrimary,
        maxRadius: 100,
        child: Center(
            child: Icon(
          Icons.supervised_user_circle,
          color: Colors.white,
        )),
      );
    }
  }

  _buildName(UserResponseData user) {
    return Column(
      children: [
        Container(
          margin:
              EdgeInsets.fromLTRB(0, AppDimen.spacing_3, 0, AppDimen.spacing_1),
          child: CustomText(
            user.name!,
            fontFamily: FontFamily.gelasio,
            fontSize: FontSize.BIG,
          ),
        ),
        CustomText(
          user.birthDay!.day.toString() +
              '/' +
              user.birthDay!.month.toString() +
              '/' +
              user.birthDay!.year.toString(),
          fontFamily: FontFamily.nutinoSans,
          fontSize: FontSize.SMALL,
          color: AppColor.colorGreyText,
        ),
      ],
    );
  }

  _buildOption(UserResponseData user) {
    return InkWell(
      onTap: () {
        var history = locator.get<PrefRepository>().getListHistoryInLocal();
        // for (int i = 0; i < history.length; ++i) {
        //   print(' ----> Index $i ===> ${history[i].toJson()} \n');
        // }

        Navigator.pushNamed(context, RoutePaths.HISTORY_CARD,
            arguments: history);
      },
      child: Container(
        margin: EdgeInsets.symmetric(
            vertical: AppDimen.spacing_4,
            horizontal: AppDimen.horizontalSpacing),
        padding: EdgeInsets.symmetric(
            vertical: AppDimen.spacing_3, horizontal: AppDimen.spacing_2),
        decoration: BoxDecoration(
            color: AppColor.colorButton,
            borderRadius: BorderRadius.circular(AppDimen.spacing_1)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText('Lịch sử trải bài'),
            Icon(
              Icons.arrow_forward_ios,
              color: AppColor.colorGrey,
            )
          ],
        ),
      ),
    );
  }
}
