import 'dart:async';

import 'package:flutter/material.dart';

class CountdownTimerController extends ChangeNotifier {
  String? _action;

  void reset() {
    this._action = 'reset';
    notifyListeners();
  }

  void stop() {
    this._action = 'stop';
    notifyListeners();
  }
}

class CountdownTimer extends StatefulWidget {
  const CountdownTimer(
      {Key? key,
      required this.duration,
      required this.builder,
      this.onFinish,
      this.interval = const Duration(seconds: 1),
      this.controller})
      : super(key: key);

  final Duration duration;
  final Duration interval;
  final CountdownTimerController? controller;
  final void Function()? onFinish;
  final Widget Function(BuildContext context, Duration remaining) builder;
  @override
  _CountdownTimerState createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  Timer? _timer;
  Duration? _duration;
  @override
  void initState() {
    startTimer();

    super.initState();
    widget.controller?.addListener(() {
      if (widget.controller?._action == 'reset') {
        _timer?.cancel();
        startTimer();
      } else if (widget.controller?._action == 'stop') {
        _timer?.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    _duration = widget.duration;
    _timer = Timer.periodic(widget.interval, timerCallback);
    timerCallback(_timer!);
  }

  void timerCallback(Timer timer) {
    setState(() {
      if (_duration!.inSeconds == 0) {
        timer.cancel();
        if (widget.onFinish != null) widget.onFinish!();
      } else {
        _duration = Duration(seconds: _duration!.inSeconds - 1);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _duration!);
  }
}

class CountdownFormatted extends StatelessWidget {
  const CountdownFormatted({
    Key? key,
    required this.duration,
    required this.builder,
    this.onFinish,
    this.interval = const Duration(seconds: 1),
    this.formatter,
  }) : super(key: key);

  final Duration duration;
  final Duration interval;
  final void Function()? onFinish;

  /// An function to format the remaining time
  final String Function(Duration)? formatter;

  final Widget Function(BuildContext context, String remaining) builder;

  Function(Duration) _formatter() {
    if (formatter != null) return formatter!;
    if (duration.inHours >= 1) return formatByHours;
    if (duration.inMinutes >= 1) return formatByMinutes;

    return formatBySeconds;
  }

  @override
  Widget build(BuildContext context) {
    return CountdownTimer(
      interval: interval,
      onFinish: onFinish,
      duration: duration,
      builder: (BuildContext ctx, Duration remaining) {
        return builder(ctx, _formatter()(remaining));
      },
    );
  }

  String twoDigits(int n) {
    if (n >= 10) return '$n';
    return '0$n';
  }

  String formatBySeconds(Duration duration) =>
      twoDigits(duration.inSeconds.remainder(60));

  String formatByMinutes(Duration duration) {
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    return '$twoDigitMinutes:${formatBySeconds(duration)}';
  }

  String formatByHours(Duration duration) {
    return '${twoDigits(duration.inHours)}:${formatByMinutes(duration)}';
  }
}
