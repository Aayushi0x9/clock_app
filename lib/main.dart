import 'package:analog_clock_app/utils/MyRoute.dart';
import 'package:analog_clock_app/views/screens/analog_clock_page.dart';
import 'package:analog_clock_app/views/screens/timer_digital.dart';
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
      theme: ThemeData(
        backgroundColor: Colors.yellow,
      ),
      initialRoute: 'analog_clock_page',
      routes: {
        MyRoutes.ClockPage: (context) => ClockPage(),
        MyRoutes.DigitalPage: (context) => DigitalPage(),
      },
    );
  }
}
