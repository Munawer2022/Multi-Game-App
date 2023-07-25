import 'package:flutter/material.dart';

import 'dashboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.light,
        theme: ThemeData(
          fontFamily: 'BebasNeue',
          brightness: Brightness.light,
          useMaterial3: true,
          colorSchemeSeed: Colors.blueAccent.withOpacity(0.7),
          // textTheme: GoogleFonts.sacramentoTextTheme(
          //   Theme.of(context).textTheme,
          // ),
        ),
        home: const Dahboard());
  }
}
