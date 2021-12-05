import 'dart:math';

import 'package:dalotee/common/mixins/after_layout.dart';
import 'package:dalotee/configs/routes.dart';
import 'package:dalotee/configs/service_locator.dart';
import 'package:dalotee/generated/assets/assets.gen.dart';
import 'package:dalotee/generated/assets/fonts.gen.dart';
import 'package:dalotee/presentation/pages/spread_tab/spread_bloc.dart';
import 'package:dalotee/presentation/pages/spread_tab/spread_state.dart';
import 'package:dalotee/presentation/widgets/base/custom_appbar.dart';
import 'package:dalotee/presentation/widgets/base/custom_text.dart';
import 'package:dalotee/values/colors.dart';
import 'package:dalotee/values/dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';

class SpreadPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SpreadPageState();
  }
}

class _SpreadPageState extends State<SpreadPage> with AfterLayoutMixin {
  SpreadPageBloc _bloc = SpreadPageBloc(appRepository: locator.get());
  List<String> categories = ['Love', 'Work', 'Money', 'Study', 'Prophecy'];
  List<String> iconSpread = [
    Assets.images.cardSpreadLeft.path,
    Assets.images.cardSpreadRight.path,
    Assets.images.crossSpread.path,
    Assets.images.oneCardSpread.path
  ];

  @override
  void afterFirstFrame(BuildContext context) {
    _bloc.getData();
  }

  _blocListener(BuildContext context, SpreadPageState state) async {
    if (state is SpreadPageLoadingState) {
      EasyLoading.show(status: 'loading', maskType: EasyLoadingMaskType.black);
    } else {
      EasyLoading.dismiss();
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: categories.length,
      child: Builder(
        builder: (BuildContext context) {
          return Scaffold(
              backgroundColor: AppColor.colorPrimary,
              appBar: _buildAppBar(),
              body: TabBarView(
                children: [
                  for (int i = 0; i < 5; i++) _buildListCard(categories[i])
                ],
              ));
        },
      ),
    );
  }

  CustomAppBar _buildAppBar() {
    return CustomAppBar(
      title: CustomText("Tra cứu lá bài",
          fontFamily: FontFamily.gelasio, fontSize: AppDimen.sizeAppBarText),
      leading: SizedBox(),
      bottom: PreferredSize(
        preferredSize: Size(0, 30),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: AppDimen.spacing_3),
          padding: EdgeInsets.symmetric(
              vertical: AppDimen.spacing_1, horizontal: AppDimen.spacing_3),
          decoration: BoxDecoration(
              color: AppColor.colorButton,
              borderRadius: BorderRadius.circular(AppDimen.spacing_2)),
          child: Column(
            children: [
              TabBar(
                  isScrollable: true,
                  indicatorColor: Colors.transparent,
                  tabs: [
                    for (final item in categories)
                      Center(
                        child: CustomText(
                          item,
                          color: Colors.black,
                        ),
                      )
                  ]),
            ],
          ),
        ),
      ),
    );
  }

  _buildListCard(String category) {
    List<String>? list = _bloc.getQuestionWithCategories(category);
    return _buildGridView(list);
  }

  _buildGridView(List<String>? list) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: AppDimen.spacing_2),
      child: GridView.builder(
          itemCount: list?.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: AppDimen.spacing_4,
              mainAxisSpacing: AppDimen.spacing_5,
              mainAxisExtent: 280),
          itemBuilder: (BuildContext context, int index) {
            if (list != null) {
              final item = list[index];
              return InkWell(
                onTap: () {
                  Navigator.pushNamed(context, RoutePaths.SPREAD_LIST_QUESTION,
                      arguments: item);
                },
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: AppColor.colorBlurPink.withOpacity(0.2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(180))),
                        child: Container(
                          margin: EdgeInsets.all(25),
                          height: 125,
                          width: 125,
                          decoration: BoxDecoration(
                              color: AppColor.colorButton,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(180))),
                          child: Center(
                              child:
                                  Image.asset(iconSpread[Random().nextInt(4)])),
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: AppDimen.spacing_2),
                        child: Center(
                            child: CustomText(
                          item,
                          fontSize: 16.0,
                          fontFamily: FontFamily.poppins,
                        )),
                      )
                    ],
                  ),
                ),
              );
            } else {
              return Container();
            }
          }),
    );
  }
}
