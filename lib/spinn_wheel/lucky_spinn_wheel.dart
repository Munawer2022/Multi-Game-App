import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:flutter_spinning_wheel/flutter_spinning_wheel.dart';
import 'package:get_storage/get_storage.dart';
import 'package:neopop/widgets/buttons/neopop_button/neopop_button.dart';
import 'package:neopop/widgets/shimmer/neopop_shimmer.dart';
import 'package:rxdart/rxdart.dart';

import '../utils.dart';

class LuckySpinnWheel extends StatefulWidget {
  const LuckySpinnWheel({super.key});

  @override
  State<LuckySpinnWheel> createState() => _LuckySpinnWheelState();
}

class _LuckySpinnWheelState extends State<LuckySpinnWheel> {
  final StreamController _dividerController = StreamController<int>();

  final _wheelNotifier = StreamController<double>();

  // int _lastWinNumber = 1;
  // @override
  // void initState() {
  //   super.initState();
  //   _dividerController.stream.listen((selected) {
  //     setState(() {
  //       _lastWinNumber = selected;
  //     });
  //   });
  // }

  ///////////////////////
  bool isWheelSpinning = false; // Track the spinning state of the wheel

  // Function to start spinning the wheel
  void startSpinning() {
    setState(() {
      isWheelSpinning = true;
    });

    // Simulate wheel spinning delay
    Future.delayed(Duration(seconds: 5), () {
      // Stop the wheel spinning
      stopSpinning();
    });
  }

  // Function to stop spinning the wheel
  void stopSpinning() {
    setState(() {
      isWheelSpinning = false;
    });
  }

  @override
  dispose() {
    super.dispose();
    _dividerController.close();
    _wheelNotifier.close();
    //
    selected.close();
    super.dispose();
  }

  final selected = BehaviorSubject<int>();
  dynamic rewards = 0;
  bool play = false;
  void _showAlertDialog(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text('🥳 Congratulation'),
          content: Text("You just won $rewards Coins!."),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text('Back'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            CupertinoDialogAction(
              child: Text('Retry?'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

////api
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
    return SafeArea(
      child: Scaffold(
          body: Stack(children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          foregroundDecoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.red.shade200,
                Colors.transparent,
                // Colors.transparent,
                // Colors.black
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0, 0.5],
            ),
          ),
          child: Image.asset(
            'assets/images/wheel_back.jpg',
            height: 1200,
            width: 1200,
            fit: BoxFit.cover,
            opacity: const AlwaysStoppedAnimation(.7),
          ),
        ),
        SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
                      //please add this end point coin api
                    ],
                  ),
                ),
                SizedBox(height: sized.size.height * 0.03),
                Text(
                  'Lucky Spinn',
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      fontStyle: FontStyle.italic,
                      color: const Color(0xffFFF893),
                      fontWeight: FontWeight.w900),
                ),
                Center(
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      Center(
                        child: Image.asset(
                          'assets/images/wheel_back_light.png',
                          height: 450,
                          width: 450,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Center(
                        child: Stack(
                          alignment: AlignmentDirectional.center,
                          children: [
                            Column(
                              children: [
                                //  rewards = labels[selected.value];
                                SpinningWheel(
                                  Image.asset(
                                    'assets/images/wheel_new.png',
                                  ),
                                  width: 310,
                                  height: 310,
                                  initialSpinAngle: _generateRandomAngle(),
                                  spinResistance: 0.1,
                                  canInteractWhileSpinning: false,
                                  dividers: 16,
                                  onUpdate: _dividerController.add,
                                  onEnd: _dividerController.add,
                                  secondaryImage: Image.asset(
                                      'assets/images/wheel_click.png'),
                                  secondaryImageHeight: 110,
                                  secondaryImageWidth: 110,
                                  shouldStartOrStop: _wheelNotifier.stream,
                                ),
                                const SizedBox(height: 10),
                                StreamBuilder(
                                  stream: _dividerController.stream,
                                  builder: (context, snapshot) =>
                                      snapshot.hasData
                                          ? RouletteScore(
                                              snapshot.data,
                                            )
                                          : Container(),
                                ),
                                const SizedBox(height: 10),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                isWheelSpinning
                    ? Container()
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: NeoPopButton(
                          color: Colors.red,
                          onTapUp: isWheelSpinning
                              ? null
                              : () {
                                  _wheelNotifier.sink
                                      .add(_generateRandomVelocity());
                                  // setState(() {
                                  //   selected.add(
                                  //     snapshot.data,
                                  //   );
                                  // });
                                  HapticFeedback.vibrate();
                                  startSpinning();
                                },
                          onTapDown: () => HapticFeedback.vibrate(),
                          child: NeoPopShimmer(
                            shimmerColor: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "SPIN",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                SizedBox(
                  height: sized.size.height * .01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'One spin in just ',
                      style: Theme.of(context).textTheme.headline5?.copyWith(
                          color: const Color(0xffFFF893),
                          fontStyle: FontStyle.italic),
                    ),
                    Image.asset(
                      'assets/images/coin.png',
                      scale: 20,
                    ),
                    Text(
                      '25',
                      style: Theme.of(context).textTheme.headline5?.copyWith(
                          color: const Color(0xffFFF893),
                          fontWeight: FontWeight.w900,
                          fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        AnimatedPositioned(
          curve: Curves.easeInOut,
          top: 0,
          left: 0,
          right: 50,
          bottom: play ? 600 : 0,
          duration: Duration(milliseconds: 500),
          child: Center(
              child: Opacity(
            opacity: play ? 1.0 : 0.0,
            child: Text('+',
                style: theme.textTheme.headline2?.copyWith(
                    fontFamily: 'BebasNeue',
                    // fontStyle: FontStyle.italic,r
                    // fontWeight: FontWeight.bold,
                    color: Colors.white)),
          )),
        )
      ])),
    );
  }

  double _generateRandomVelocity() => (Random().nextDouble() * 6000) + 2000;

  double _generateRandomAngle() => Random().nextDouble() * pi * 2;
}

class RouletteScore extends StatelessWidget {
  final int selected;

  RouletteScore(this.selected, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text('${labels[selected]}',
        style: const TextStyle(
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.bold,
          fontSize: 36.0,
          color: Color(0xffFFF893),
        ));
  }
}

final Map<int, String> labels = {
  1: 'Loss',
  2: '5',
  3: 'Loss',
  4: '2x',
  5: 'Loss',
  6: '10',
  7: 'Loss',
  8: '5',
  9: 'Loss',
  10: '10',
  11: 'Loss',
  12: '2x',
  13: 'Loss',
  14: '5',
  15: 'Loss',
  16: '10',
};
