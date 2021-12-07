import 'package:dalotee/configs/routes.dart';
import 'package:dalotee/generated/assets/assets.gen.dart';
import 'package:dalotee/generated/assets/fonts.gen.dart';
import 'package:dalotee/presentation/widgets/base/custom_appbar.dart';
import 'package:dalotee/presentation/widgets/base/custom_text.dart';
import 'package:dalotee/values/colors.dart';
import 'package:dalotee/values/dimens.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class QuestionSpreadPage extends StatelessWidget {
  QuestionSpreadPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String question = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      backgroundColor: AppColor.colorPrimary,
      appBar: _buildAppbar(context, question),
      body: _buildBody(),
    );
  }

  _buildAppbar(BuildContext context, String? question) {
    return CustomAppBar(
      title: CustomText(question ?? '',
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
    List<String>? questionList = getQuestionList();

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(child: SizedBox(height: AppDimen.spacing_large)),
        SliverToBoxAdapter(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: AppDimen.spacing_2),
            child: CustomText(
              'Danh sách các câu hỏi ',
              fontSize: AppDimen.sizeAppBarText,
              fontFamily: FontFamily.gelasio,
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            return InkWell(
              onTap: () {
                onTapQuestion(context, questionList[index]);
              },
              child: Container(
                margin: EdgeInsets.symmetric(
                    vertical: AppDimen.spacing_3,
                    horizontal: AppDimen.spacing_2),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Row(
                          children: [
                            CustomText(
                              '${index + 1}.\t',
                              fontSize: AppDimen.sizeTextSmall,
                              fontFamily: FontFamily.nutinoSans,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: CustomText(
                                questionList[index],
                                overflow: TextOverflow.ellipsis,
                                fontSize: AppDimen.sizeTextSmall,
                                fontFamily: FontFamily.nutinoSans,
                              ),
                            ),
                          ],
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: AppDimen.spacing_2,
                          color: AppColor.colorTextButton,
                        )
                      ],
                    ),
                    Divider(
                      thickness: 0.50,
                      color: AppColor.colorDivider,
                    ),
                  ],
                ),
              ),
            );
          }, childCount: questionList.length),
        )
      ],
    );
  }

  List<String> getQuestionList() {
    return [
      'Tổng quan mối quan hệ',
      'Người ấy nghĩ gì về tôi?',
      'Tình cảm người ấy dành cho tôi?',
      'Tôi mong muốn điều gì ở người ấy?',
      'Tôi mong muốn điều gì ở người ấy và mối quan hệ này',
      'Tôi nên làm gì để cải thiện mối quan hệ'
    ];
  }

  onTapQuestion(BuildContext context, String question) {
    Navigator.pushNamed(context, RoutePaths.SPREAD_CARD, arguments: question);
  }
}
