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
  String hour, ampm, raceId, time;
  HorseBid(
      {required this.hour,
      required this.ampm,
      required this.raceId,
      required this.time,
      super.key});

  @override
  State<HorseBid> createState() => _HorseBidState();
}

class _HorseBidState extends State<HorseBid> {
  final box = GetStorage();

  int hours = 1;
  int minutes = 60;
  int seconds = 0;
  int availableCoins = 0;
  bool isBidInitiated = false;
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

  void storeBid() async {
    var url = Uri.parse(
        "https://cybermaxuk.com/gamezone/game_backend/public/api/bids");

    var response = await http.post(url,
        body: jsonEncode({
          'horse_no': selectedHorse,
          'user_id': box.read('id'),
          'amount': selectedAmount.toString(),
          'race_id': widget.raceId,
        }),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.acceptHeader: "application/json"
        });
    // print(json.decode(response.body));
    // if (response.statusCode == 200) {
    //   var responseData = json.decode(response.body);

    // }
    transfer(box.read('code'), '8jR0XG', '5', selectedAmount.toString());
    box.write('hourseNo', selectedHorse);
    box.write('biddingAmount', selectedAmount);
    box.write('bidInitiated', true);
    snackbar("Bid initiated", context);
    isBidInitiated = true;

    setState(() {});

    // Navigator.push(
    //     context, MaterialPageRoute(builder: (context) => dashboard(id: 1)));
  }

  void transfer(String from, String to, String type, String coins) async {
    var url = Uri.parse(
        "https://cybermaxuk.com/gamezone/game_backend/public/api/available_coins");

    var response = await http.post(url,
        body: jsonEncode({
          'from_user_code': from.toString(),
          'to_user_code': to.toString(),
          'coin_type': type,
          'coins': coins.toString(),
        }),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.acceptHeader: "application/json"
        });
    // print(json.decode(response.body));
    // if (response.statusCode == 200) {
    //   var responseData = json.decode(response.body);

    // }

    // Navigator.push(
    //     context, MaterialPageRoute(builder: (context) => dashboard(id: 1)));
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
  String selectedAmount = "50", selectedHorse = "1";

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var sized = MediaQuery.of(context);
    List<String> bid = [
      "2x bet",
      "3x bet",
    ];

    List<String> options = [
      "50",
      "100",
      "250",
      "500",
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
      floatingActionButton: Visibility(
        visible: box.read('bidInitiated'),
        child: FloatingActionButton.extended(
          label: Text("Your selected horse: " +
              box.read('hourseNo') +
              " and bidding amount: " +
              box.read('biddingAmount') +
              " coins"),
          onPressed: () {},
        ),
      ),
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
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
                        Text(widget.time,
                            style: theme.textTheme.displayLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                        Text('Race Starts',
                            style: theme.textTheme.headline6?.copyWith(
                              color: Colors.white,
                            )),
                        Text('Last Race Winner Horse No ',
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
        body: Consumer<HorseBidController>(builder: (context, value, child) {
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
                      child:
                          Text('Race name', style: theme.textTheme.titleMedium),
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
                        Text(selectedAmount.toString(),
                            style: theme.textTheme.headline4?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: theme.primaryColor.withOpacity(0.7))),
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
                            padding: const EdgeInsets.symmetric(horizontal: 10),
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
                                      style:
                                          theme.textTheme.subtitle2?.copyWith(
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
                            padding: const EdgeInsets.symmetric(horizontal: 10),
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
                                      style:
                                          theme.textTheme.subtitle2?.copyWith(
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
              SizedBox(height: sized.size.height * 0.02),
              // SizedBox(
              //     width: double.infinity,
              //     height: sized.size.height * 0.05,
              //     //40,
              //     child: ListView.builder(
              //         scrollDirection: Axis.horizontal,
              //         itemCount: bid.length,
              //         itemBuilder: (context, index) {
              //           return Padding(
              //               padding:
              //                   const EdgeInsets.symmetric(horizontal: 10),
              //               child: ChoiceChip(
              //                 shape: const RoundedRectangleBorder(
              //                     borderRadius: BorderRadius.horizontal(
              //                         left: Radius.circular(20),
              //                         right: Radius.circular(20))),
              //                 label: Row(
              //                   children: [
              //                     // Icon(Icons.one_x_mobiledata),
              //                     // SizedBox(width: sized.size.width * 0.01),
              //                     Text(bid[index],
              //                         style: theme.textTheme.subtitle2
              //                             ?.copyWith(
              //                           fontStyle: FontStyle.italic,
              //                         )),
              //                   ],
              //                 ),
              //                 selected: value.value3 == index,
              //                 onSelected: (bool selected) {
              //                   value.changeTabIndex3(index);
              //                   // selectedAmount = options[index].toString();
              //                   // bidText = "Your bid";
              //                   setState(() {});
              //                   // selectedDate = date[value.value].toString();
              //                 },
              //               ));
              //         })),

              SizedBox(height: sized.size.height * 0.04),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: MaterialButton(
                        minWidth: double.infinity,
                        height: 35,
                        color: Color(0xFF8CD14E),
                        disabledColor: Colors.grey,
                        onPressed: () {
                          selectedAmount =
                              (int.parse(selectedAmount) * 2).toString();

                          setState(() {});
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: const Text(
                          "2X",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: MaterialButton(
                        minWidth: double.infinity,
                        height: 35,
                        color: Color(0xFF8CD14E),
                        disabledColor: Colors.grey,
                        onPressed: () {
                          selectedAmount =
                              (int.parse(selectedAmount) * 3).toString();

                          setState(() {});
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: const Text(
                          "3X",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

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
              Visibility(
                visible: !box.read('bidInitiated'),
                child: Padding(
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
                            // box.write('myHorse', selectedHorse);
                            // box.write('myAmount', selectedAmount);
                            // box.write('myHour', widget.hour);
                            storeBid();
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
              ),
            ]),
          );
        }),
      ),
    );
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

  int _value3 = 0;
  int get value3 => _value3;

  changeTabIndex3(
    dynamic index,
  ) {
    _value3 = index;
    notifyListeners();
  }
}
