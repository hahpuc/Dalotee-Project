import 'package:flutter/material.dart';
import 'package:dalotee/generated/localization/l10n.dart';
import 'package:dalotee/presentation/dialogs/base/base_dialog.dart';
class OkDialog extends BaseDialog {
  final String? content;
  final String? title;
  final String? buttonText;
  final Function? onButtonTap;

  OkDialog(
      {context, this.title, this.content, this.buttonText, this.onButtonTap})
      : super(context: context) {
    _build();
  }

  void _build() {
    dialog = AlertDialog(
        title: Text(title ?? ""),
        content: Text(content ?? ""),
        actions: [
          TextButton(
              onPressed: () {
                dismiss();
                onButtonTap?.call();
              },
              child: Text(buttonText ?? S.of(context).ok))
        ]);
    show();
  }
}
