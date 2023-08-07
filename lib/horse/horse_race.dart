import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../navigate.dart';
import 'detail_screen.dart';

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
  double horse4Position = 0.0;
  double horse5Position = 0.0;
  double horse6Position = 0.0;
  double horse7Position = 0.0;
  double horse8Position = 0.0;
  double horse9Position = 0.0;

  bool isRaceInProgress = false;
  late int random1;
  late int random2;
  late int random3;
  late int random4;
  late int random5;
  late int random6;
  late int random7;
  late int random8;
  late int random9;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    

    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 7));

    _animationController.addListener(() {
      setState(() {
        horse1Position = _animationController.value * random1;
        horse2Position = _animationController.value * random2;
        horse3Position = _animationController.value * random3;
        horse4Position = _animationController.value * random4;
        horse5Position = _animationController.value * random5;
        horse6Position = _animationController.value * random6;
        horse7Position = _animationController.value * random7;
        horse8Position = _animationController.value * random8;
        horse9Position = _animationController.value * random9;
      });
    });
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        isRaceInProgress = false;
        AppNavigator().push(context, const DetailScreen());
      }
    });
  }

  void _startRace() {
    if (!isRaceInProgress) {
      setState(() {
        random1 = Random().nextInt(500) + 300;
        random2 = Random().nextInt(500) + 300;
        random3 = Random().nextInt(500) + 300;
        random4 = Random().nextInt(500) + 300;
        random5 = Random().nextInt(500) + 300;
        random6 = Random().nextInt(500) + 300;
        random7 = Random().nextInt(500) + 300;
        random8 = Random().nextInt(500) + 300;
        random9 = Random().nextInt(500) + 300;

        isRaceInProgress = true;
        horse1Position = 0.0;
        horse2Position = 0.0;
        horse3Position = 0.0;
        horse3Position = 0.0;
        horse4Position = 0.0;
        horse5Position = 0.0;
        horse6Position = 0.0;
        horse7Position = 0.0;
        horse8Position = 0.0;
        horse9Position = 0.0;
      });
      _animationController.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
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
              horse4Position: horse4Position,
              horse5Position: horse5Position,
              horse6Position: horse6Position,
              horse7Position: horse7Position,
              horse8Position: horse8Position,
              horse9Position: horse9Position,
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
  final double horse4Position;
  final double horse5Position;
  final double horse6Position;
  final double horse7Position;
  final double horse8Position;
  final double horse9Position;

  RaceTrack(
      {required this.horse1Position,
      required this.horse2Position,
      required this.horse3Position,
      required this.horse4Position,
      required this.horse5Position,
      required this.horse6Position,
      required this.horse7Position,
      required this.horse8Position,
      required this.horse9Position});

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
        position(horse1Position, 5, '1'),
        position(horse2Position, 20, '2'),
        position(horse3Position, 50, '3'),
        position(horse4Position, 80, '4'),
        position(horse5Position, 120, '5'),
        position(horse6Position, 150, '6'),
        position(horse7Position, 180, '7'),
        position(horse8Position, 210, '8'),
        position(horse9Position, 240, '9'),
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
          backgroundColor: Colors.brown.shade600,
          radius: 15,
          child: Center(
              child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Text(
              text,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          )),
        ),
        SizedBox(
            height: 12,
            child: VerticalDivider(
              color: Colors.brown.shade600,
              thickness: 2,
            )),
        const Horse(),
      ],
    ),
  );
}
