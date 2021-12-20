import 'package:dalotee/presentation/dialogs/base/base_dialog.dart';
import 'package:dalotee/presentation/widgets/base/custom_button.dart';
import 'package:dalotee/presentation/widgets/base/custom_text.dart';
import 'package:dalotee/values/colors.dart';
import 'package:dalotee/values/dimens.dart';
import 'package:dalotee/values/font_sizes.dart';
import 'package:flutter/material.dart';

class OkDialog extends BaseDialog {
  final String title;
  final String content;
  final Function? callbackPositive;

  OkDialog(
      {required context,
      this.title = "",
      this.content = "",
      this.callbackPositive})
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Title
            title.isEmpty
                ? Container()
                : CustomText(title,
                    align: TextAlign.center,
                    fontSize: FontSize.BIG,
                    fontWeight: FontWeight.w600,
                    maxLine: 3),

            SizedBox(height: title.isEmpty ? 0 : 16),
            Divider(height: 1.0, color: Colors.black),
            SizedBox(height: title.isEmpty ? 0 : 16),

            // Content
            content.isEmpty
                ? Container()
                : CustomText(
                    content,
                    align: TextAlign.center,
                    maxLine: 5,
                  ),
            SizedBox(height: content.isEmpty ? 8 : 28),

            // Button
            CustomButton(
              "Kết thúc",
              textColor: Colors.white,
              backgroundColor: Colors.black,
              borderRadius: 20,
              padding: EdgeInsets.symmetric(
                vertical: AppDimen.spacing_2,
                horizontal: AppDimen.spacing_large,
              ),
              onTap: () {
                dismiss();
              },
            ),
          ],
        ),
      ),
    );
  }
}
