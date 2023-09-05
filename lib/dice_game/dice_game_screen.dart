import 'dart:convert';
import 'dart:io';

import 'package:animation/user.dart';
import 'package:animation/utils.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'package:http/http.dart' as http;
import '../ludo/widgets/dice_widget.dart';

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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: 100, height: 100, child: DiceWidget()),
                    SizedBox(width: 10),
                    SizedBox(width: 100, height: 100, child: DiceWidget()),
                  ],
                ),
                SizedBox(height: 40),
                Column(
                  children: [
                    Button(title: '7 up', onTap: () {}),
                    SizedBox(height: 20),
                    Button(title: '7 down', onTap: () {}),
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
              ],
            ),
          ))
        ],
      ),
    );
  }
}
