import 'dart:convert';
import 'dart:io';

import 'package:animation/horse/horse_bid.dart';
import 'package:animation/horse/horse_race.dart';
import 'package:animation/navigate.dart';
import 'package:animation/spinn_wheel/spinn_wheel_bid.dart';
import 'package:animation/spinn_wheel/wheel_game.dart';
import 'package:animation/ticket_button/ticket_ui_screen.dart';
import 'package:animation/user.dart';
import 'package:animation/utils.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:countup/countup.dart';
// import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'auth/login/login.dart';
import 'ludo/main_screen.dart';

class Dahboard extends StatefulWidget {
  const Dahboard({super.key});

  @override
  State<Dahboard> createState() => _DahboardState();
}

final box = GetStorage();

class _DahboardState extends State<Dahboard> {
  int availableCoins = 0;
  void checkBalance() async {
    String date = DateTime.now().toString();
    var url = Uri.parse(
        "https://cybermaxuk.com/gamezone/game_backend/public/api/check-user-balance?userId=" +
            box.read('id').toString());

    var response = await http.get(url, headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.acceptHeader: "application/json",
    });
    var responseData = json.decode(response.body);
    print(responseData['coin_balance']);
    String responseCoins = responseData['coin_balance'].toString();
    availableCoins =
        int.parse(responseCoins.substring(0, responseCoins.length - 3));
    setState(() {});
  }

  @override
  initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    checkBalance();
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
    // List items = [
    //   newContainer(context, 'assets/images/horse.jpg', const HorseRaceScreen()),
    //   // newContainer(context, 'assets/images/wheel.jpg', const SpinnWheelBid()),
    // ];
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
                                if (box.read('token') == null) {
                                  AppNavigator().push(context, LoginScreen());
                                } else {
                                  AppNavigator().push(context, User());
                                }
                              },
                              icon: CircleAvatar(
                                maxRadius: 43,
                                backgroundColor: Colors.white,
                                child: CircleAvatar(
                                    maxRadius: 40,
                                    backgroundColor: Colors.black,
                                    child: const Center(
                                        child: Icon(
                                      CupertinoIcons.game_controller_solid,
                                      size: 40,
                                      color: Colors.white,
                                    ))),
                              )),
                          Text(
                            'User Profile',
                            style: Theme.of(context)
                                .textTheme
                                .headline4
                                ?.copyWith(
                                    fontWeight: FontWeight.w900,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.white,
                                    fontFamily: 'Open Sans'),
                          ),
                          // Text(
                          //   'Dashboard',
                          //   style: Theme.of(context)
                          //       .textTheme
                          //       .displayMedium
                          //       ?.copyWith(
                          //           color: Colors.white,
                          //           fontFamily: 'BebasNeue'),
                          // ),
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
                            autoPlay: false,
                            autoPlayInterval: const Duration(seconds: 3),
                            autoPlayAnimationDuration:
                                const Duration(milliseconds: 800),
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enlargeCenterPage: true,
                            enlargeFactor: 0.3,
                            scrollDirection: Axis.horizontal,
                          ),
                          items: [
                            newContainer(context, 'assets/images/horse.jpg'),
                            newContainer(context, 'assets/images/wheel.jpg'),
                            newContainer(
                                context, 'assets/images/ludo_slide_back.png'),
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
                            availableCoin(context, availableCoins)
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

// Widget container(BuildContext context, image, page) {
//   return InkWell(
//     borderRadius: BorderRadius.circular(60),
//     onTap: () {
//       DateTime dateTime = DateTime.now();

//       debugPrint('\x1B[33m$dateTime\x1B[0m'
//           // dateTime.toString()
//           );
//       AppNavigator().push(context, page);
//       // Navigator.push(
//       //   context,
//       //   MaterialPageRoute(builder: (context) => page),
//       // );
//     },
//     child: Container(
//       width: 100,
//       height: 100,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(20),
//         image: DecorationImage(
//           image: ExactAssetImage(image),
//           fit: BoxFit.cover,
//         ),
//         // boxShadow: [
//         //   BoxShadow(
//         //     color: Colors.grey.withOpacity(.5),
//         //     blurRadius: 13,
//         //     offset: Offset(-4, 8),
//         //   ),
//         // ],
//       ),
//     ),
//   );
// }

Widget newContainer(BuildContext context, image) {
  void checkRace() async {
    String date = DateTime.now().toString();
    var url = Uri.parse(
        "https://cybermaxuk.com/gamezone/game_backend/public/api/check-race?datetime=$date");

    var response = await http.get(url, headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.acceptHeader: "application/json",
    });
    var responseData = json.decode(response.body);
    print(responseData);
    String hour =
        (int.parse(DateFormat('hh').format(DateTime.now())) + 1).toString();
    String ampm = DateFormat('a').format(DateTime.now());

    print(ampm);
    if (responseData["message"] ==
        "No race available on the specified time within the next 5 minutes.") {
      AppNavigator().push(context, HorseBid(hour: hour, ampm: ampm));
    } else if (responseData["message"] ==
        "Race is available on the specified time.") {
      print(responseData['winner_horse_no']);
      AppNavigator().push(
          context,
          HorseRaceScreen(
              winnerHorse: responseData['winner_horse_no'].toString()));
    }
  }

  return InkWell(
    borderRadius: BorderRadius.circular(60),
    onTap: () {
      if (box.read('token') == null) {
        AppNavigator().push(context, LoginScreen());
      } else {
        if (image == "assets/images/horse.jpg") {
          checkRace();
        } else if (image == "assets/images/wheel.jpg") {
          AppNavigator().push(context, WheelGame());
        } else {
          AppNavigator().push(context, MainScreen());
        }
      }
    },
    child: Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 3),
        color: Colors.black87,
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          // opacity: .7,
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
