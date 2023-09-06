import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';

import '../navigate.dart';
import 'detail_screen.dart';
import 'package:http/http.dart' as http;

class HorseRaceScreen extends StatefulWidget {
  String winnerHorse;
  HorseRaceScreen({required this.winnerHorse, super.key});

  @override
  _HorseRaceScreenState createState() => _HorseRaceScreenState();
}

final mywidgetkey = GlobalKey();
final key1 = GlobalKey(),
    key2 = GlobalKey(),
    key3 = GlobalKey(),
    key4 = GlobalKey(),
    key5 = GlobalKey(),
    key6 = GlobalKey(),
    key7 = GlobalKey(),
    key8 = GlobalKey(),
    key9 = GlobalKey();
Timer? timer;
double? height;

class _HorseRaceScreenState extends State<HorseRaceScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  double horse1Position = 0.0;
  double horse2Position = 0.0;
  double horse3Position = 0.0;
  double horse4Position = 0.0;
  double horse5Position = 0.0;
  double horse6Position = 0.0;
  double horse7Position = 0.0;
  double horse8Position = 0.0;
  double horse9Position = 0.0;

  bool isRaceInProgress = false;
  late int random1;
  late int random2;
  late int random3;
  late int random4;
  late int random5;
  late int random6;
  late int random7;
  late int random8;
  late int random9;

  final box = GetStorage();

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);

    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 30));

    _animationController.addListener(() {
      setState(() {
        horse1Position = _animationController.value * random1;
        horse2Position = _animationController.value * random2;
        horse3Position = _animationController.value * random3;
        horse4Position = _animationController.value * random4;
        horse5Position = _animationController.value * random5;
        horse6Position = _animationController.value * random6;
        horse7Position = _animationController.value * random7;
        horse8Position = _animationController.value * random8;
        horse9Position = _animationController.value * random9;
      });
    });
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        isRaceInProgress = false;
        // AppNavigator().push(context, const DetailScreen());
      }
    });

    Future.delayed(Duration(seconds: 2), () {
      _startRace();
    });
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) => checkPosition());

    winOrLoss();
  }

  void winOrLoss() {
    print(widget.winnerHorse);
    print(box.read('hourseNo'));
    if (box.read('hourseNo').toString() != "0") {
      if (widget.winnerHorse == box.read('hourseNo').toString()) {
        transfer('8jR0XG', box.read('code'), '3', box.read('biddingAmount'));
      } else {
        transfer(box.read('code'), '8jR0XG', '2', box.read('biddingAmount'));
      }
    } else {
      print("no bid");
    }
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

  void checkPosition() {
    RenderBox renderbox =
        mywidgetkey.currentContext!.findRenderObject() as RenderBox;
    Offset position = renderbox.localToGlobal(Offset.zero);
    double x = position.dx;
    double y = position.dy;
    print(height);
    print("position" + x.toString());
    if (x >= height! - 100) {
      print("matched");
      timer?.cancel;
      AppNavigator()
          .push(context, DetailScreen(winnerHorse: widget.winnerHorse));
    }
  }

  void _startRace() {
    if (!isRaceInProgress) {
      setState(() {
        if (widget.winnerHorse == "1") {
          print("Winner is 1");
          random1 = Random().nextInt(801) + 800;
          ;
        } else {
          random1 = Random().nextInt(500) + 300;
        }
        if (widget.winnerHorse == "2") {
          print("Winner is 2");
          random2 = Random().nextInt(801) + 800;
        } else {
          random2 = Random().nextInt(500) + 300;
        }
        if (widget.winnerHorse == "3") {
          print("Winner is 3");
          random3 = Random().nextInt(801) + 800;
        } else {
          random3 = Random().nextInt(500) + 300;
        }
        if (widget.winnerHorse == "4") {
          print("Winner is 4");
          random4 = Random().nextInt(801) + 800;
        } else {
          random4 = Random().nextInt(500) + 300;
        }
        if (widget.winnerHorse == "5") {
          print("Winner is 5");
          random5 = Random().nextInt(801) + 800;
          print(random5);
        } else {
          random5 = Random().nextInt(500) + 300;
        }
        if (widget.winnerHorse == "6") {
          print("Winner is 6");
          random6 = Random().nextInt(801) + 800;
        } else {
          random6 = Random().nextInt(500) + 300;
        }
        if (widget.winnerHorse == "7") {
          print("Winner is 7");
          random7 = Random().nextInt(801) + 800;
          ;
        } else {
          random7 = Random().nextInt(500) + 300;
        }
        if (widget.winnerHorse == "8") {
          print("Winner is 8");
          random8 = Random().nextInt(801) + 800;
          ;
        } else {
          random8 = Random().nextInt(500) + 300;
        }
        if (widget.winnerHorse == "9") {
          print("Winner is 9");
          random9 = Random().nextInt(801) + 800;
        } else {
          random9 = Random().nextInt(500) + 300;
        }

        // random1 = Random().nextInt(500) + 300;
        // random2 = Random().nextInt(500) + 300;
        // random3 = Random().nextInt(500) + 300;
        // random4 = Random().nextInt(500) + 300;
        // random5 = Random().nextInt(500) + 300;
        // random6 = Random().nextInt(500) + 300;
        // random7 = Random().nextInt(500) + 300;
        // random8 = Random().nextInt(500) + 300;
        // random9 = Random().nextInt(500) + 300;

        isRaceInProgress = true;
        horse1Position = 0.0;
        horse2Position = 0.0;
        horse3Position = 0.0;
        horse3Position = 0.0;
        horse4Position = 0.0;
        horse5Position = 0.0;
        horse6Position = 0.0;
        horse7Position = 0.0;
        horse8Position = 0.0;
        horse9Position = 0.0;
      });
      _animationController.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            RaceTrack(
              horse1Position: horse1Position,
              horse2Position: horse2Position,
              horse3Position: horse3Position,
              horse4Position: horse4Position,
              horse5Position: horse5Position,
              horse6Position: horse6Position,
              horse7Position: horse7Position,
              horse8Position: horse8Position,
              horse9Position: horse9Position,
              winnerHorse: widget.winnerHorse,
            ),
            // Center(
            //   child: ElevatedButton(
            //     style: ButtonStyle(
            //         backgroundColor: MaterialStateProperty.all(
            //             Theme.of(context).primaryColor)),
            //     onPressed: _startRace,
            //     child: const Text(
            //       ' Start Race',
            //       style: TextStyle(color: Colors.white),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

class RaceTrack extends StatelessWidget {
  final double horse1Position;
  final double horse2Position;
  final double horse3Position;
  final double horse4Position;
  final double horse5Position;
  final double horse6Position;
  final double horse7Position;
  final double horse8Position;
  final double horse9Position;
  final String winnerHorse;

  RaceTrack(
      {required this.horse1Position,
      required this.horse2Position,
      required this.horse3Position,
      required this.horse4Position,
      required this.horse5Position,
      required this.horse6Position,
      required this.horse7Position,
      required this.horse8Position,
      required this.horse9Position,
      required this.winnerHorse});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/images/track.jpg',
          // height: 1200,
          width: double.infinity,
          fit: BoxFit.fill,
        ),
        position(horse1Position, 5, '1', mywidgetkey, key1, winnerHorse),
        position(horse2Position, 20, '2', mywidgetkey, key2, winnerHorse),
        position(horse3Position, 50, '3', mywidgetkey, key3, winnerHorse),
        position(horse4Position, 80, '4', mywidgetkey, key4, winnerHorse),
        position(horse5Position, 150, '5', mywidgetkey, key5, winnerHorse),
        position(horse6Position, 150, '6', mywidgetkey, key6, winnerHorse),
        position(horse7Position, 180, '7', mywidgetkey, key7, winnerHorse),
        position(horse8Position, 210, '8', mywidgetkey, key8, winnerHorse),
        position(horse9Position, 240, '9', mywidgetkey, key9, winnerHorse),
      ],
    );
  }
}

class Horse extends StatelessWidget {
  const Horse({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      height: 50,
      child: Image.asset('assets/images/horse.gif'), // Add your horse image
    );
  }
}

Widget position(horse3Position, double top, text, GlobalKey mywidgetkey,
    GlobalKey keyX, String winnerHorse) {
  return Positioned(
    key: text == winnerHorse ? mywidgetkey : keyX,
    top: top,
    left: horse3Position,
    child: Column(
      children: [
        CircleAvatar(
          backgroundColor: Colors.brown.shade600,
          radius: 15,
          child: Center(
              child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Text(
              text,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          )),
        ),
        SizedBox(
            height: 12,
            child: VerticalDivider(
              color: Colors.brown.shade600,
              thickness: 2,
            )),
        const Horse(),
      ],
    ),
  );
}
