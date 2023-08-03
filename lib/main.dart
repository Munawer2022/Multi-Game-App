import 'package:animation/horse/horse_bid.dart';
import 'package:animation/spinn_wheel/lucky_spinn_wheel.dart';
import 'package:animation/spinn_wheel/spinn_wheel_bid.dart';
import 'package:animation/spinn_wheel/wheel_game.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'auth/login.dart';
import 'auth/register.dart';
import 'dashboard.dart';
import 'dog_race/dog_race_bid.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => HorseBidController()),
    ChangeNotifierProvider(create: (_) => SpinnWheelBidController()),
    ChangeNotifierProvider(create: (_) => DogRaceBidController()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
        home: RegisterScreen());
  }
}
