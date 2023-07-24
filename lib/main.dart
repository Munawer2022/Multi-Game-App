import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'dashboard.dart';
import 'hourse_running.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.dark,
        theme: ThemeData(
          brightness: Brightness.dark,
          useMaterial3: true,
          primarySwatch: Colors.deepPurple,
          // textTheme: GoogleFonts.sacramentoTextTheme(
          //   Theme.of(context).textTheme,
          // ),
        ),
        home: Dahboard());
  }
}
