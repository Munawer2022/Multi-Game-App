import 'dart:convert';

import 'package:animation/horse/horse_bid.dart';
import 'package:animation/horse/horse_race.dart';
import 'package:animation/navigate.dart';
import 'package:animation/spinn_wheel/spinn_wheel_bid.dart';
import 'package:animation/spinn_wheel/wheel_game.dart';
import 'package:animation/ticket_button/ticket_ui_screen.dart';
import 'package:animation/user.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:countup/countup.dart';
// import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';

class Dahboard extends StatefulWidget {
  const Dahboard({super.key});

  @override
  State<Dahboard> createState() => _DahboardState();
}

class _DahboardState extends State<Dahboard> {
  @override
  initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var sized = MediaQuery.of(context);
    List items = [
      newContainer(context, 'assets/images/horse.jpg', const HorseRaceScreen()),
      // newContainer(context, 'assets/images/wheel.jpg', const SpinnWheelBid()),
    ];
    return WillPopScope(
      onWillPop: () async {
        await SystemNavigator.pop();
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          body: Center(
            child: Stack(
              children: [
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  foregroundDecoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black,
                        Colors.transparent,
                        Colors.transparent,
                        Colors.black
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0, 0.5, 0.11, 1],
                    ),
                  ),
                  child: Image.asset(
                    'assets/images/game.png',
                    height: 1200,
                    width: 1200,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: () {
                                AppNavigator().push(context, User());
                              },
                              icon: CircleAvatar(
                                  maxRadius: 40,
                                  backgroundColor:
                                      Colors.white.withOpacity(0.3),
                                  child: const Center(
                                      child: Icon(
                                    CupertinoIcons.person_alt,
                                    size: 40,
                                    color: Colors.white,
                                  )))),
                          Text(
                            'Dashboard',
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium
                                ?.copyWith(
                                    color: Colors.white,
                                    fontFamily: 'BebasNeue'),
                          ),
                        ],
                      ),

                      CarouselSlider(
                          options: CarouselOptions(
                            height: 200.0,
                            aspectRatio: 16 / 9,
                            viewportFraction: 0.8,
                            initialPage: 0,
                            enableInfiniteScroll: true,
                            reverse: false,
                            autoPlay: true,
                            autoPlayInterval: const Duration(seconds: 3),
                            autoPlayAnimationDuration:
                                const Duration(milliseconds: 800),
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enlargeCenterPage: true,
                            enlargeFactor: 0.3,
                            scrollDirection: Axis.horizontal,
                          ),
                          items: [
                            newContainer(context, 'assets/images/horse.jpg',
                                const HorseRaceScreen()),
                            newContainer(context, 'assets/images/wheel.jpg',
                                const WheelGame()),
                          ]),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     container(context, 'assets/images/horse.jpg',
                      //         const HorseRaceScreen()),
                      //     const SizedBox(
                      //       width: 10,
                      //     ),
                      //     Center(
                      //         child: container(
                      //             context,
                      //             'assets/images/wheel.jpg',
                      //             const WheelGame())),
                      //   ],
                      // ),
                      Center(
                        child: Text(
                          'Game Zone\n          -',
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge
                              ?.copyWith(
                                  color: Colors.white, fontFamily: 'BebasNeue'),
                        ),
                      ),
                      const SizedBox(
                        height: 0,
                      ),
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
                                      color: Colors.white60,
                                      fontSize: 16,
                                      fontStyle: FontStyle.italic),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget container(BuildContext context, image, page) {
  return InkWell(
    borderRadius: BorderRadius.circular(60),
    onTap: () {
      DateTime dateTime = DateTime.now();

      debugPrint('\x1B[33m$dateTime\x1B[0m'
          // dateTime.toString()
          );
      AppNavigator().push(context, page);
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => page),
      // );
    },
    child: Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: ExactAssetImage(image),
          fit: BoxFit.cover,
        ),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.grey.withOpacity(.5),
        //     blurRadius: 13,
        //     offset: Offset(-4, 8),
        //   ),
        // ],
      ),
    ),
  );
}

Widget newContainer(BuildContext context, image, page) {
  return InkWell(
    borderRadius: BorderRadius.circular(60),
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => page),
      );
    },
    child: Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: ExactAssetImage(image),
          fit: BoxFit.cover,
        ),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.grey.withOpacity(.5),
        //     blurRadius: 13,
        //     offset: Offset(-4, 8),
        //   ),
        // ],
      ),
    ),
  );
}
