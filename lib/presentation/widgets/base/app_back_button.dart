import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppBackButton extends StatelessWidget {
  final Color? imgColor;
  AppBackButton({this.imgColor = Colors.black});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      splashRadius: 24.0,
      icon: Icon(Icons.keyboard_backspace),
      color: imgColor,
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }
}
