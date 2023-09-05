import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:animation/user.dart';
import 'package:animation/utils.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../dashboard.dart';
import '../ludo/ludo_provider.dart';
import '../ludo/widgets/dice_widget.dart';
import 'dice_game.dart';

class DiceGameScreen extends StatefulWidget {
  const DiceGameScreen({super.key});

  @override
  State<DiceGameScreen> createState() => _DiceGameScreenState();
}

class _DiceGameScreenState extends State<DiceGameScreen> {
  final box = GetStorage();
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

    checkBalance();
  }

  ///dice game
  final diceList = const [
    'assets/images/dice/1.png',
    'assets/images/dice/2.png',
    'assets/images/dice/3.png',
    'assets/images/dice/4.png',
    'assets/images/dice/5.png',
    'assets/images/dice/6.png',
    // 'pictures/d1.jpg',
    // 'pictures/d2.jpg',
    // 'pictures/d3.png',
    // 'pictures/d4.png',
    // 'pictures/d5.jpg',
    // 'pictures/d6.png',
  ];
  final random = Random.secure();
  var index1 = 0;
  var index2 = 0;
  var score = 0;
  var diceSum = 0;
  var isOver = false;
  _rollTheDice() {
    // (setState).nextint;
    setState(() {
      index1 = random.nextInt(6);
      index2 = random.nextInt(6);
      diceSum = index1 + index2 + 2;
      if (diceSum == 7) {
        isOver = true;
      } else {
        score += index1 + index2 + 2;
      }
    });
  }

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
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  'assets/images/dice.jpg',
                ),
              ),
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
          ),
          Center(
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                              availableCoin(context, availableCoins)
                            ])),
                        Column(
                          children: [
                            Text(
                              'Score:$score',
                              style:
                                  TextStyle(fontSize: 40, color: Colors.white),
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  diceList[index1],
                                  width: 100,
                                  height: 100,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Image.asset(
                                  diceList[index2],
                                  width: 100,
                                  height: 100,
                                ),
                                // SizedBox(width: 100, height: 100, child: DiceWidget()),
                                // SizedBox(width: 10),
                                // SizedBox(width: 100, height: 100, child: DiceWidget()),
                              ],
                            ),
                            SizedBox(height: 30),
                            Text(
                              'Dice Sum:$diceSum',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                        SizedBox(height: 40),
                        Column(
                          children: [
                            Button(title: '7 up', onTap: _rollTheDice),
                            SizedBox(height: 20),
                            Button(title: '7 down', onTap: _rollTheDice),
                            SizedBox(
                              height: sized.size.height * .01,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'One spin in just ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5
                                      ?.copyWith(
                                          color: const Color(0xffFFF893),
                                          fontStyle: FontStyle.italic),
                                ),
                                Image.asset(
                                  'assets/images/coin.png',
                                  scale: 20,
                                ),
                                Text(
                                  '25',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5
                                      ?.copyWith(
                                          color: const Color(0xffFFF893),
                                          fontWeight: FontWeight.w900,
                                          fontStyle: FontStyle.italic),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ])))
        ],
      ),
    );
  }
}
