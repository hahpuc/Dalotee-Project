import 'package:dalotee/common/mixins/after_layout.dart';
import 'package:dalotee/configs/routes.dart';
import 'package:dalotee/configs/service_locator.dart';
import 'package:dalotee/data/model/response/card_model.dart';
import 'package:dalotee/data/model/response/get_card_category_response.dart';
import 'package:dalotee/generated/assets/assets.gen.dart';
import 'package:dalotee/generated/assets/fonts.gen.dart';
import 'package:dalotee/presentation/pages/daily_tab/daily_selected/daily_selected_bloc.dart';
import 'package:dalotee/presentation/pages/daily_tab/daily_selected/daily_selected_state.dart';
import 'package:dalotee/presentation/widgets/base/app_back_button.dart';
import 'package:dalotee/presentation/widgets/base/custom_appbar.dart';
import 'package:dalotee/presentation/widgets/base/custom_button.dart';
import 'package:dalotee/presentation/widgets/base/custom_text.dart';
import 'package:dalotee/values/app_utils.dart';
import 'package:dalotee/values/colors.dart';
import 'package:dalotee/values/dimens.dart';
import 'package:dalotee/values/font_sizes.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class DailySelectedPage extends StatefulWidget {
  DailySelectedPage({Key? key}) : super(key: key);

  @override
  State<DailySelectedPage> createState() => _DailySelectedPageState();
}

class _DailySelectedPageState extends State<DailySelectedPage>
    with AfterLayoutMixin {
  DailySelectedBloc _bloc = DailySelectedBloc(appRepository: locator.get());

  CardResponseModel? cardDetail;

  @override
  void afterFirstFrame(BuildContext context) {
    var numberRandom = AppUtils.getRandomCardNumber();

    _bloc.getCardByNumber(numberRandom);
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
      leading: AppBackButton(),
      title: CustomText(
        "Thông điệp mỗi ngày",
        fontFamily: FontFamily.gelasio,
        fontSize: FontSize.BIG,
      ),
    );
  }

  _blocListener(BuildContext context, DailySelectedState state) async {
    print("State $state");
    if (state is DailySelectedLoadingState) {
      EasyLoading.show(status: 'loading', maskType: EasyLoadingMaskType.black);
    } else {
      EasyLoading.dismiss();
    }

    if (state is DailySelectedLoadingStateSuccess) {}

    if (state is DailySelectedLoadingStateFailed) {
      EasyLoading.showError(state.msg);
    }
  }

  Widget _buildBody() {
    // var card = ModalRoute.of(context)!.settings.arguments as dynamic;

    double width = MediaQuery.of(context).size.width * 2 / 3;
    double height = MediaQuery.of(context).size.height * 2 / 3;

    return BlocProvider(
      create: (context) => _bloc,
      child: BlocListener<DailySelectedBloc, DailySelectedState>(
        listener: _blocListener,
        child: BlocBuilder<DailySelectedBloc, DailySelectedState>(
          bloc: _bloc,
          builder: (context, state) {
            if (state is DailySelectedLoadingStateSuccess) {
              var image = state.data.images?[0].imageUrl;
              cardDetail = state.data;

              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FlipCard(
                      front: Container(
                        width: width * 2 / 3,
                        height: height * 2 / 3,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: Assets.images.imgBackCard,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          color: Colors.redAccent,
                        ),
                      ),
                      back: Container(
                        child: Container(
                          width: 200.0,
                          height: 350.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            image: DecorationImage(
                                image: NetworkImage(
                                    image ?? "https://i.imgur.com/2njY6VH.jpg"),
                                fit: BoxFit.cover),
                          ),
                        ),
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
                      onTap: () => Navigator.pushNamed(
                          context, RoutePaths.CARD_DETAIL,
                          arguments: []),
                    )
                  ],
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
