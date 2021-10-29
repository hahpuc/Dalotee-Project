import 'package:flutter/material.dart';
import 'package:dalotee/configs/routes.dart';
import 'package:dalotee/presentation/widgets/base/custom_button.dart';
import 'package:dalotee/presentation/widgets/base/custom_text.dart';
import 'package:dalotee/values/font_sizes.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: CustomText(
            "Home",
            color: Colors.white,
            fontSize: FontSize.BIG,
            fontWeight: FontWeight.bold,
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: CustomButton(
                "To DEMO page",
                onTap: () {
                  Navigator.pushNamed(context, RoutePaths.DEMO,
                      arguments: "Demo");
                },
              ),
            ),
          ],
        ));
  }
}
