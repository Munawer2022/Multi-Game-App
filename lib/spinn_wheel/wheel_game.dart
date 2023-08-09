import 'package:animation/utils.dart';
// import 'package:confetti/confetti.dart';
import 'package:countup/countup.dart';
import 'package:flutter/cupertino.dart';
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
  @override
  void dispose() {
    // _controllerCenter.dispose();
    selected.close();
    super.dispose();
  }

  final selected = BehaviorSubject<int>();
  int rewards = 0;

  List<int> items = [
    8,
    3,
    2,
    9,
    11,
    40,
    0,
    3,
    12,
    0,
    // 5,
    // 7,
    // 12,
    // 0,
    // 5,
    // 7,
    // 12,
    // 0,
    // 5,
    // 7,
    // // 5,
    // 7,
    // 12,
    // 0,
    // 5,
    // 7,
    // 12,
    // 0,
    // 5,
    // 7,
  ];
  List<Color> color = [
    Colors.red,
    Colors.black,
    Colors.red,
    Colors.green,
    Colors.red,
    Colors.black,
    Colors.red,
    Colors.green,
    Colors.red,
    Colors.black,
    // Colors.red,
    // Colors.green,
    // Colors.red,
    // Colors.black,
    // Colors.red,
    // Colors.green,
    // Colors.red,
    // Colors.black,
    // Colors.red,
    // Colors.green,
    // //
    // Colors.red,
    // Colors.green,
    // Colors.red,
    // Colors.black,
    // Colors.red,
    // Colors.green,
    // Colors.red,
    // Colors.black,
    // Colors.red,
    // Colors.green,
  ];
  bool play = false;
  void _showAlertDialog(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text('🥳 Congratulation'),
          content: Text("You just won $rewards Coins!."),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            CupertinoDialogAction(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var sized = MediaQuery.of(context);
    return Scaffold(
        body: Stack(children: [
      Container(
        height: double.infinity,
        width: double.infinity,
        foregroundDecoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.red.shade200,
              Colors.transparent,
              // Colors.transparent,
              // Colors.black
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0, 0.5],
          ),
        ),
        child: Image.asset(
          'assets/images/wheel_back.jpg',
          height: 1200,
          width: 1200,
          fit: BoxFit.cover,
          opacity: const AlwaysStoppedAnimation(.7),
        ),
      ),
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/coin.png',
                    scale: 15,
                  ),
                  SizedBox(width: sized.size.width * 0.01),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Countup(
                          begin: 0,
                          end: 22.00,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          softWrap: false,
                          duration: const Duration(milliseconds: 500),
                          separator: ',',
                          style: theme.textTheme.headline1?.copyWith(
                              fontFamily: 'BebasNeue',
                              // fontStyle: FontStyle.italic,
                              // fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      SizedBox(width: sized.size.width * 0.01),
                      const Text(
                        '/Available coin',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontStyle: FontStyle.italic),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: sized.size.height * 0.03),
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
                          height: 350,
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
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 110),
                                    child: RotatedBox(
                                      quarterTurns: 1,
                                      child: Text(
                                        items[i].toString(),
                                      ),
                                    ),
                                  ),
                                  style: FortuneItemStyle(
                                    textAlign: TextAlign.end,
                                    textStyle: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                    color: color[i],
                                    borderColor: Colors.yellow.shade700,
                                    borderWidth: 5,
                                  ),
                                ),
                              },
                            ],
                            onAnimationEnd: () {
                              Future.delayed(Duration(milliseconds: 350), () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            super.widget));
                              });
                              setState(() {
                                play = !play;
                                rewards = items[selected.value];
                              });
                              if (kDebugMode) {
                                print(rewards);
                              }
                              Future.delayed(Duration(milliseconds: 400), () {
                                _showAlertDialog(context);
                              });

                              // snackbar(
                              //     "🥳 You just won $rewards Points!", context);
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
            SizedBox(
              height: sized.size.height * .01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'One spin in just ',
                  style: Theme.of(context).textTheme.headline5?.copyWith(
                      color: const Color(0xffFFF893),
                      fontStyle: FontStyle.italic),
                ),
                Text(
                  '100 coin',
                  style: Theme.of(context).textTheme.headline5?.copyWith(
                      color: const Color(0xffFFF893),
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic),
                ),
              ],
            ),
            // TextButton.icon(
            //     onPressed: () {
            //       setState(() {});
            //     },
            //     icon: Icon(Icons.replay_outlined),
            //     label: Text('Retry?'))
          ],
        ),
      ),
      AnimatedPositioned(
        curve: Curves.easeInOut,
        top: 0,
        left: 0,
        right: 50,
        bottom: play ? 600 : 0,
        duration: Duration(milliseconds: 500),
        child: Center(
            child: Opacity(
          opacity: play ? 1.0 : 0.0,
          child: Text('+$rewards',
              style: theme.textTheme.headline2?.copyWith(
                  fontFamily: 'BebasNeue',
                  // fontStyle: FontStyle.italic,r
                  // fontWeight: FontWeight.bold,
                  color: Colors.white)),
        )),
      )
    ]));
  }
}
