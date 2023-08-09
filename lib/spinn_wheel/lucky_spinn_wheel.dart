import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinning_wheel/flutter_spinning_wheel.dart';
import 'package:neopop/widgets/buttons/neopop_button/neopop_button.dart';
import 'package:neopop/widgets/shimmer/neopop_shimmer.dart';

class LuckySpinnWheel extends StatefulWidget {
  const LuckySpinnWheel({super.key});

  @override
  State<LuckySpinnWheel> createState() => _LuckySpinnWheelState();
}

class _LuckySpinnWheelState extends State<LuckySpinnWheel> {
  final StreamController _dividerController = StreamController<int>();

  final _wheelNotifier = StreamController<double>();

  @override
  dispose() {
    super.dispose();
    _dividerController.close();
    _wheelNotifier.close();
  }

  // int _lastWinNumber = 1;
  // @override
  // void initState() {
  //   super.initState();
  //   _dividerController.stream.listen((selected) {
  //     setState(() {
  //       _lastWinNumber = selected;
  //     });
  //   });
  // }

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
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      color: const Color(0xffFFF893),
                      fontWeight: FontWeight.w900),
                  // style: Theme.of(context).textTheme.headline5?.copyWith(
                  //     color: Color(0xffFFF893),
                  //     fontSize: 30,
                  //     fontWeight: FontWeight.w900),
                ),
                const SizedBox(
                  height: 10,
                ),
                SpinningWheel(
                  Image.asset(
                    'assets/images/wheel_new.png',
                  ),
                  width: 310,
                  height: 310,
                  initialSpinAngle: _generateRandomAngle(),
                  spinResistance: 0.1,
                  canInteractWhileSpinning: false,
                  dividers: 10,
                  onUpdate: _dividerController.add,
                  onEnd: _dividerController.add,
                  secondaryImage: Image.asset('assets/images/wheel_click.png'),
                  secondaryImageHeight: 110,
                  secondaryImageWidth: 110,
                  shouldStartOrStop: _wheelNotifier.stream,
                ),

                const SizedBox(height: 10),
                StreamBuilder(
                  stream: _dividerController.stream,
                  builder: (context, snapshot) => snapshot.hasData
                      ? RouletteScore(
                          snapshot.data,
                        )
                      : Container(),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: NeoPopButton(
                    color: Colors.red,
                    onTapUp: () {
                      _wheelNotifier.sink.add(_generateRandomVelocity());
                      HapticFeedback.vibrate();
                    },
                    onTapDown: () => HapticFeedback.vibrate(),
                    child: NeoPopShimmer(
                      shimmerColor: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "SPIN",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                // GestureDetector(
                //   onTap: () =>
                //       _wheelNotifier.sink.add(_generateRandomVelocity()),
                //   child: Container(
                //     height: 40,
                //     width: 120,
                //     color: Colors.redAccent,
                //     child: Center(
                //       child: Text("SPIN"),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  double _generateRandomVelocity() => (Random().nextDouble() * 6000) + 2000;

  double _generateRandomAngle() => Random().nextDouble() * pi * 2;
}

class RouletteScore extends StatelessWidget {
  final int selected;

  final Map<int, String> labels = {
    1: '1000\$',
    2: '200\$',
    3: '300\$',
    4: '400\$',
    5: '500\$',
    6: '600\$',
    7: '700\$',
    8: '800\$',
    9: '900\$',
    10: '100\$',
  };

  RouletteScore(this.selected, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text('${labels[selected]}',
        style: const TextStyle(
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.bold,
          fontSize: 36.0,
          color: Color(0xffFFF893),
        ));
  }
}
