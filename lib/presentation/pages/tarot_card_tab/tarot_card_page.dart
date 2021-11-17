import 'package:flutter/material.dart';

class TarotCardPage extends StatefulWidget {
  const TarotCardPage({Key? key}) : super(key: key);

  @override
  _TarotCardPageState createState() => _TarotCardPageState();
}

class _TarotCardPageState extends State<TarotCardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Tarot Card Page'),
      ),
    );
  }
}
