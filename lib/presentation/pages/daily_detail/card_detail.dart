import 'package:dalotee/configs/routes.dart';
import 'package:dalotee/data/model/response/get_card_category_response.dart';
import 'package:dalotee/generated/assets/assets.gen.dart';
import 'package:dalotee/generated/assets/fonts.gen.dart';
import 'package:dalotee/presentation/pages/daily_tab/widget/keyword_widget.dart';
import 'package:dalotee/presentation/widgets/base/custom_appbar.dart';
import 'package:dalotee/presentation/widgets/base/custom_text.dart';
import 'package:dalotee/values/colors.dart';
import 'package:dalotee/values/font_sizes.dart';
import 'package:flutter/material.dart';

class CardDetailPage extends StatefulWidget {
  CardDetailPage({Key? key}) : super(key: key);

  @override
  _CardDetailPageState createState() => _CardDetailPageState();
}

class _CardDetailPageState extends State<CardDetailPage> {
  List<KeyWordData> keywordList = [];
  @override
  Widget build(BuildContext context) {
    var card = ModalRoute.of(context)!.settings.arguments as CardResponseModel;
    // CardData card = arg[0];
    // String titleAppBar = arg[1];

    return Scaffold(
      backgroundColor: AppColor.colorPrimary,
      appBar: _buildAppBar(card.name ?? 'Card Name'),
      body: _buildBody(card.name ?? 'Card Name', card),
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
          Navigator.popUntil(context, (Route<dynamic> route) => route.isFirst);
        },
      ),
    );
  }

  _buildBody(String title, CardResponseModel card) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: _cardInfo(card),
        ),
        SliverToBoxAdapter(
          child: _buildKeyword(card),
        ),
        SliverToBoxAdapter(
          child: _buildContent('Nội dung: ', card.content ?? 'Content'),
        ),
        SliverToBoxAdapter(
          child: _buildContent('Tiên tri: ', card.prophecy ?? 'Prophecy'),
        ),
        SliverToBoxAdapter(
          child: _buildContent('Lời khuyên: ', card.advice ?? 'Advice'),
        ),
      ],
    );
  }

  _cardInfo(CardResponseModel card) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          child: Container(
            width: 200.0,
            height: 350.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              image: DecorationImage(
                  image: NetworkImage(card.images?[0].imageUrl ??
                      "https://i.imgur.com/2njY6VH.jpg"),
                  fit: BoxFit.cover),
            ),
          ),
        ),
        SizedBox(height: 16.0),
      ],
    );
  }

  _buildKeyword(CardResponseModel card) {
    keywordList = card.keyword?.keyword ?? [];
    return Container(
      child: Column(
        children: [
          for (final item in keywordList)
            KeywordWidget(keyword: item.title ?? 'Keyword')
        ],
      ),
    );
  }

  _buildContent(String title, String? content) {
    if (content == null || content == "") return Container();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          SizedBox(height: 16.0),
          RichText(
            textAlign: TextAlign.left,
            text: TextSpan(
              style: DefaultTextStyle.of(context).style,
              children: [
                TextSpan(
                    text: title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: FontFamily.nutinoSans,
                    )),
                TextSpan(text: content),
              ],
            ),
          ),
          SizedBox(height: 16.0),
        ],
      ),
    );
  }
}
