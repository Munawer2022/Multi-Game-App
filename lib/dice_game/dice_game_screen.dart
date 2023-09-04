import 'package:flutter/material.dart';

class DiceGameScreen extends StatelessWidget {
  const DiceGameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var sized = MediaQuery.of(context);
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            foregroundDecoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black,
                  Colors.transparent,
                  Colors.transparent,
                  Colors.black
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0, 0.8, 0.2, 1],
              ),
            ),
            child: Image.asset(
              'assets/images/dice_bac.png',
              // height: 1200,
              // width: 1200,
              fit: BoxFit.cover,
              opacity: const AlwaysStoppedAnimation(.7),
            ),
          ),
        ],
      ),
    );
  }
}
