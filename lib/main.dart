import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
        theme: ThemeData(useMaterial3: true, primarySwatch: Colors.deepPurple),
        home: Dahboard());
  }
}
