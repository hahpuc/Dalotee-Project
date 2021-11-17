import 'package:flutter/material.dart';

class SpreadPage extends StatefulWidget {
  const SpreadPage({Key? key}) : super(key: key);

  @override
  _SpreadPageState createState() => _SpreadPageState();
}

class _SpreadPageState extends State<SpreadPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Spread Page'),
      ),
    );
  }
}
