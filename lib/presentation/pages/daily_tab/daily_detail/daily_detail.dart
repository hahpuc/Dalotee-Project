import 'package:dalotee/configs/routes.dart';
import 'package:dalotee/data/model/response/card_model.dart';
import 'package:dalotee/generated/assets/assets.gen.dart';
import 'package:dalotee/generated/assets/fonts.gen.dart';
import 'package:dalotee/presentation/pages/daily_tab/data.dart';
import 'package:dalotee/presentation/pages/daily_tab/widget/keyword_widget.dart';
import 'package:dalotee/presentation/widgets/base/custom_appbar.dart';
import 'package:dalotee/presentation/widgets/base/custom_text.dart';
import 'package:dalotee/values/dimens.dart';
import 'package:dalotee/values/font_sizes.dart';
import 'package:flutter/material.dart';

class DailyDetailPage extends StatefulWidget {
  CardData? card;
  DailyDetailPage({Key? key, this.card}) : super(key: key);

  @override
  _DailyDetailPageState createState() => _DailyDetailPageState();
}

class _DailyDetailPageState extends State<DailyDetailPage> {
  List<String> keywordList = [
    'Sự khởi đầu mới',
    'Niềm tin',
    'Tự phát',
    'Sự điên rồ'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  _buildAppBar() {
    return CustomAppBar(
      title: CustomText(
        'Thông điệp mỗi ngày',
        fontFamily: FontFamily.gelasio,
        fontSize: FontSize.BIG,
      ),
      leading: IconButton(
        icon: Assets.images.icBack.svg(),
        onPressed: () {
          Navigator.pushNamed(context, RoutePaths.BOTTOM_NAVIGATION);
        },
      ),
    );
  }

  _buildBody() {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: _cardInfo(card),
        ),
        SliverToBoxAdapter(
          child: _buildKeyword(card),
        ),
        SliverToBoxAdapter(
          child: _buildDescription(card),
        )
      ],
    );
  }

  _cardInfo(CardData card) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          card.front,
          scale: 2,
        ),
        CustomText(
          card.name ?? "",
          fontFamily: FontFamily.gelasio,
          fontSize: FontSize.BIG_1,
        )
      ],
    );
  }

  _buildKeyword(CardData card) {
    return Container(
      child: Column(
        children: [
          for (final item in keywordList) KeywordWidget(keyword: item)
        ],
      ),
    );
  }

  _buildDescription(CardData card) {
    return Container(
      margin: EdgeInsets.all(AppDimen.spacing_2),
      child: CustomText(
        description,
        maxLine: 100,
        align: TextAlign.justify,
      ),
    );
  }
}
