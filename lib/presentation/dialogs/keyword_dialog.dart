import 'package:dalotee/data/model/response/get_card_category_response.dart';
import 'package:dalotee/presentation/dialogs/base/base_dialog.dart';
import 'package:dalotee/presentation/widgets/base/custom_button.dart';
import 'package:dalotee/presentation/widgets/base/custom_text.dart';
import 'package:dalotee/values/colors.dart';
import 'package:dalotee/values/dimens.dart';
import 'package:dalotee/values/font_sizes.dart';
import 'package:flutter/material.dart';

class KeyWordDialog extends BaseDialog {
  final String title;
  final List<KeyWordData>? content;
  final Function? callbackPositive;

  KeyWordDialog(
      {required context, this.title = "", this.content, this.callbackPositive})
      : super(context: context) {
    _build();
  }

  void _build() {
    dialog = AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimen.radiusNormal)),
      contentPadding: EdgeInsets.zero,
      content: Container(
        decoration: BoxDecoration(
            color: AppColor.colorButton,
            borderRadius: BorderRadius.circular(AppDimen.radiusNormal)),
        padding: AppDimen.dialogPadding,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Title
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: 16.0),
                  CustomText(title,
                      align: TextAlign.center,
                      fontSize: FontSize.BIG_1,
                      fontWeight: FontWeight.w600,
                      maxLine: 3),
                  IconButton(
                    onPressed: () {
                      dismiss();
                    },
                    icon: Icon(Icons.close, size: 16.0),
                  )
                ],
              ),

              SizedBox(height: title.isEmpty ? 0 : 16),
              Divider(height: 1.0, color: Colors.black),
              SizedBox(height: title.isEmpty ? 0 : 16),

              ..._buildListKeyword(content),
              SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildListKeyword(List<KeyWordData>? keywords) {
    return [
      for (var i = 0; i < keywords!.length; i++)
        Column(children: [
          CustomText(
            keywords[i].title ?? '',
            fontWeight: FontWeight.w700,
          ),
          SizedBox(height: 4.0),
          CustomText(
            keywords[i].content ?? '',
            fontSize: FontSize.SMALL,
          ),
          SizedBox(height: 16.0),
        ]),
    ];
  }
}
