import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';

class WheelGame extends StatefulWidget {
  const WheelGame({super.key});

  @override
  State<WheelGame> createState() => _WheelGameState();
}

class _WheelGameState extends State<WheelGame> {
  StreamController<int> controller = StreamController<int>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FortuneWheel(
      selected: controller.stream,
      items: [
        FortuneItem(child: Text('Han Solo')),
        FortuneItem(child: Text('Yoda')),
        FortuneItem(child: Text('Obi-Wan Kenobi')),
      ],
    ));
  }
}
