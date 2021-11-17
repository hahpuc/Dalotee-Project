import 'dart:math';

import 'package:flutter/material.dart';

class FlipCardController {
  FlipCardController? _state;
  Future flipCard() async => _state?.flipCard();
}

class FlipCardWidget extends StatefulWidget {
  final FlipCardController controller;
  final Image front;
  final Image back;

  const FlipCardWidget(
      {Key? key,
      required this.controller,
      required this.front,
      required this.back})
      : super(key: key);

  @override
  _FlipCardWidgetState createState() => _FlipCardWidgetState();
}

class _FlipCardWidgetState extends State<FlipCardWidget> {
  Future flipCard() async {}
  final angle = 0.0 * -pi;
  final transform = Matrix4.identity()..rotateX(0.0 * -pi);
  @override
  Widget build(BuildContext context) {
    return Transform(transform: transform, child: widget.front);
  }
}
