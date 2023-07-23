import 'dart:async';
import 'dart:math';

import 'package:animation/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinning_wheel/flutter_spinning_wheel.dart';

class MyHomePage extends StatelessWidget {
  final StreamController _dividerController = StreamController<int>();

  dispose() {
    _dividerController.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffDDC3FF),
      body: Stack(
        children: [
          Image.asset(
            'assets/images/wheel_back.jpg',
            height: 1200,
            width: 1200,
            fit: BoxFit.cover,
            opacity: const AlwaysStoppedAnimation(.7),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Lucky Spinn',
                  style: Theme.of(context).textTheme.headline5?.copyWith(
                      color: Color(0xffFFF893),
                      fontSize: 30,
                      fontWeight: FontWeight.w900),
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  width: 310,
                  height: 310,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromARGB(255, 143, 121, 175),
                        blurRadius: 17,
                        offset: Offset(4, 8),
                      ),
                    ],
                  ),
                  child: SpinningWheel(
                    Image.asset('assets/images/wheel_round.png'),
                    width: 310,
                    height: 310,
                    initialSpinAngle: _generateRandomAngle(),
                    spinResistance: 0.6,
                    canInteractWhileSpinning: false,
                    dividers: 8,
                    onUpdate: _dividerController.add,
                    onEnd: _dividerController.add,
                    secondaryImage:
                        Image.asset('assets/images/wheel_click.png'),
                    secondaryImageHeight: 110,
                    secondaryImageWidth: 110,
                  ),
                ),
                SizedBox(height: 30),
                StreamBuilder(
                  stream: _dividerController.stream,
                  builder: (context, snapshot) => snapshot.hasData
                      ? Card(
                          child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RouletteScore(snapshot.data),
                        ))
                      : Container(),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  double _generateRandomAngle() => Random().nextDouble() * pi * 2;
}

class RouletteScore extends StatelessWidget {
  final int selected;

  final Map<int, String> labels = {
    1: '1000\$',
    2: '400\$',
    3: '800\$',
    4: '7000\$',
    5: '5000\$',
    6: '300\$',
    7: '2000\$',
    8: '100\$',
  };

  RouletteScore(this.selected);

  @override
  Widget build(BuildContext context) {
    return Text('${labels[selected]}',
        style: TextStyle(fontStyle: FontStyle.italic, fontSize: 24.0));
  }
}
