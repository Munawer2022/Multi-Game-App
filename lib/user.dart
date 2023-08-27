import 'dart:convert';
import 'dart:io';

import 'package:animation/auth/login/login.dart';
import 'package:animation/transfer/transfer.dart';
import 'package:animation/utils.dart';
import 'package:countup/countup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import 'dashboard.dart';
import 'navigate.dart';

class User extends StatefulWidget {
  User({super.key});

  @override
  State<User> createState() => _UserState();
}

class _UserState extends State<User> {
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

  void logout(BuildContext context) async {
    try {
      Response response = await post(
        Uri.parse(
            'https://cybermaxuk.com/gamezone/game_backend/public/api/logout'),
        headers: {
          'Accept': 'application/json',
          'authorization': 'Bearer ' + box.read('token'),
        },
      );

      if (response.statusCode == 200) {
        box.remove('token').then((value) {
          box.erase();
          AppNavigator().push(context, Dahboard());
        });
        // AppNavigator().push(context, const Dahboard());
        var data = jsonDecode(response.body.toString());

        // AppNavigator().push(context, LoginScreen());
        snackbar(data['message'], context);

        if (kDebugMode) {
          print(data);
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var sized = MediaQuery.of(context);
    return Scaffold(
        backgroundColor: Colors.blueAccent.shade100.withOpacity(.3),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: () {
                  AppNavigator().push(context, const Dahboard());
                },
                icon: const Icon(
                  CupertinoIcons.right_chevron,
                  color: Colors.white,
                ))
          ],
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // const CircleAvatar(
                //   radius: 43,
                //   backgroundColor: Colors.white,
                //   child: CircleAvatar(
                //       backgroundColor: Colors.black87,
                //       maxRadius: 40,
                //       child: Icon(
                //         CupertinoIcons.person_solid,
                //         color: Colors.white,
                //         size: 60,
                //       )),
                // ),
                SizedBox(height: sized.size.height * 0.02),
                Text(box.read('name').toString(),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    softWrap: false,
                    style: theme.textTheme.headline3?.copyWith(
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)
                    // ?.copyWith(color: Colors.black87),
                    ),
                SizedBox(height: sized.size.height * 0.03),
                Text(
                  box.read('mobile_no').toString(),
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic),
                ),
                const Text(
                  'Transfer on Oct 21, 2023',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontStyle: FontStyle.italic),
                ),
                SizedBox(height: sized.size.height * 0.05),
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
                              end: availableCoins.toDouble(),
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
                //  const Text(
                //       'Available coin',
                //       style: TextStyle(color: Colors.white, fontSize: 20),
                //     ),
                SizedBox(height: sized.size.height * 0.02),
                Divider(
                  // thickness: 1,
                  color: Colors.white,
                ),
                SizedBox(height: sized.size.height * 0.01),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Won Coin',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontStyle: FontStyle.italic),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/coin.png',
                                scale: 25,
                              ),
                              SizedBox(width: sized.size.width * 0.01),
                              Countup(
                                  begin: 0,
                                  end: 522,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  softWrap: false,
                                  duration: const Duration(milliseconds: 500),
                                  separator: ',',
                                  style: theme.textTheme.headline3?.copyWith(
                                      fontStyle: FontStyle.italic,
                                      fontFamily: 'BebasNeue',
                                      // fontWeight: FontWeight.bold,
                                      color: Colors.green)),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: sized.size.height * 0.02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Loss Coin',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontStyle: FontStyle.italic),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/coin.png',
                                scale: 25,
                              ),
                              SizedBox(width: sized.size.width * 0.01),
                              Countup(
                                  begin: 0,
                                  end: 1000,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  softWrap: false,
                                  duration: const Duration(milliseconds: 500),
                                  separator: ',',
                                  style: theme.textTheme.headline3?.copyWith(
                                      fontStyle: FontStyle.italic,
                                      fontFamily: 'BebasNeue',
                                      // fontWeight: FontWeight.bold,
                                      color: Colors.red)),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: sized.size.height * 0.02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Withdraw Coin',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontStyle: FontStyle.italic),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/coin.png',
                                scale: 25,
                              ),
                              SizedBox(width: sized.size.width * 0.01),
                              Countup(
                                  begin: 0,
                                  end: 500,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  softWrap: false,
                                  duration: const Duration(milliseconds: 500),
                                  separator: ',',
                                  style: theme.textTheme.headline3?.copyWith(
                                      fontStyle: FontStyle.italic,
                                      fontFamily: 'BebasNeue',
                                      // fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: sized.size.height * 0.02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Coin transfer code',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontStyle: FontStyle.italic),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(width: sized.size.width * 0.01),
                              InkWell(
                                onTap: () {
                                  Clipboard.setData(
                                          ClipboardData(text: box.read("code")))
                                      .then((_) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content:
                                                Text("Receiver code copied")));
                                  });
                                },
                                child: Text(
                                  box.read("code"),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: sized.size.height * 0.02),
                Divider(
                  // thickness: 1,
                  color: Colors.white,
                ),
                SizedBox(height: sized.size.height * 0.02),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Colors.red.withOpacity(.7))),
                        onPressed: () {
                          AppNavigator().push(context, TransferScreen());
                        },
                        child: Text(
                          'Transfer Coins',
                          style: theme.textTheme.titleLarge?.copyWith(
                              fontFamily: 'BebasNeue', color: Colors.white),
                        )),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Colors.red.withOpacity(.7))),
                        onPressed: () {
                          logout(context);
                        },
                        child: Text(
                          'Log out',
                          style: theme.textTheme.titleLarge?.copyWith(
                              fontFamily: 'BebasNeue', color: Colors.white),
                        )),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
