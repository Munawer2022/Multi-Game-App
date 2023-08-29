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
  bool isWheelSpinning = false; // Track the spinning state of the wheel

  // Function to start spinning the wheel
  void startSpinning() {
    setState(() {
      isWheelSpinning = true;
    });

    // Simulate wheel spinning delay
    Future.delayed(Duration(seconds: 5), () {
      // Stop the wheel spinning
      stopSpinning();
    });
  }

  // Function to stop spinning the wheel
  void stopSpinning() {
    setState(() {
      isWheelSpinning = false;
    });
  }

  @override
  void dispose() {
    // _controllerCenter.dispose();
    selected.close();
    super.dispose();
  }

  final selected = BehaviorSubject<int>();
  dynamic rewards = 0;

  List<dynamic> items = [
    '5 coin',
    'x 1',
    '15 coin',
    'x 1',
    '5 coin',
    'x 3',
    '10 coin',
    'x 2',
    '20 coin',
    'x 3',
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
              child: Text('Back'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            CupertinoDialogAction(
              child: Text('Retry?'),
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
                  availableCoin(context, 12)
                  //please add this end point coin api
                ],
              ),
            ),
            SizedBox(height: sized.size.height * 0.03),
            Text(
              'Lucky Spinn',
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  fontStyle: FontStyle.italic,
                  color: const Color(0xffFFF893),
                  fontWeight: FontWeight.w900),
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
                                  //   padding: EdgeInsets.only(left: 110),
                                  // RotatedBox(
                                  //  quarterTurns: 1,
                                  child: Text(
                                    items[i].toString(),
                                  ),
                                  style: FortuneItemStyle(
                                    textAlign: TextAlign.end,
                                    textStyle: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold),
                                    color: color[i],
                                    borderColor: Colors.yellow.shade700,
                                    borderWidth: 5,
                                  ),
                                ),
                              },
                            ],
                            onAnimationEnd: () {
                              Future.delayed(Duration(milliseconds: 400), () {
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
                              Future.delayed(Duration(milliseconds: 450), () {
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
            isWheelSpinning
                ? Container()
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: NeoPopButton(
                      color: Colors.red,
                      onTapUp: isWheelSpinning
                          ? null
                          : () {
                              setState(() {
                                selected
                                    .add(Fortune.randomInt(0, items.length));
                              });
                              HapticFeedback.vibrate();
                              startSpinning();
                            },
                      // color: Colors.red,
                      // onTapUp: () {
                      //   setState(() {
                      //     selected.add(Fortune.randomInt(0, items.length));
                      //   });
                      //   HapticFeedback.vibrate();
                      // },
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
                Image.asset(
                  'assets/images/coin.png',
                  scale: 20,
                ),
                Text(
                  '100',
                  style: Theme.of(context).textTheme.headline5?.copyWith(
                      color: const Color(0xffFFF893),
                      fontWeight: FontWeight.w900,
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
