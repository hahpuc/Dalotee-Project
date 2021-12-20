import 'package:dalotee/common/mixins/after_layout.dart';
import 'package:dalotee/configs/routes.dart';
import 'package:dalotee/configs/service_locator.dart';
import 'package:dalotee/data/model/response/spread/get_content_question_response.dart';
import 'package:dalotee/data/model/response/spread/get_questions_response.dart';
import 'package:dalotee/generated/assets/assets.gen.dart';
import 'package:dalotee/generated/assets/fonts.gen.dart';
import 'package:dalotee/presentation/pages/spread_tab/question_spread/question_bloc.dart';
import 'package:dalotee/presentation/pages/spread_tab/question_spread/question_state.dart';
import 'package:dalotee/presentation/widgets/base/custom_appbar.dart';
import 'package:dalotee/presentation/widgets/base/custom_text.dart';
import 'package:dalotee/values/colors.dart';
import 'package:dalotee/values/dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class QuestionSpreadPage extends StatefulWidget {
  QuestionSpreadPage({Key? key}) : super(key: key);

  @override
  State<QuestionSpreadPage> createState() => _QuestionSpreadPageState();
}

class _QuestionSpreadPageState extends State<QuestionSpreadPage>
    with AfterLayoutMixin {
  ListQuestionBloc _bloc = ListQuestionBloc(appRepository: locator.get());

  @override
  void afterFirstFrame(BuildContext context) {
    var contentQuestion =
        ModalRoute.of(context)!.settings.arguments as ContentQuestionResponse;

    _bloc.getContentQuestion(contentQuestion.id!);
  }

  @override
  Widget build(BuildContext context) {
    var contentQuestion =
        ModalRoute.of(context)!.settings.arguments as ContentQuestionResponse;
    return Scaffold(
      backgroundColor: AppColor.colorPrimary,
      appBar: _buildAppbar(context, contentQuestion),
      body: BlocProvider(
        create: (context) => _bloc,
        child: _buildBody(),
      ),
    );
  }

  _buildAppbar(BuildContext context, ContentQuestionResponse? question) {
    return CustomAppBar(
      title: CustomText(question?.contentQuestion ?? '',
          fontFamily: FontFamily.gelasio, fontSize: AppDimen.sizeAppBarText),
      leading: IconButton(
        icon: Assets.images.icBack.svg(),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  _blocListener(BuildContext context, ListQuestionState state) async {
    if (state is ListQuestionLoadingState) {
      EasyLoading.show(status: 'loading', maskType: EasyLoadingMaskType.black);
    } else {
      EasyLoading.dismiss();
    }
  }

  Widget _buildBody() {
    List<QuestionResponse> questionList = [];

    return BlocListener<ListQuestionBloc, ListQuestionState>(
      listener: _blocListener,
      child: BlocBuilder<ListQuestionBloc, ListQuestionState>(
        bloc: _bloc,
        builder: (context, state) {
          if (state is ListQuestionSuccessState) {
            questionList = state.data;

            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                    child: SizedBox(height: AppDimen.spacing_large)),
                SliverToBoxAdapter(
                  child: Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: AppDimen.spacing_2),
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
                        onTapQuestion(context,
                            questionList[index].question ?? 'Questions');
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
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                      child: CustomText(
                                        questionList[index].question ??
                                            'question',
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

          return Container();
        },
      ),
    );
  }

  onTapQuestion(BuildContext context, String question) {
    Navigator.pushNamed(context, RoutePaths.SPREAD_CARD, arguments: question);
  }
}
