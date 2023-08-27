import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:animation/dashboard.dart';
import 'package:animation/ticket_button/ticket_ui_screen.dart';
import 'package:animation/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:neopop/utils/color_utils.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../navigate.dart';

class HorseBid extends StatefulWidget {
  String hour, ampm;
  HorseBid({required this.hour, required this.ampm, super.key});

  @override
  State<HorseBid> createState() => _HorseBidState();
}

class _HorseBidState extends State<HorseBid> {
  final box = GetStorage();

  int hours = 1;
  int minutes = 60;
  int seconds = 0;
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
  }

  @override
  void initState() {
    super.initState();
    checkBalance();
    // startTimer();
  }

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   super.dispose();
  //   startTimer();
  // }

  void startTimer() {
    // Run the timer every second
    Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {
        if (seconds == 0) {
          // If seconds reach 0, decrement minutes and set seconds to 59
          if (minutes == 0) {
            // If minutes reach 0, decrement hours and set minutes and seconds to 59
            if (hours == 0) {
              // Timer is finished, you can handle it accordingly
              timer.cancel();
            } else {
              hours--;
              minutes = 59;
              seconds = 59;
            }
          } else {
            minutes--;
            seconds = 59;
          }
        } else {
          seconds--;
        }
      });
    });
  }

  String bidText = "Minimum Bid";
  String selectedAmount = "500", selectedHorse = "1";

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var sized = MediaQuery.of(context);

    List<String> options = [
      "500",
      "1000",
      "1500",
      "2000",
      "2500",
      "3000",
      "3500",
      '4000',
      '4500',
      '5000',
    ];
    List<String> horseNumber = [
      "1",
      "2",
      "3",
      "4",
      "5",
      "6",
      "7",
      '8',
      '9',
    ];

    // List<bool> isSelected = List.generate(options.length, (_) => false);

    return Scaffold(
        body: NestedScrollView(
            floatHeaderSlivers: true,
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  leading: IconButton(
                      onPressed: () {
                        AppNavigator().push(context, const Dahboard());
                      },
                      icon: const Icon(
                        CupertinoIcons.back,
                        color: Colors.white,
                      )),

                  automaticallyImplyLeading: false,
                  flexibleSpace: Stack(
                    children: [
                      Image.asset(
                        'assets/images/horse_bid_back.jpg',
                        height: double.infinity,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Text('$hours:$minutes:$seconds',
                            //     style: theme.textTheme.displayLarge?.copyWith(
                            //         fontWeight: FontWeight.bold,
                            //         color: Colors.white)),
                            Text(widget.hour + ":00 " + widget.ampm,
                                style: theme.textTheme.displayLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                            Text('Race Starts',
                                style: theme.textTheme.headline6?.copyWith(
                                  color: Colors.white,
                                ))
                          ],
                        ),
                      ),
                    ],
                  ),
                  // title: const Text('NestedScrollView'),
                  pinned: false,
                  expandedHeight: sized.size.height * 0.6,
                  //400
                  forceElevated: innerBoxIsScrolled,
                ),
              ];
            },
            body:
                Consumer<HorseBidController>(builder: (context, value, child) {
              return SingleChildScrollView(
                child: Column(children: [
                  SizedBox(height: sized.size.height * 0.01),
                  Center(
                    child: Container(
                      height: 5,
                      width: 40,
                      decoration: BoxDecoration(
                          color: theme.primaryColor.withOpacity(.5),
                          borderRadius: BorderRadius.circular(80)),
                    ),
                  ),
                  SizedBox(height: sized.size.height * 0.03),
                  Padding(
                    padding: bidHorsePadding,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text('Race name',
                              style: theme.textTheme.titleMedium),
                        ),
                        Text(bidText, style: theme.textTheme.titleMedium),
                      ],
                    ),
                  ),
                  Padding(
                    padding: bidHorsePadding,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text('Wednesday Horse',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              softWrap: false,
                              style: theme.textTheme.headline4?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: theme.primaryColor.withOpacity(0.7))
                              // ?.copyWith(color: Colors.black87),
                              ),
                        ),
                        SizedBox(width: sized.size.width * 0.03),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/coin.png',
                              scale: 22,
                            ),
                            SizedBox(width: sized.size.width * 0.01),
                            Text(options[value._value],
                                style: theme.textTheme.headline4?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color:
                                        theme.primaryColor.withOpacity(0.7))),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: sized.size.height * 0.03),
                  Text('Select your lucky horse number',
                      style: theme.textTheme.bodyLarge),
                  SizedBox(height: sized.size.height * 0.02),
                  SizedBox(
                      width: double.infinity,
                      height: sized.size.height * 0.05,
                      //40,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: horseNumber.length,
                          itemBuilder: (context, index) {
                            return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: ChoiceChip(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.horizontal(
                                          left: Radius.circular(20),
                                          right: Radius.circular(20))),
                                  label: Row(
                                    children: [
                                      Image.asset(
                                        'assets/images/horse_num.png',
                                        color: theme.primaryColor,
                                        scale: 25,
                                      ),
                                      SizedBox(width: sized.size.width * 0.01),
                                      Text(horseNumber[index],
                                          style: theme.textTheme.subtitle2
                                              ?.copyWith(
                                            fontStyle: FontStyle.italic,
                                          )),
                                    ],
                                  ),
                                  selected: value.value2 == index,
                                  onSelected: (bool selected) {
                                    value.changeTabIndex2(index);
                                    selectedHorse = (index + 1).toString();

                                    // selectedDate = date[value.value].toString();
                                  },
                                ));
                          })),
                  SizedBox(height: sized.size.height * 0.03),
                  Text('Select your bid', style: theme.textTheme.bodyLarge),
                  SizedBox(height: sized.size.height * 0.02),
                  SizedBox(
                      width: double.infinity,
                      height: sized.size.height * 0.05,
                      //40,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: options.length,
                          itemBuilder: (context, index) {
                            return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: ChoiceChip(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.horizontal(
                                          left: Radius.circular(20),
                                          right: Radius.circular(20))),
                                  label: Row(
                                    children: [
                                      Image.asset(
                                        'assets/images/coin.png',
                                        scale: 25,
                                      ),
                                      SizedBox(width: sized.size.width * 0.01),
                                      Text(options[index],
                                          style: theme.textTheme.subtitle2
                                              ?.copyWith(
                                            fontStyle: FontStyle.italic,
                                          )),
                                    ],
                                  ),
                                  selected: value.value == index,
                                  onSelected: (bool selected) {
                                    value.changeTabIndex(index);
                                    selectedAmount = options[index].toString();
                                    bidText = "Your bid";
                                    setState(() {});
                                    // selectedDate = date[value.value].toString();
                                  },
                                ));
                          })),
                  SizedBox(height: sized.size.height * 0.04),
                  // Padding(
                  //   padding: bidHorsePadding,
                  //   child: TicketWidget(
                  //     color: Colors.grey.shade300.withOpacity(.7),
                  //     width: double.infinity,
                  //     height: sized.size.height * 0.2,
                  //     isCornerRounded: true,
                  //     padding: const EdgeInsets.all(20),
                  //     child: Column(
                  //       children: [
                  //         Text('Ticket',
                  //             overflow: TextOverflow.ellipsis,
                  //             maxLines: 2,
                  //             softWrap: false,
                  //             style: theme.textTheme.headline4?.copyWith(
                  //                 fontWeight: FontWeight.bold,
                  //                 color: theme.primaryColor.withOpacity(0.7))
                  //             // ?.copyWith(color: Colors.black87),
                  //             ),
                  //       ],
                  //     ),
                  //     // child: const TicketData(),
                  //   ),
                  // ),
                  SizedBox(height: sized.size.height * 0.04),
                  Padding(
                    padding: bidHorsePadding,
                    child: SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(25.0),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.4),
                              spreadRadius: 2,
                              blurRadius: 10.0,
                              offset: const Offset(0, 7),
                            ),
                          ],
                        ),
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  theme.primaryColor.withOpacity(0.7))),
                          onPressed: () {
                            print(selectedAmount);
                            if (availableCoins < int.parse(selectedAmount)) {
                              errorsnackBar(
                                  "You have insufficient coins", context);
                            } else {
                              box.write('myHorse', selectedHorse);
                              box.write('myAmount', selectedAmount);
                              box.write('myHour', widget.hour);
                              snackbar("Your bid initiated", context);
                            }
                          },
                          child: Center(
                            child: Text(
                              'Submit your Bid',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                    color: Colors.white,
                                  ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ]),
              );
            })));
  }
}

var bidHorsePadding = const EdgeInsets.symmetric(horizontal: 15);
Color bidHorseColor = Colors.brown.withOpacity(0.7);

class HorseBidController extends ChangeNotifier {
  int _value = 0;
  int get value => _value;

  changeTabIndex(
    dynamic index,
  ) {
    _value = index;
    notifyListeners();
  }

  int _value2 = 0;
  int get value2 => _value2;

  changeTabIndex2(
    dynamic index,
  ) {
    _value2 = index;
    notifyListeners();
  }
}
