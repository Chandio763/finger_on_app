import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/index.dart';

class WaitingTime extends StatefulWidget {
  const WaitingTime({Key? key, required this.endTime}) : super(key: key);
  final int endTime;
  @override
  State<WaitingTime> createState() => _WaitingTimeState();
}

class _WaitingTimeState extends State<WaitingTime> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Remaining Time'),
      ),
      body: Center(
        child: CountdownTimer(
          endTime: widget.endTime,
          textStyle: const TextStyle(fontSize: 25,fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
