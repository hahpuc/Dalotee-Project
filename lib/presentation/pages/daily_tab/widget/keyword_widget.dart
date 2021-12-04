import 'package:dalotee/presentation/widgets/base/custom_text.dart';
import 'package:dalotee/values/colors.dart';
import 'package:dalotee/values/dimens.dart';
import 'package:flutter/material.dart';

class KeywordWidget extends StatelessWidget {
  const KeywordWidget({Key? key, required this.keyword}) : super(key: key);
  final String keyword;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: AppDimen.spacing_1,
        horizontal: AppDimen.spacing_1,
      ),
      decoration: BoxDecoration(
        color: AppColor.colorButton,
        borderRadius: BorderRadius.circular(5),
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 20,
      ),
      child: CustomText(keyword),
    );
  }
}
