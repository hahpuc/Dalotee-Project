import 'package:flutter/material.dart';

class FooterScrollView extends StatelessWidget {
  final Widget? body;
  final Widget? footer;

  FooterScrollView({Key? key, @required this.body, @required this.footer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, constraints) {
      return SingleChildScrollView(
          child: ConstrainedBox(
              constraints: constraints.copyWith(
                  minHeight: constraints.maxHeight, maxHeight: double.infinity),
              child: IntrinsicHeight(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  body!,
                  Expanded(
                      child: Align(
                    alignment: Alignment.bottomCenter,
                    child: footer,
                  ))
                ],
              ))));
    });
  }
}
