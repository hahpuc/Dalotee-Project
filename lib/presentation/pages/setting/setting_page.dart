import 'dart:developer';

import 'package:dalotee/common/mixins/after_layout.dart';
import 'package:dalotee/configs/routes.dart';
import 'package:dalotee/configs/service_locator.dart';
import 'package:dalotee/data/model/response/user_response.dart';
import 'package:dalotee/generated/assets/fonts.gen.dart';
import 'package:dalotee/presentation/pages/profile_tab/profile_bloc.dart';
import 'package:dalotee/presentation/pages/profile_tab/profile_state.dart';
import 'package:dalotee/presentation/widgets/base/app_back_button.dart';
import 'package:dalotee/presentation/widgets/base/custom_appbar.dart';
import 'package:dalotee/presentation/widgets/base/custom_text.dart';
import 'package:dalotee/values/colors.dart';
import 'package:dalotee/values/dimens.dart';
import 'package:dalotee/values/font_sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';

class SettingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SettingPageState();
  }
}

class _SettingPageState extends State<SettingPage> with AfterLayoutMixin {
  ProfilePageBloc _bloc = ProfilePageBloc(appRepository: locator.get());
  late TextEditingController _nameController;
  late TextEditingController _birthDayController;
  late TextEditingController _phoneController;

  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  @override
  void afterFirstFrame(BuildContext context) {
    _bloc.getData();
  }

  @override
  void initState() {
    _nameController = TextEditingController();
    _birthDayController = TextEditingController();
    _phoneController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _birthDayController.dispose();
    _phoneController.dispose();
    super.dispose();
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
      leading: AppBackButton(),
      title: CustomText(
        "Chỉnh sửa thông tin cá nhân",
        fontFamily: FontFamily.gelasio,
        fontSize: FontSize.BIG_1,
      ),
      actions: [
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.done,
              color: Colors.black,
            ))
      ],
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
              print(user.phoneNumber);
              _nameController.text = user.name ?? '';
              _birthDayController.text =
                  formatter.format(user.birthDay ?? DateTime.now()).toString();
              _phoneController.text = user.phoneNumber ?? '';
              if (user != null) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildName(user),
                    _buildBirthday(user),
                    _buildPhone(),
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

  Widget _buildName(UserResponseData user) {
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: AppDimen.spacing_2, horizontal: AppDimen.spacing_3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            'Họ và Tên',
            fontFamily: FontFamily.gelasio,
            fontSize: FontSize.BIG,
          ),
          Container(
            child: TextFormField(
              controller: _nameController,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildBirthday(UserResponseData user) {
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: AppDimen.spacing_1, horizontal: AppDimen.spacing_3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            'Ngày sinh',
            fontFamily: FontFamily.gelasio,
            fontSize: FontSize.BIG,
          ),
          TextFormField(
            controller: _birthDayController,
            decoration: InputDecoration(
              suffix: IconButton(
                  onPressed: () {
                    DatePicker.showDatePicker(context,
                        showTitleActions: true,
                        minTime: DateTime(1950, 1, 1),
                        maxTime: DateTime(2022, 1, 1), onChanged: (date) {
                      print('change $date');
                    }, onConfirm: (date) {
                      _birthDayController.text =
                          formatter.format(date).toString();
                    }, currentTime: DateTime.now(), locale: LocaleType.vi);
                  },
                  icon: Icon(Icons.calendar_today),
                  color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhone() {
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: AppDimen.spacing_2, horizontal: AppDimen.spacing_3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            'Số điện thoại',
            fontFamily: FontFamily.gelasio,
            fontSize: FontSize.BIG,
          ),
          Container(
            child: TextFormField(
              controller: _phoneController,
            ),
          )
        ],
      ),
    );
  }
}
