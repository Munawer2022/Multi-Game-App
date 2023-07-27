import 'dart:math';

import 'package:animation/dashboard.dart';
import 'package:animation/horse/detail_screen.dart';
import 'package:animation/navigate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ticket_widget/ticket_widget.dart';

import '../ticket_data.dart';

class HorseRaceScreen extends StatefulWidget {
  const HorseRaceScreen({super.key});

  @override
  _HorseRaceScreenState createState() => _HorseRaceScreenState();
}

class _HorseRaceScreenState extends State<HorseRaceScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  double horse1Position = 0.0;
  double horse2Position = 0.0;
  double horse3Position = 0.0;
  bool isRaceInProgress = false;
  late int random1;
  late int random2;
  late int random3;

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));

    _animationController.addListener(() {
      setState(() {
        horse1Position = _animationController.value * random1;
        horse2Position = _animationController.value * random2;
        horse3Position = _animationController.value * random3;
      });
    });
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        isRaceInProgress = false;

        showCupertinoDialog(
          context: context,
          builder: (BuildContext context) {
            return CupertinoAlertDialog(
              title: Column(
                children: [
                  const CircleAvatar(
                    child: Center(child: Text('1')),
                  ),
                  SizedBox(
                    width: 60,
                    height: 50,
                    child: Image.asset(
                        'assets/images/horse.gif'), // Add your horse image
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Your Horse ',
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                      children: <TextSpan>[
                        TextSpan(
                            text: 'WON',
                            style: TextStyle(
                                fontWeight: FontWeight.w900,
                                color: Colors.green.shade700)),
                        const TextSpan(
                          text: ' The Race',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              content: const Text("Check out for more detail"),
              actions: <Widget>[
                CupertinoDialogAction(
                  child: const Text("CANCEL"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                CupertinoDialogAction(
                  child: const Text("DETAIL"),
                  onPressed: () {
                    // Navigator.of(context).pop();
                    AppNavigator().push(context, const DetailScreen());
                  },
                ),
              ],
            );
          },
        );
      }
    });
  }

  void _startRace() {
    if (!isRaceInProgress) {
      setState(() {
        random1 = Random().nextInt(500) + 300;
        random2 = Random().nextInt(500) + 300;
        random3 = Random().nextInt(500) + 300;

        isRaceInProgress = true;
        horse1Position = 0.0;
        horse2Position = 0.0;
        horse3Position = 0.0;
      });
      _animationController.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            RaceTrack(
              horse1Position: horse1Position,
              horse2Position: horse2Position,
              horse3Position: horse3Position,
            ),
            Center(
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).primaryColor)),
                onPressed: _startRace,
                child: const Text(
                  ' Start Race',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RaceTrack extends StatelessWidget {
  final double horse1Position;
  final double horse2Position;
  final double horse3Position;

  RaceTrack(
      {required this.horse1Position,
      required this.horse2Position,
      required this.horse3Position});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/images/track.jpg',
          height: 1200,
          width: 1200,
          fit: BoxFit.fill,
        ),
        // Positioned(
        //   left: 650,
        //   child: Image.asset(
        //     'assets/images/line.png',

        //     // color: Colors.red,
        //   ),
        // ),
        position(horse1Position, 200, '1'),
        position(horse2Position, 230, '21'),
        position(horse3Position, 260, '11'),
        // Positioned(
        //   top: 200,
        //   left: horse1Position,
        //   child: Column(
        //     children: [
        //       const CircleAvatar(
        //         radius: 13,
        //         child: Center(
        //             child: Padding(
        //           padding: EdgeInsets.all(2.0),
        //           child: Text('1'),
        //         )),
        //       ),
        //       Horse(),
        //     ],
        //   ),
        // ),
        // Positioned(
        //   top: 230,
        //   left: horse2Position,
        //   child: Column(
        //     children: [
        //       const CircleAvatar(
        //         radius: 13,
        //         child: Center(
        //             child: Padding(
        //           padding: EdgeInsets.all(2.0),
        //           child: Text('21'),
        //         )),
        //       ),
        //       Horse(),
        //     ],
        //   ),
        // ),
        // Positioned(
        //   top: 260,
        //   left: horse3Position,
        //   child: Column(
        //     children: [
        //       const CircleAvatar(
        //         radius: 13,
        //         child: Center(
        //             child: Padding(
        //           padding: EdgeInsets.all(2.0),
        //           child: Text('11'),
        //         )),
        //       ),
        //       Horse(),
        //     ],
        //   ),
        // ),R
      ],
    );
  }
}

class Horse extends StatelessWidget {
  const Horse({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      height: 50,
      child: Image.asset('assets/images/horse.gif'), // Add your horse image
    );
  }
}

Widget position(horse3Position, double top, text) {
  return Positioned(
    top: top,
    left: horse3Position,
    child: Column(
      children: [
        CircleAvatar(
          radius: 13,
          child: Center(
              child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Text(text),
          )),
        ),
        const Horse(),
      ],
    ),
  );
}
