import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:neopop/utils/color_utils.dart';

class HorseBid extends StatefulWidget {
  const HorseBid({super.key});

  @override
  State<HorseBid> createState() => _HorseBidState();
}

class _HorseBidState extends State<HorseBid> {
  Timer? countdownTimer;
  Duration myDuration = Duration(days: 1);

  /// Timer related methods ///
  // Step 3
  void startTimer() {
    countdownTimer =
        Timer.periodic(Duration(seconds: 1), (_) => setCountDown());
  }

  // Step 6
  void setCountDown() {
    final reduceSecondsBy = 1;
    setState(() {
      final seconds = myDuration.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        countdownTimer!.cancel();
      } else {
        myDuration = Duration(seconds: seconds);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    setCountDown();
    setCountDown();
  }

  @override
  Widget build(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final days = strDigits(myDuration.inDays);
    // Step 7
    final hours = strDigits(myDuration.inHours.remainder(24));
    final minutes = strDigits(myDuration.inMinutes.remainder(60));
    final seconds = strDigits(myDuration.inSeconds.remainder(60));

    var theme = Theme.of(context);
    var sized = MediaQuery.of(context);

    List<String> options = [
      "20",
      "30",
      "40",
      "50",
      "60",
      "70",
      "80",

      // Add more options here...
    ];
    List<bool> isSelected = List.generate(options.length, (_) => false);

    return Scaffold(
        body: NestedScrollView(
            floatHeaderSlivers: true,
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  leading: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
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
                            Text('$hours:$minutes:$seconds',
                                style: theme.textTheme.displayLarge
                                    ?.copyWith(color: Colors.white)),
                            Text('Betting Starts',
                                style: theme.textTheme.headline6
                                    ?.copyWith(color: Colors.white))
                          ],
                        ),
                      ),
                    ],
                  ),
                  // title: const Text('NestedScrollView'),
                  pinned: false,
                  expandedHeight: 400.0,
                  forceElevated: innerBoxIsScrolled,
                ),
              ];
            },
            body: Padding(
              padding: const EdgeInsets.only(top: 10, right: 20, left: 20),
              child: Column(children: [
                Center(
                  child: Container(
                    height: 5,
                    width: 40,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(80)),
                  ),
                ),
                SizedBox(height: sized.size.height * 0.03),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Expanded(
                      child: Text('Horse race name',
                          style:
                              TextStyle(fontFamily: 'Open Sans', fontSize: 16)),
                    ),
                    Text('Minimum bidding',
                        style:
                            TextStyle(fontFamily: 'Open Sans', fontSize: 16)),
                  ],
                ),
                // SizedBox(height: sized.size.height * 0.01),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text('Wednesday Horse',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          softWrap: false,
                          style: theme.textTheme.headline4?.copyWith(
                              fontFamily: 'Open Sans',
                              color: theme.primaryColor.withOpacity(0.7))
                          // ?.copyWith(color: Colors.black87),
                          ),
                    ),
                    SizedBox(width: sized.size.width * 0.03),
                    Row(
                      children: [
                        Card(
                            child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Image.asset(
                              'assets/images/coin.png',
                              scale: 22,
                            ),
                          ),
                        )),
                        SizedBox(width: sized.size.width * 0.01),
                        Text('500',
                            style: theme.textTheme.headline4?.copyWith(
                                fontFamily: 'Open Sans',
                                color: theme.primaryColor.withOpacity(0.7))),
                      ],
                    ),
                  ],
                ),
                // SizedBox(height: sized.size.height * 0.15),

                SizedBox(height: sized.size.height * 0.02),
                // Text('Hi, Harry',
                //     style: theme.textTheme.displaySmall
                //         ?.copyWith(fontFamily: 'Open Sans')),
                SizedBox(height: sized.size.height * 0.01),
                Text('Select your bid',
                    style: theme.textTheme.titleMedium
                        ?.copyWith(fontFamily: 'Open Sans', fontSize: 18)),
                SizedBox(height: sized.size.height * 0.02),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Wrap(
                    children: List.generate(options.length, (index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ChoiceChip(
                          label: Text(options[index]),
                          selected: isSelected[index],
                          onSelected: (selected) {
                            setState(() {
                              isSelected[index] = selected;
                            });
                          },
                          // Customize the appearance of the chip here (optional).
                          // You can use properties like backgroundColor, labelStyle, etc.
                        ),
                      );
                    }),
                  ),
                ),

                // Container(
                //   decoration: const ShapeDecoration(
                //     shape: RoundedRectangleBorder(
                //       side: BorderSide(width: 1.0, style: BorderStyle.solid),
                //       borderRadius: BorderRadius.all(Radius.circular(5.0)),
                //     ),
                //   ),
                //   child: Padding(
                //     padding: const EdgeInsets.symmetric(horizontal: 10),
                //     child: DropdownButton<String>(
                //       items: <String>['500', '1000', '5443', '453480']
                //           .map((String value) {
                //         return DropdownMenuItem<String>(
                //           value: value,
                //           child: Text(value),
                //         );
                //       }).toList(),
                //       hint: Text(
                //         selectedCategory.isEmpty
                //             ? 'Select coins'
                //             : selectedCategory,
                //         style: TextStyle(
                //           fontFamily: 'Open Sans',
                //         ),
                //       ),
                //       borderRadius: BorderRadius.circular(10),
                //       underline: SizedBox(),
                //       isExpanded: true,
                //       onChanged: (value) {
                //         if (value != null) {
                //           setState(() {
                //             selectedCategory = value;
                //           });
                //         }
                //       },
                //     ),
                //   ),
                // ),

                SizedBox(height: sized.size.height * 0.04),
                SizedBox(
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
                          offset: Offset(0, 7), // changes position of shadow
                        ),
                      ],
                    ),
                    child: ElevatedButton.icon(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              theme.primaryColor.withOpacity(0.7))),
                      onPressed: () {},
                      label: Text(
                        'Submit your Bid',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: Colors.white,
                              fontFamily: 'Open Sans',
                            ),
                      ),
                      icon: const Icon(
                        CupertinoIcons.projective,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ]),
            )));
  }

  String _formatTime(int time) {
    return time.toString().padLeft(2, '0');
  }
}

class Data {
  String label;
  Color color;

  Data(this.label, this.color);
}
