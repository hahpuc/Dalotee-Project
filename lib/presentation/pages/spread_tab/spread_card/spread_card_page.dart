import 'package:dalotee/data/model/response/card_model.dart';
import 'package:dalotee/generated/assets/assets.gen.dart';
import 'package:dalotee/generated/assets/fonts.gen.dart';
import 'package:dalotee/presentation/pages/daily_tab/data.dart';
import 'package:dalotee/presentation/widgets/base/custom_appbar.dart';
import 'package:dalotee/presentation/widgets/base/custom_text.dart';
import 'package:dalotee/values/colors.dart';
import 'package:dalotee/values/dimens.dart';
import 'package:dalotee/values/font_sizes.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SpreadCardPage extends StatefulWidget {
  String? question;
  SpreadCardPage({Key? key, this.question}) : super(key: key);

  @override
  _SpreadCardPageState createState() => _SpreadCardPageState();
}

class _SpreadCardPageState extends State<SpreadCardPage> {
  ValueNotifier<double> sizeAnimatedContainer = ValueNotifier<double>(0);
  ValueNotifier<List<Widget>?> description =
      ValueNotifier<List<Widget>?>([Container()]);

  // the number of cards that have been opened
  int cardOpened = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.colorPrimary,
      appBar: _buildAppbar(),
      body: _buildBody(),
    );
  }

  _buildAppbar() {
    return CustomAppBar(
      title: CustomText('Vấn đề của bạn',
          fontFamily: FontFamily.gelasio, fontSize: AppDimen.sizeAppBarText),
      leading: IconButton(
        icon: Assets.images.icBack.svg(),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  _buildBody() {
    List<CardData> listCard = [card, card, card];
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Container(
            margin: EdgeInsets.symmetric(vertical: AppDimen.spacing_4),
            padding: EdgeInsets.symmetric(horizontal: AppDimen.spacing_2),
            child: Center(
              child: CustomText(
                widget.question ?? '',
                fontFamily: FontFamily.gelasio,
                fontWeight: FontWeight.bold,
                fontSize: FontSize.BIG,
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            margin: EdgeInsets.only(left: AppDimen.spacing_3),
            height: 200,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: listCard.map((item) {
                return Container(
                  margin: EdgeInsets.only(left: AppDimen.spacing_2),
                  child: FlipCard(
                    front: Image.asset(
                      item.back,
                      scale: 10,
                    ),
                    back: Image.asset(
                      item.front,
                      scale: 2,
                    ),
                    onFlipDone: (bool k) {
                      if (cardOpened < 3) {
                        sizeAnimatedContainer.value += 125;
                        Future.delayed(Duration(milliseconds: 500), () {
                          description.value?.add(_buildDescriptionCard(
                              cardOpened + 1,
                              'Sự khởi đầu mới. Niềm tin. Tự phát. Sự điên rồ'));
                          setState(() {
                            cardOpened++;
                          });
                        });
                      }
                    },
                  ),
                );
              }).toList(),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: ValueListenableBuilder<double>(
              valueListenable: sizeAnimatedContainer,
              builder: (BuildContext context, double size, Widget? child) {
                if (size != 0) {
                  return AnimatedContainer(
                      margin: EdgeInsets.symmetric(
                          vertical: AppDimen.spacing_large,
                          horizontal: AppDimen.spacing_3),
                      decoration: BoxDecoration(
                          color: AppColor.colorButton,
                          borderRadius:
                              BorderRadius.circular(AppDimen.spacing_2)),
                      curve: Curves.linear,
                      duration: Duration(milliseconds: 500),
                      height: size,
                      width: size,
                      child: ValueListenableBuilder<List<Widget>?>(
                          valueListenable: description,
                          builder: (BuildContext context,
                              List<Widget>? listWidget, Widget? child) {
                            if (listWidget!.isNotEmpty) {
                              return Column(
                                children: [
                                  for (int i = 0; i < listWidget.length; i++)
                                    listWidget[i]
                                ],
                              );
                            } else {
                              return Container();
                            }
                          }));
                }
                {
                  return Container();
                }
              }),
        )
      ],
    );
  }

  _buildDescriptionCard(int? index, String? description) {
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: AppDimen.spacing_3, horizontal: AppDimen.spacing_2),
      child: Column(
        children: [
          CustomText(
            'Lá $index',
            fontWeight: FontWeight.bold,
          ),
          CustomText(
            description ?? '',
            align: TextAlign.justify,
          ),
          Container(
            margin: EdgeInsets.only(top: AppDimen.spacing_2),
            child: SvgPicture.asset(
              Assets.images.icLine.path,
            ),
          )
        ],
      ),
    );
  }
}
