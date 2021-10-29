import 'package:flutter/material.dart';
import 'package:dalotee/generated/assets/fonts.gen.dart';
import 'package:dalotee/values/font_sizes.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField(
      {required this.textController,
      this.fontFamily = FontFamily.poppins,
      this.fontStyle = FontStyle.normal,
      this.textColor = Colors.black,
      this.contentPadding,
      this.hintTextColor = Colors.black,
      this.hintText,
      this.fontSize = FontSize.MEDIUM,
      this.maxLines = 1,
      this.maxLength,
      this.fontWeight = FontWeight.normal,
      this.textInputAction = TextInputAction.search,
      this.onSubmittedListener,
      this.onChangedListener});

  final Color textColor;
  final Color hintTextColor;
  final EdgeInsetsGeometry? contentPadding;
  final String fontFamily;
  final double fontSize;
  final FontStyle fontStyle;
  final String? hintText;
  final int? maxLines;
  final int? maxLength;
  final FontWeight fontWeight;
  final TextInputAction textInputAction;
  final Function? onSubmittedListener;
  final Function? onChangedListener;
  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      textInputAction: textInputAction,
      controller: textController,
      onSubmitted: (text) {
        if (onSubmittedListener != null) {
          onSubmittedListener!(text);
        }
      },
      onChanged: (text) {
        if (onChangedListener != null) {
          onChangedListener!(text);
        }
      },
      style: TextStyle(
          fontFamily: fontFamily,
          color: textColor,
          fontSize: fontSize,
          fontStyle: fontStyle,
          fontWeight: fontWeight),
      decoration: InputDecoration(
          isDense: true,
          border: InputBorder.none,
          contentPadding: contentPadding,
          hintStyle: TextStyle(
              fontFamily: fontFamily,
              color: hintTextColor,
              fontStyle: fontStyle),
          hintText: hintText),
      maxLines: maxLines,
      maxLength: maxLength,
      textAlign: TextAlign.start,
    );
  }
}
