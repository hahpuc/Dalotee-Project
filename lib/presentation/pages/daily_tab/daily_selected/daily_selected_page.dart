import 'package:dalotee/configs/routes.dart';
import 'package:dalotee/data/model/response/card_model.dart';
import 'package:dalotee/generated/assets/assets.gen.dart';
import 'package:dalotee/generated/assets/fonts.gen.dart';
import 'package:dalotee/presentation/pages/daily_tab/data.dart';
import 'package:dalotee/presentation/widgets/base/app_back_button.dart';
import 'package:dalotee/presentation/widgets/base/custom_appbar.dart';
import 'package:dalotee/presentation/widgets/base/custom_button.dart';
import 'package:dalotee/presentation/widgets/base/custom_text.dart';
import 'package:dalotee/values/colors.dart';
import 'package:dalotee/values/dimens.dart';
import 'package:dalotee/values/font_sizes.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

class DailySelectedPage extends StatefulWidget {
  DailySelectedPage({Key? key}) : super(key: key);

  @override
  State<DailySelectedPage> createState() => _DailySelectedPageState();
}

class _DailySelectedPageState extends State<DailySelectedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.colorPrimary,
      appBar: _buildAppBar(),
      body: _buildCard(),
    );
  }

  CustomAppBar _buildAppBar() {
    return CustomAppBar(
      leading: AppBackButton(),
      title: CustomText(
        "Thông điệp mỗi ngày",
        fontFamily: FontFamily.gelasio,
        fontSize: FontSize.BIG,
      ),
    );
  }

  Widget _buildCard() {
    var card = ModalRoute.of(context)!.settings.arguments as CardData;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FlipCard(
            front: Image.asset(
              card.back,
              scale: 6,
            ),
            back: Image.asset(
              card.front,
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
              horizontal: AppDimen.spacing_large,
            ),
            onTap: () => Navigator.pushNamed(context, RoutePaths.DAILY_DETAIL,
                arguments: card),
          )
        ],
      ),
    );
  }
}
