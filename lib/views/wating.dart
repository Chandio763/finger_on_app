

import 'package:flutter/material.dart';

class Waiting extends StatelessWidget {
  const Waiting({Key? key,required this.remainingTime}) : super(key: key);
  final int remainingTime;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Waiting'),),
      body: Center(
        child: Text('Remaining miliseconds ${remainingTime-DateTime.now().millisecondsSinceEpoch}'),
      ),
    );
  }
}