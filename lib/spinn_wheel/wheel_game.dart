import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:neopop/widgets/buttons/neopop_button/neopop_button.dart';
import 'package:neopop/widgets/shimmer/neopop_shimmer.dart';

import 'package:rxdart/rxdart.dart';

class WheelGame extends StatefulWidget {
  const WheelGame({Key? key}) : super(key: key);

  @override
  State<WheelGame> createState() => _WheelGameState();
}

class _WheelGameState extends State<WheelGame> {
  final selected = BehaviorSubject<int>();
  int rewards = 0;

  List<int> items = [100, 200, 500, 1000, 2000, 40];
  List<Color> color = [
    Colors.red,
    Colors.orange,
    Colors.red,
    Colors.orange,
    Colors.red,
    Colors.orange,
  ];

  @override
  void dispose() {
    selected.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
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
                  color: const Color(0xffFFF893), fontWeight: FontWeight.w900),
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
                  Center(
                    child: Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        SizedBox(
                          height: 300,
                          child: FortuneWheel(
                            physics: CircularPanPhysics(
                              duration: const Duration(seconds: 1),
                              curve: Curves.decelerate,
                            ),
                            onFling: () {
                              selected.add(1);
                            },
                            indicators: const <FortuneIndicator>[
                              FortuneIndicator(
                                alignment: Alignment.topCenter,
                                child: TriangleIndicator(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                            selected: selected.stream,
                            animateFirst: false,
                            items: [
                              for (int i = 0;
                                  i < items.length;
                                  i++) ...<FortuneItem>{
                                FortuneItem(
                                  child: Text(items[i].toString()),
                                  style: FortuneItemStyle(
                                    textStyle: TextStyle(fontSize: 24),
                                    color: color[i],
                                    borderColor: Colors.yellow.shade700,
                                    borderWidth: 11,
                                  ),
                                ),
                              },
                            ],
                            onAnimationEnd: () {
                              setState(() {
                                rewards = items[selected.value];
                              });
                              if (kDebugMode) {
                                print(rewards);
                              }
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                      Text("You just won $rewards Points!"),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: NeoPopButton(
                color: Colors.red,
                onTapUp: () {
                  setState(() {
                    selected.add(Fortune.randomInt(0, items.length));
                  });
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
          ],
        ),
      )
    ]));
  }
}
