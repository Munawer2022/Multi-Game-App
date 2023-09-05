import 'package:animation/auth/login/login.dart';
import 'package:animation/auth/register/provider.dart';
import 'package:animation/horse/horse_bid.dart';
import 'package:animation/ludo/main_screen.dart';

import 'package:animation/spinn_wheel/lucky_spinn_wheel.dart';
import 'package:animation/spinn_wheel/spinn_wheel_bid.dart';
import 'package:animation/spinn_wheel/wheel_game.dart';
import 'package:animation/splash_screen.dart';
import 'package:animation/transfer/provider.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'auth/login/provider.dart';

import 'dashboard.dart';
import 'dice_game/dice_game_screen.dart';
import 'dog_race/dog_race_bid.dart';
import 'horse/detail_screen.dart';
import 'horse/horse_race.dart';
import 'ludo/ludo_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (_) => LudoProvider(),
    ),
    ChangeNotifierProvider(create: (_) => LoginProvider()),
    ChangeNotifierProvider(create: (_) => RegisterProvider()),
    ChangeNotifierProvider(create: (_) => HorseBidController()),
    // ChangeNotifierProvider(create: (_) => SpinnWheelBidController()),
    ChangeNotifierProvider(create: (_) => DogRaceBidController()),
    ChangeNotifierProvider(create: (_) => TransferProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _imagesPrecached = false;

  @override
  void didChangeDependencies() {
    if (!_imagesPrecached) {
      // Initialize images and precache them
      precacheImage(const AssetImage("assets/images/thankyou.gif"), context);
      precacheImage(const AssetImage("assets/images/board.png"), context);
      precacheImage(const AssetImage("assets/images/dice/1.png"), context);
      precacheImage(const AssetImage("assets/images/dice/2.png"), context);
      precacheImage(const AssetImage("assets/images/dice/3.png"), context);
      precacheImage(const AssetImage("assets/images/dice/4.png"), context);
      precacheImage(const AssetImage("assets/images/dice/5.png"), context);
      precacheImage(const AssetImage("assets/images/dice/6.png"), context);
      precacheImage(const AssetImage("assets/images/dice/draw.gif"), context);
      precacheImage(const AssetImage("assets/images/crown/1st.png"), context);
      precacheImage(const AssetImage("assets/images/crown/2nd.png"), context);
      precacheImage(const AssetImage("assets/images/crown/3rd.png"), context);
      // ... (precache other images)

      setState(() {
        _imagesPrecached = true;
      });
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.light,
        theme: ThemeData(
          fontFamily: 'Open Sans',
          brightness: Brightness.light,
          useMaterial3: true,
          colorSchemeSeed: Colors.brown.withOpacity(0.7),
          // textTheme: GoogleFonts.sacramentoTextTheme(
          //   Theme.of(context).textTheme,
          // ),
        ),
        home: Dahboard()
        //  HorseRaceScreen(
        //   winnerHorse: '7',
        // )
        );
  }
}
