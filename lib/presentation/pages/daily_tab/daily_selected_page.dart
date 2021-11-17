import 'package:dalotee/configs/routes.dart';
import 'package:dalotee/data/model/response/card_model.dart';
import 'package:dalotee/generated/assets/assets.gen.dart';
import 'package:dalotee/generated/assets/fonts.gen.dart';
import 'package:dalotee/presentation/pages/daily_tab/data.dart';
import 'package:dalotee/presentation/widgets/base/custom_appbar.dart';
import 'package:dalotee/presentation/widgets/base/custom_button.dart';
import 'package:dalotee/presentation/widgets/base/custom_text.dart';
import 'package:dalotee/values/colors.dart';
import 'package:dalotee/values/dimens.dart';
import 'package:dalotee/values/font_sizes.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

class DailySelectedPage extends StatelessWidget {
  CardData cardChosen = card;
  DailySelectedPage({Key? key, required this.cardChosen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.colorPrimary,
      appBar: _buildAppBar(),
      body: _buildCard(context),
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

  Widget _buildCard(BuildContext context) {
    CardData card = CardData(
        front: Assets.images.theFoolCard.path,
        back: Assets.images.backCard.path);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FlipCard(
            front: Image.asset(
              cardChosen.back,
              scale: 6,
            ),
            back: Image.asset(
              cardChosen.front,
              scale: 1,
            ),
          ),
          CustomButton(
            "Chi tiết lá bài",
            textColor: AppColor.colorTextButton,
            backgroundColor: AppColor.colorButton,
            borderRadius: 20,
            padding: EdgeInsets.symmetric(
                vertical: AppDimen.spacing_2,
                horizontal: AppDimen.spacing_large),
            onTap: () => Navigator.pushNamed(context, RoutePaths.DAILY_DETAIL),
          )
        ],
      ),
    );
  }
}
