import 'package:card_swiper/card_swiper.dart';
import 'package:dalotee/common/mixins/after_layout.dart';
import 'package:dalotee/configs/routes.dart';
import 'package:dalotee/configs/service_locator.dart';
import 'package:dalotee/data/model/response/card_model.dart';
import 'package:dalotee/generated/assets/assets.gen.dart';
import 'package:dalotee/generated/assets/fonts.gen.dart';
import 'package:dalotee/presentation/pages/daily_tab/daily_bloc.dart';
import 'package:dalotee/presentation/pages/daily_tab/daily_state.dart';
import 'package:dalotee/presentation/pages/daily_tab/data.dart';
import 'package:dalotee/presentation/widgets/base/custom_appbar.dart';
import 'package:dalotee/presentation/widgets/base/custom_text.dart';
import 'package:dalotee/values/colors.dart';
import 'package:dalotee/values/dimens.dart';
import 'package:dalotee/values/font_sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class DailyPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DailyPageState();
  }
}

class _DailyPageState extends State<DailyPage> with AfterLayoutMixin {
  DailyPageBloc _bloc = DailyPageBloc(appRepository: locator.get());
  double _opacity = 0;
  CardData _cardChosen = card;

  @override
  void afterFirstFrame(BuildContext context) {
    _bloc.getListCard();
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
        "Thông điệp mỗi ngày",
        fontFamily: FontFamily.gelasio,
        fontSize: FontSize.BIG,
      ),
    );
  }

  _blocListener(BuildContext context, DailyPageState state) async {
    // print("State $state");
    if (state is DailyPageLoadingState) {
      EasyLoading.show(status: 'loading', maskType: EasyLoadingMaskType.black);
    } else {
      EasyLoading.dismiss();
    }
  }

  Widget _buildBody() {
    return BlocProvider(
      create: (context) => _bloc,
      child: BlocListener<DailyPageBloc, DailyPageState>(
        listener: _blocListener,
        child: BlocBuilder<DailyPageBloc, DailyPageState>(
          bloc: _bloc,
          builder: (context, state) {
            if (state is DailyPageGetDataSuccessState) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _getCurrentTime(),
                  _buildCardChosen(),
                  _buildListCard(state.listCard),
                ],
              );
            }
            return Container();
          },
        ),
      ),
    );
  }

  Widget _getCurrentTime() {
    final currentTime = DateTime.now();
    return CustomText(
        "Ngày ${currentTime.day} tháng ${currentTime.month} năm ${currentTime.year}",
        color: Colors.black);
  }

  Widget _buildCardChosen() {
    return Expanded(
      child: Stack(
        children: [
          _opacity == 0
              ? Center(
                  child: Image.asset(
                    Assets.images.imgPlanet.path,
                    width: 250.0,
                    height: 250.0,
                  ),
                )
              : Container(),
          Center(
            child: AnimatedOpacity(
                duration: Duration(milliseconds: 1000),
                curve: Curves.easeIn,
                onEnd: () {
                  Future.delayed(Duration(milliseconds: 700), () {
                    Navigator.pushNamed(context, RoutePaths.DAILY_SELECTED,
                        arguments: _cardChosen);
                  });
                },
                opacity: _opacity,
                child: Image.asset(
                  Assets.images.imgBackCard.path,
                  scale: 10,
                )),
          ),
        ],
      ),
    );
  }

  Widget _buildListCard(List<CardData> listCard) {
    return Column(
      children: [
        CustomText(
          "Chọn 1 lá bài",
          fontSize: FontSize.BIG,
        ),
        Container(
          width: 24,
          height: 24,
          margin: EdgeInsets.symmetric(vertical: AppDimen.spacing_1),
          child: Image.asset(
            Assets.images.arrowDown.path,
            color: Colors.black,
          ),
        ),
        Center(
          child: Container(
            margin: EdgeInsets.only(bottom: AppDimen.spacing_2),
            width: MediaQuery.of(context).size.width,
            height: 200,
            child: Swiper(
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    print(index);
                    setState(() {
                      _opacity = _opacity == 0 ? 1 : 0;
                      _cardChosen = listCard[index];
                    });
                  },
                  child: Image.asset(
                    listCard[index].back,
                    width: 85,
                    height: 183,
                  ),
                );
              },
              itemCount: listCard.length,
              viewportFraction: 0.25,
              scale: 0.5,
            ),
          ),
        ),
      ],
    );
  }
}
