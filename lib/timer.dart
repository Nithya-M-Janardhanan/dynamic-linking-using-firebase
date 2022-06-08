import 'dart:async';
import 'package:flutter/material.dart';

enum TimerState { showInDef, showInHMS, showInMS, showInSeconds }

class CountDownTimerWidget extends StatefulWidget {
  final TimerState? timerState;
  const CountDownTimerWidget({Key? key, this.timerState = TimerState.showInDef})
      : super(key: key);

  @override
  State<CountDownTimerWidget> createState() => _CountDownTimerWidgetState();
}

class _CountDownTimerWidgetState extends State<CountDownTimerWidget> {
  Timer? countdownTimer;

  final ValueNotifier<Duration> _myDuration =
  ValueNotifier<Duration>(const Duration(hours: 1));

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    countdownTimer =
        Timer.periodic(const Duration(seconds: 1), (timer) => setCountDown());
  }

  void setCountDown() {
    const reduceSecondBy = 1;

    final seconds = _myDuration.value.inSeconds - reduceSecondBy;
    if (seconds < 0) {
      countdownTimer?.cancel();
    } else {
      _myDuration.value = Duration(seconds: seconds);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Duration>(
        valueListenable: _myDuration,
        builder: (context, value, child) {
          return Text(
            _timerText(duration: value),
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white),
          );
        });
  }

  String _timerText({required Duration duration}) {
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final days = strDigits(duration.inDays);
    final hours = strDigits(duration.inHours.remainder(24));
    final minutes = strDigits(duration.inMinutes.remainder(60));
    final seconds = strDigits(duration.inSeconds.remainder(60));
    String defValue = '$hours:$minutes:$seconds';
    switch (widget.timerState) {
      case TimerState.showInHMS:
        defValue = '$hours:$minutes:$seconds';
        break;
      case TimerState.showInDef:
        defValue = '$days:$hours:$minutes:$seconds';
        break;
      case TimerState.showInMS:
        defValue = '$minutes:$seconds';
        break;
      case TimerState.showInSeconds:
        defValue = seconds;
        break;
      default:
    }
    return defValue;
  }
}