import 'package:flutter/material.dart';

class HorseRaceScreen extends StatefulWidget {
  @override
  _HorseRaceScreenState createState() => _HorseRaceScreenState();
}

class _HorseRaceScreenState extends State<HorseRaceScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  double horse1Position = 0.0;
  double horse2Position = 0.0;
  bool isRaceInProgress = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3), // Adjust the duration as needed
    );
    _animationController.addListener(() {
      setState(() {
        horse1Position =
            _animationController.value * 300; // Adjust the distance
        horse2Position =
            _animationController.value * 500; // Adjust the distance
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
        isRaceInProgress = true;
        horse1Position = 0.0;
        horse2Position = 0.0;
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
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RaceTrack(
              horse1Position: horse1Position,
              horse2Position: horse2Position,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _startRace,
              child: Text('Start Race'),
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

  RaceTrack({required this.horse1Position, required this.horse2Position});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 300,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 2),
          ),
        ),
        Positioned(
          top: 10,
          left: horse1Position,
          child: Horse(),
        ),
        Positioned(
          top: 60,
          left: horse2Position,
          child: Column(
            children: [
              Text('11'),
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
