import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_spinning_wheel/flutter_spinning_wheel.dart';

import 'package:google_fonts/google_fonts.dart';

class MyHomePage extends StatelessWidget {
  final StreamController _dividerController = StreamController<int>();

  MyHomePage({super.key});

  dispose() {
    _dividerController.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffDDC3FF),
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
                  style: GoogleFonts.gamjaFlower().copyWith(
                      color: const Color(0xffFFF893),
                      fontSize: 50,
                      fontWeight: FontWeight.w900),
                  // style: Theme.of(context).textTheme.headline5?.copyWith(
                  //     color: Color(0xffFFF893),
                  //     fontSize: 30,
                  //     fontWeight: FontWeight.w900),
                ),
                const SizedBox(
                  height: 60,
                ),
                Center(
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      Center(
                        child: Image.asset(
                          'assets/images/wheel_back_light.png',
                          height: 450,
                          width: 450,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SpinningWheel(
                        Image.asset(
                          'assets/images/wheel_round.png',
                        ),
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
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                StreamBuilder(
                  stream: _dividerController.stream,
                  builder: (context, snapshot) => snapshot.hasData
                      ? RouletteScore(
                          snapshot.data,
                        )
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
    1: '100k',
    2: '800k',
    3: '50k',
    4: '600k',
    5: '10k',
    6: 'ZONK',
    7: '20k',
    8: '1000k',
    // 9: '5k',
    // 10: 'ZONK',
    // 11: '1k',
    // 12: 'JACKPORT',
  };

  RouletteScore(this.selected, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text('${labels[selected]}',
        style: const TextStyle(
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.bold,
          fontSize: 24.0,
          color: Color(0xffFFF893),
        ));
  }
}
