import 'package:dalotee/common/mixins/after_layout.dart';
import 'package:dalotee/configs/service_locator.dart';
import 'package:dalotee/data/model/response/card_model.dart';
import 'package:dalotee/data/model/response/get_card_category_response.dart';
import 'package:dalotee/generated/assets/assets.gen.dart';
import 'package:dalotee/generated/assets/fonts.gen.dart';
import 'package:dalotee/presentation/dialogs/keyword_dialog.dart';
import 'package:dalotee/presentation/pages/daily_tab/data.dart';
import 'package:dalotee/presentation/pages/spread_tab/spread_card/spread_card_bloc.dart';
import 'package:dalotee/presentation/pages/spread_tab/spread_card/spread_card_state.dart';
import 'package:dalotee/presentation/widgets/base/custom_appbar.dart';
import 'package:dalotee/presentation/widgets/base/custom_text.dart';
import 'package:dalotee/values/app_utils.dart';
import 'package:dalotee/values/colors.dart';
import 'package:dalotee/values/dimens.dart';
import 'package:dalotee/values/font_sizes.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SpreadCardPage extends StatefulWidget {
  SpreadCardPage({Key? key}) : super(key: key);

  @override
  _SpreadCardPageState createState() => _SpreadCardPageState();
}

class _SpreadCardPageState extends State<SpreadCardPage> with AfterLayoutMixin {
  SpreadCardBloc _bloc = SpreadCardBloc(appRepository: locator.get());

  ValueNotifier<double> sizeAnimatedContainer = ValueNotifier<double>(0);
  ValueNotifier<List<Widget>?> description =
      ValueNotifier<List<Widget>?>([Container()]);

  // the number of cards that have been opened
  int cardOpened = 0;

  List<CardResponseModel> listCard = [];

  @override
  void afterFirstFrame(BuildContext context) {
    var card1 = AppUtils.getRandomCardNumber();

    // Get random card 2 not equal card 1
    var card2 = AppUtils.getRandomCardNumber();
    while (card2 == card1) {
      card2 = AppUtils.getRandomCardNumber();
    }

    // Get random card 3 not equal card 1 and card 2
    var card3 = AppUtils.getRandomCardNumber();

    while (card3 == card1 || card3 == card2) {
      card3 = AppUtils.getRandomCardNumber();
    }

    _bloc.getCardByNumber(card1, card2, card3);
  }

  @override
  Widget build(BuildContext context) {
    String question = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      backgroundColor: AppColor.colorPrimary,
      appBar: _buildAppbar(),
      body: BlocProvider(
        create: (context) => _bloc,
        child: _buildBody(question),
      ),
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

  _blocListener(BuildContext context, SpreadCardState state) async {
    if (state is SpreadCardLoadingState) {
      EasyLoading.show(status: 'loading', maskType: EasyLoadingMaskType.black);
    } else {
      EasyLoading.dismiss();
    }
  }

  Widget _buildBody(String? question) {
    return BlocListener<SpreadCardBloc, SpreadCardState>(
      listener: _blocListener,
      child: BlocBuilder(
        bloc: _bloc,
        builder: (context, state) {
          if (state is SpreadCardLoadingStateSuccess) {
            listCard = state.data;
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: AppDimen.spacing_4),
                    padding:
                        EdgeInsets.symmetric(horizontal: AppDimen.spacing_2),
                    child: Center(
                      child: CustomText(
                        question ?? '',
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
                            front: Container(
                              width: 100,
                              height: 150,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: Assets.images.imgBackCard,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0)),
                                color: Colors.redAccent,
                              ),
                            ),
                            back: Container(
                              child: Container(
                                width: 100,
                                height: 150,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  image: DecorationImage(
                                      image: NetworkImage(item
                                              .images?[0].imageUrl ??
                                          "https://i.imgur.com/2njY6VH.jpg"),
                                      fit: BoxFit.fill),
                                ),
                              ),
                            ),
                            onFlipDone: (bool k) {
                              if (cardOpened < 3) {
                                sizeAnimatedContainer.value += 170;
                                Future.delayed(Duration(milliseconds: 500), () {
                                  description.value?.add(
                                    _buildDescriptionCard(
                                        cardOpened + 1,
                                        item.keyword?.keyword ?? [],
                                        item.name ?? ""),
                                  );
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
                      builder:
                          (BuildContext context, double size, Widget? child) {
                        if (size != 0) {
                          return AnimatedContainer(
                              margin: EdgeInsets.symmetric(
                                  vertical: AppDimen.spacing_large,
                                  horizontal: AppDimen.spacing_3),
                              decoration: BoxDecoration(
                                  color: AppColor.colorButton,
                                  borderRadius: BorderRadius.circular(
                                      AppDimen.spacing_2)),
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
                                          for (int i = 0;
                                              i < listWidget.length;
                                              i++)
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

          return Container();
        },
      ),
    );
  }

  String _getKeywordList(List<KeyWordData> keyword) {
    String result = '';
    for (int i = 0; i < keyword.length; ++i) {
      result += keyword[i].title ?? '';

      if (i != keyword.length - 1) {
        result += '. ';
      }
    }

    return result;
  }

  Widget _buildDescriptionCard(
      int index, List<KeyWordData> keywords, String cardName) {
    return InkWell(
      onTap: () {
        print("Hello $index");
        KeyWordDialog(
          context: context,
          title: "Lá $cardName",
          content: keywords,
        ).show();
      },
      child: Container(
        margin: EdgeInsets.symmetric(
            vertical: AppDimen.spacing_3, horizontal: AppDimen.spacing_2),
        child: Column(
          children: [
            CustomText(
              'Lá $cardName',
              fontWeight: FontWeight.bold,
              fontSize: FontSize.BIG_1,
            ),
            SizedBox(height: 8.0),
            CustomText(
              _getKeywordList(keywords),
              align: TextAlign.justify,
            ),
            SizedBox(height: 8.0),
            Container(
              margin: EdgeInsets.only(top: AppDimen.spacing_2),
              child: SvgPicture.asset(
                Assets.images.icLine.path,
              ),
            )
          ],
        ),
      ),
    );
  }
}
