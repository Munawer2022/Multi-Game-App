import 'package:animation/ludo/constants.dart';
import 'package:animation/ludo/widgets/board_widget.dart';
import 'package:animation/ludo/widgets/dice_widget.dart';
import 'package:countup/countup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'ludo_provider.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var sized = MediaQuery.of(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingWidth: 100,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   crossAxisAlignment: CrossAxisAlignment.center,
              //   children: [
              //     Image.asset(
              //       'assets/images/coin.png',
              //       scale: 15,
              //     ),
              //     SizedBox(width: sized.size.width * 0.01),
              //     Row(
              //       crossAxisAlignment: CrossAxisAlignment.end,
              //       children: [
              //         Countup(
              //             begin: 0,
              //             end: 100,
              //             overflow: TextOverflow.ellipsis,
              //             maxLines: 2,
              //             softWrap: false,
              //             duration: const Duration(milliseconds: 500),
              //             separator: ',',
              //             style: theme.textTheme.headline1?.copyWith(
              //                 fontFamily: 'BebasNeue',
              //                 // fontStyle: FontStyle.italic,
              //                 // fontWeight: FontWeight.bold,
              //                 color: Colors.white)),
              //         SizedBox(width: sized.size.width * 0.01),
              //         const Text(
              //           '/Available coin',
              //           style: TextStyle(
              //               color: Colors.white60,
              //               fontSize: 16,
              //               fontStyle: FontStyle.italic),
              //         ),
              //       ],
              //     ),
              //   ],
              // ),

              Row(
                children: [
                  Image.asset(
                    'assets/images/coin.png',
                    scale: 15,
                  ),
                  const SizedBox(width: 5),
                  const Text(
                    '2000',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w900),
                  ),
                ],
              ),
              const Text(
                'Winning Coins',
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w900),
              ),
            ],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Image.asset(
                      'assets/images/coin.png',
                      scale: 15,
                    ),
                    const SizedBox(width: 5),
                    const Text(
                      '2000',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w900),
                    ),
                  ],
                ),
                const Text(
                  'Your Coins',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w900),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Consumer<LudoProvider>(
          builder: (context, value, child) =>
              Stack(alignment: Alignment.center, children: [
                Image.asset(
                  'assets/images/back.jpg',
                  height: double.infinity,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Stack(
                  children: [
                    // BoardWidget().turnIndicator(
                    //     context,
                    //     value.currentPlayer.type,
                    //     value.currentPlayer.color,
                    //     value.gameState
                    //     ),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        // mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: sized.size.height * 0.08),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                rightUser(
                                    Alignment.centerLeft,
                                    value.currentPlayer.color == LudoColor.green
                                        ? DiceWidget()
                                        : null),
                                leftUser(
                                    Alignment.centerRight,
                                    value.currentPlayer.color ==
                                            LudoColor.yellow
                                        ? DiceWidget()
                                        : null),
                              ],
                            ),
                          ),
                          const BoardWidget(),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                rightUser(
                                    Alignment.centerLeft,
                                    value.currentPlayer.color == LudoColor.red
                                        ? DiceWidget()
                                        : null),
                                leftUser(
                                    Alignment.centerRight,
                                    value.currentPlayer.color == LudoColor.blue
                                        ? DiceWidget()
                                        : null),
                              ],
                            ),
                          ),
                          // Center(
                          //     child: SizedBox(
                          //   width: 60,
                          //   height: 60,
                          //   child: DiceWidget(),
                          // )),
                          Consumer<LudoProvider>(
                            builder: (context, value, child) => value
                                        .winners.length ==
                                    3
                                ? Container(
                                    color: Colors.black.withOpacity(0.8),
                                    child: Center(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Image.asset(
                                              "assets/images/thankyou.gif"),
                                          const Text("Thank you for playing 😙",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20),
                                              textAlign: TextAlign.center),
                                          Text(
                                              "The Winners is: ${value.winners.map((e) => e.name.toUpperCase()).join(", ")}",
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 30),
                                              textAlign: TextAlign.center),
                                          const Divider(color: Colors.white),
                                          const SizedBox(height: 20),
                                          const Text(
                                              "Refresh your browser to play again",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10),
                                              textAlign: TextAlign.center),
                                        ],
                                      ),
                                    ),
                                  )
                                : const SizedBox.shrink(),
                          )
                        ]),
                  ],
                )
              ])),
    );
  }

  Widget rightUser(alignment, widget) {
    return Builder(builder: (context) {
      return Align(
        alignment: alignment,
        child: Row(
          children: [
            Column(
              // alignment: Alignment.bottomCenter,
              children: [
                const CircleAvatar(
                  radius: 33,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white,
                      backgroundImage:
                          AssetImage('assets/images/face_first.jpg')
                      // child: Icon(
                      //   Icons.person,
                      //   color: Colors.black87,
                      // ),
                      ),
                ),
                // Card(
                //     child: Padding(
                //   padding: const EdgeInsets.all(2.0),
                //   child: Row(
                //     children: [
                //       Image.asset(
                //         'assets/images/coin.png',
                //         scale: 30,
                //       ),
                //       Text(
                //         '1234',
                //         // style: TextStyle(fontSize: 11),
                //       ),
                //     ],
                //   ),
                // )),
                const SizedBox(height: 5),
                const Text(
                  'Ifham',
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
            const SizedBox(width: 20),
            SizedBox(
              width: 50,
              height: 50,
              child: widget,
            ),
          ],
        ),
      );
    });
  }

  Widget leftUser(alignment, widget) {
    return Builder(builder: (context) {
      return Align(
        alignment: alignment,
        child: Row(
          children: [
            SizedBox(
              width: 50,
              height: 50,
              child: widget,
            ),
            const SizedBox(width: 20),
            Column(
              // alignment: Alignment.bottomCenter,
              children: [
                const CircleAvatar(
                  radius: 33,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white,
                      backgroundImage:
                          AssetImage('assets/images/face_first.jpg')
                      // child: Icon(
                      //   Icons.person,
                      //   color: Colors.black87,
                      // ),
                      ),
                ),
                // Card(
                //     child: Padding(
                //   padding: const EdgeInsets.all(2.0),
                //   child: Row(
                //     children: [
                //       Image.asset(
                //         'assets/images/coin.png',
                //         scale: 30,
                //       ),
                //       Text(
                //         '1234',
                //         // style: TextStyle(fontSize: 11),
                //       ),
                //     ],
                //   ),
                // )),
                const SizedBox(height: 5),
                const Text(
                  'Ifham',
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
          ],
        ),
      );
    });
  }
}
