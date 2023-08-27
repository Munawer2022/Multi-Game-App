import 'dart:async';

import 'package:animation/auth/login/login.dart';
import 'package:flutter/material.dart';

import 'package:get_storage/get_storage.dart';

import 'dashboard.dart';
import 'navigate.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    animationController.repeat();
    Timer(const Duration(seconds: 2), () => splashScreen.check(context));
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  SplashServices splashScreen = SplashServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        body: Stack(
          children: [
            Container(
                height: double.infinity,
                width: double.infinity,
                // foregroundDecoration: const BoxDecoration(
                //   gradient: LinearGradient(
                //     colors: [
                //       Colors.black,
                //       Colors.transparent,
                //       Colors.transparent,
                //       Colors.black
                //     ],
                //     begin: Alignment.center,
                //     end: Alignment.center,
                //     stops: [0, 0.3, 0.011, 1],
                //   ),
                // ),
                child: AnimatedContainer(
                  height: double.infinity,
                  width: double.infinity,
                  color: Colors.black,
                  duration: Duration(),
                )
                // Image.asset(
                //   'assets/images/game.png',
                //   height: 1200,
                //   width: 1200,
                //   fit: BoxFit.cover,
                // ),
                ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 100,
                    width: 100,
                    child: CircularProgressIndicator(
                      valueColor: animationController.drive(ColorTween(
                          begin: Colors.blueAccent, end: Colors.red)),
                      strokeWidth: 7,
                      // color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    'Game Zone\n          -',
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        color: Colors.white, fontFamily: 'BebasNeue'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SplashServices {
  final box = GetStorage();
  void check(BuildContext context) {
    // if (box.read('token') != null) {
    //   AppNavigator().push(context, const Dahboard());
    // } else {
    //   AppNavigator().push(context, LoginScreen());
    // }
    AppNavigator().push(context, const Dahboard());
  }
}
