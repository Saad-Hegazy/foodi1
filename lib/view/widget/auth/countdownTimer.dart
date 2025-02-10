import 'dart:async';
import 'package:flutter/material.dart';

import '../../../core/constant/color.dart';

class CountdownTimerWidget extends StatefulWidget {
  final int durationInSeconds;

  const CountdownTimerWidget({Key? key, required this.durationInSeconds}) : super(key: key);

  @override
  _CountdownTimerWidgetState createState() => _CountdownTimerWidgetState();
}

class _CountdownTimerWidgetState extends State<CountdownTimerWidget> {
  late int _remainingSeconds;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _remainingSeconds = widget.durationInSeconds;
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        _timer.cancel(); // Stop the timer when it reaches zero
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer when widget is disposed
    super.dispose();
  }

  String get _formattedTime {
    int minutes = _remainingSeconds ~/ 60;
    int seconds = _remainingSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Please wait for the OTP validation:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 10),
          Text(
            _formattedTime,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: AppColor.primaryColor,
            ),
          ),
          SizedBox(height: 10),
          if (_remainingSeconds == 0)
            Text('You can try again now.', style: TextStyle(color: Colors.green)),
        ],
      ),
    );
  }
}
