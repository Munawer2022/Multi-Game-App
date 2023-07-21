import 'dart:async';
import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';

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

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    );

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
            Positioned(
              right: -0,
              bottom: -0,
              child: ElevatedButton(
                onPressed: _startRace,
                child: Text(' Start Race'),
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
        Positioned(
          left: 650,
          child: Image.asset(
            'assets/images/line.png',
            scale: 5,
            // color: Colors.red,
          ),
        ),
        // Container(
        //   width: 300,
        //   height: 100,
        //   decoration: BoxDecoration(
        //     border: Border.all(color: Colors.black, width: 2),
        //   ),
        // ),
        Positioned(
          top: 0,
          left: horse1Position,
          child: Column(
            children: [
              const CircleAvatar(
                radius: 13,
                child: Center(
                    child: Padding(
                  padding: EdgeInsets.all(2.0),
                  child: Text('1'),
                )),
              ),
              Horse(),
            ],
          ),
        ),
        Positioned(
          top: 30,
          left: horse2Position,
          child: Column(
            children: [
              const CircleAvatar(
                radius: 13,
                child: Center(
                    child: Padding(
                  padding: EdgeInsets.all(2.0),
                  child: Text('21'),
                )),
              ),
              Horse(),
            ],
          ),
        ),
        Positioned(
          top: 60,
          left: horse3Position,
          child: Column(
            children: [
              const CircleAvatar(
                radius: 13,
                child: Center(
                    child: Padding(
                  padding: EdgeInsets.all(2.0),
                  child: Text('11'),
                )),
              ),
              Horse(),
            ],
          ),
        ),
      ],
    );
  }
}

class Horse extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 30,
      child: Image.asset('assets/images/horse.gif'), // Add your horse image
    );
  }
}
