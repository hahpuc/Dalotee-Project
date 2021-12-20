import 'dart:math';

import 'package:dalotee/common/mixins/after_layout.dart';
import 'package:dalotee/configs/routes.dart';
import 'package:dalotee/configs/service_locator.dart';
import 'package:dalotee/data/model/response/spread/get_content_question_response.dart';
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
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class SpreadTypeID {
  static const String Love = "61bcac81c6fc90d1a7437545";
  static const String Career = "61bcac92c6fc90d1a7437548";
  static const String Money = "61bcac9ac6fc90d1a743754b";
  static const String Study = "61bff32455bde8cad2ef6292";
  static const String Future = "61bcacb0c6fc90d1a743754e";
}

class SpreadPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SpreadPageState();
  }
}

class _SpreadPageState extends State<SpreadPage> with AfterLayoutMixin {
  SpreadPageBloc _bloc = SpreadPageBloc(appRepository: locator.get());
  List<String> contentQuestionsId = [
    SpreadTypeID.Love,
    SpreadTypeID.Career,
    SpreadTypeID.Money,
    SpreadTypeID.Study,
    SpreadTypeID.Future,
  ];

  List<String> contentQuestions = [
    Assets.images.icLove.path,
    Assets.images.icCareer.path,
    Assets.images.icMoney.path,
    Assets.images.icStudy.path,
    Assets.images.icProphecy.path,
  ];
  List<String> iconSpread = [
    Assets.images.imgCardSpreadLeft.path,
    Assets.images.imgCardSpreadRight.path,
    Assets.images.imgOneCardSpread.path,
    Assets.images.imgOneCardSpread.path
  ];
  ValueNotifier<int> _currentIndex = ValueNotifier<int>(0);

  @override
  void afterFirstFrame(BuildContext context) {
    // _bloc.getData();

    _bloc.getContentQuestion(contentQuestionsId[0]);
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
    return BlocProvider(
      create: (context) => _bloc,
      child: DefaultTabController(
        length: contentQuestions.length,
        child: Builder(
          builder: (BuildContext context) {
            final TabController tabController =
                DefaultTabController.of(context)!;
            tabController.addListener(() {
              if (!tabController.indexIsChanging) {
                _currentIndex.value = tabController.index;

                _bloc.getContentQuestion(
                    contentQuestionsId[tabController.index]);
              }
            });
            return Scaffold(
                backgroundColor: AppColor.colorPrimary,
                appBar: _buildAppBar(),
                body: TabBarView(
                  children: [
                    for (int i = 0; i < 5; i++)
                      _buildListCard(contentQuestions[i])
                  ],
                ));
          },
        ),
      ),
    );
  }

  CustomAppBar _buildAppBar() {
    return CustomAppBar(
      title: CustomText("Trải bài",
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
          child: TabBar(
              isScrollable: true,
              indicator: BoxDecoration(color: Colors.transparent),
              tabs: [
                for (int i = 0; i < contentQuestions.length; i++)
                  ValueListenableBuilder<int>(
                      valueListenable: _currentIndex,
                      builder:
                          (BuildContext context, int value, Widget? child) {
                        return Center(
                          child: Image.asset(
                            contentQuestions[i],
                            width: AppDimen.spacing_4,
                            height: AppDimen.spacing_4,
                            color: value == i
                                ? AppColor.colorSelected
                                : AppColor.colorUnselected,
                          ),
                        );
                      })
              ]),
        ),
      ),
    );
  }

  Widget _buildListCard(String category) {
    List<ContentQuestionResponse>? list = [];

    return BlocListener<SpreadPageBloc, SpreadPageState>(
      listener: _blocListener,
      child: BlocBuilder<SpreadPageBloc, SpreadPageState>(
        bloc: _bloc,
        builder: (context, state) {
          if (state is SpreadPageGetDataSuccessState) {
            list = state.data;
            return _buildGridView(list ?? []);
          }
          return Container();
        },
      ),
    );

    // return BlocListener(child: _buildGridView(list));
  }

  Widget _buildGridView(List<ContentQuestionResponse>? list) {
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
                            item.contentQuestion ?? 'Content Question',
                            fontSize: 16.0,
                            align: TextAlign.center,
                            fontFamily: FontFamily.poppins,
                          ),
                        ),
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
