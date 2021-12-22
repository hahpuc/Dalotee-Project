import 'package:dalotee/common/mixins/after_layout.dart';
import 'package:dalotee/configs/routes.dart';
import 'package:dalotee/data/model/response/history_response.dart';
import 'package:dalotee/generated/assets/fonts.gen.dart';
import 'package:dalotee/presentation/widgets/base/custom_appbar.dart';
import 'package:dalotee/presentation/widgets/base/custom_text.dart';
import 'package:dalotee/values/colors.dart';
import 'package:dalotee/values/font_sizes.dart';
import 'package:flutter/material.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> with AfterLayoutMixin {
  @override
  void afterFirstFrame(BuildContext context) {
    var historyList =
        ModalRoute.of(context)?.settings.arguments as List<HistoryResponse>;

    for (var history in historyList) {
      print(history.toJson());
    }
  }

  @override
  Widget build(BuildContext context) {
    var historyList =
        ModalRoute.of(context)?.settings.arguments as List<HistoryResponse>;
    return Scaffold(
      backgroundColor: AppColor.colorPrimary,
      appBar: _buildAppBar(),
      body: _buildBody(historyList),
    );
  }

  CustomAppBar _buildAppBar() {
    return CustomAppBar(
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: CustomText(
        "Lịch sử trải bài",
        fontFamily: FontFamily.gelasio,
        fontSize: FontSize.BIG_1,
      ),
    );
  }

  Widget _buildBody(List<HistoryResponse> historyList) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            for (int i = historyList.length - 1; i >= 0; i--)
              _buildHistoryItem(historyList[i], i),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryItem(HistoryResponse history, int index) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, RoutePaths.CARD_DETAIL,
            arguments: [history.data, 'search']);
      },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AppColor.colorButton,
            ),
            child: Column(
              children: [
                CustomText(
                  history.time ?? '',
                  fontFamily: FontFamily.gelasio,
                  color: Colors.black,
                ),
                SizedBox(height: 16.0),
                CustomText(
                  history.data?.name ?? '',
                  fontSize: FontSize.BIG_1,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                SizedBox(height: 16.0),
              ],
            ),
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}
