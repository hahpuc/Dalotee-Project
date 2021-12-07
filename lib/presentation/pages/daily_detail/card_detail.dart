import 'package:dalotee/configs/routes.dart';
import 'package:dalotee/data/model/response/card_model.dart';
import 'package:dalotee/generated/assets/assets.gen.dart';
import 'package:dalotee/generated/assets/fonts.gen.dart';
import 'package:dalotee/presentation/pages/daily_tab/widget/keyword_widget.dart';
import 'package:dalotee/presentation/widgets/base/custom_appbar.dart';
import 'package:dalotee/presentation/widgets/base/custom_text.dart';
import 'package:dalotee/values/dimens.dart';
import 'package:dalotee/values/font_sizes.dart';
import 'package:flutter/material.dart';

class CardDetailPage extends StatefulWidget {
  CardDetailPage({Key? key}) : super(key: key);

  @override
  _CardDetailPageState createState() => _CardDetailPageState();
}

class _CardDetailPageState extends State<CardDetailPage> {
  List<String> keywordList = [
    'Sự khởi đầu mới',
    'Niềm tin',
    'Tự phát',
    'Sự điên rồ'
  ];
  @override
  Widget build(BuildContext context) {
    var arg = ModalRoute.of(context)!.settings.arguments as List;
    CardData card = arg[0];
    String titleAppBar = arg[1];

    return Scaffold(
      appBar: _buildAppBar(titleAppBar),
      body: _buildBody(titleAppBar, card),
    );
  }

  _buildAppBar(String title) {
    return CustomAppBar(
      title: CustomText(
        title,
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

  _buildBody(String title, CardData card) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: _cardInfo(card),
        ),
        SliverToBoxAdapter(
          child: _buildKeyword(card),
        ),
        SliverToBoxAdapter(
          child: _buildDescription(title, card),
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

  _buildDescription(String title, CardData card) {
    String description = '';
    title == 'Ý nghĩa lá bài'
        ? description = card.meaning ?? ''
        : description = card.description ?? '';
    print(card.meaning);
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
