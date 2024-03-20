import 'package:analog_clock_app/utils/MyRoute.dart';
import 'package:analog_clock_app/views/screens/clock_app.dart';
import 'package:analog_clock_app/views/screens/stop_watch.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const ClockApp());
}

class ClockApp extends StatelessWidget {
  const ClockApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'analog_clock_page',
      routes: {
        MyRoutes.ClockPage: (context) => ClockPage(),
        MyRoutes.DigitalPage: (context) => DigitalPage(),
      },
    );
  }
}
