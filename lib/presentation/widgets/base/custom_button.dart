import 'package:flutter/material.dart';
import 'package:dalotee/values/colors.dart';
import 'package:dalotee/values/font_sizes.dart';

import 'custom_text.dart';

class CustomButton extends StatelessWidget {
  CustomButton(this.text,
      {this.textColor = AppColor.colorPrimary,
      this.textAlignment = TextAlign.center,
      this.fontSize = FontSize.MEDIUM,
      this.padding = const EdgeInsets.all(8),
      this.tintColor = Colors.white,
      this.backgroundColor = AppColor.colorGreyLight,
      this.borderRadius = 4,
      this.borderWidth = 0,
      this.onTap});
  final String text;
  final Color textColor;
  final TextAlign textAlignment;
  final double fontSize;
  final EdgeInsets padding;
  final Color tintColor;
  final Color backgroundColor;
  final double borderRadius;
  final double borderWidth;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Material(
          color: Colors.transparent,
          child: Ink(
            decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(borderRadius),
                border: Border.all(
                    color: Colors.grey.withOpacity(0.3), width: borderWidth)),
            child: InkWell(
              borderRadius: BorderRadius.circular((borderRadius - 2) < 0
                  ? 0
                  : borderRadius - 2), // Prevent ripple overflow
              child: Container(
                padding: padding,
                alignment: Alignment.center,
                child: _buildChild(),
              ),
              onTap: onTap,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildChild() {
    Widget widget;
    widget = ConstrainedBox(
      constraints: BoxConstraints(minWidth: 60),
      child: CustomText(
        text,
        maxLine: 1,
        color: textColor,
        fontSize: fontSize,
        align: textAlignment,
      ),
    );
    return widget;
  }
}
