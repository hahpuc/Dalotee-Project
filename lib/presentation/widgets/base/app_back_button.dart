import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:dalotee/generated/assets/assets.gen.dart';

class AppBackButton extends StatelessWidget {
  AppBackButton();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      splashRadius: 24.0,
      icon: SvgPicture.asset(Assets.images.icBack.path),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }
}
