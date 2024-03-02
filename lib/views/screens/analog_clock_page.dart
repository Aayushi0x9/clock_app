import 'dart:math';

import 'package:analog_clock_app/utils/MyRoute.dart';
import 'package:analog_clock_app/views/component/clock_optiontile.dart';
import 'package:flutter/material.dart';

class ClockPage extends StatefulWidget {
  const ClockPage({super.key});

  @override
  State<ClockPage> createState() => _ClockPageState();
}

class _ClockPageState extends State<ClockPage> {
  DateTime d = DateTime.now();
  bool _isAnalog = true;
  bool _isTimer = false;
  bool _isDigital = false;
  bool _isImage = false;
  bool _isStrap = false;

  int hour = 00;
  int minute = 00;
  int second = 00;
  bool isStop = false;

  void timer() {
    isStop = true;
    Future.delayed(
      const Duration(milliseconds: 10),
      () {
        setState(() {
          if (isStop) {
            second++;
          }
          if (second > 59) {
            minute++;
            second = 0;
          }
          if (minute > 59) {
            hour++;
            minute = 0;
          }
          if (hour > 23) {
            hour = 0;
          }
        });
        if (isStop) {
          timer();
        }
      },
    );
  }

  void AnalogStart() {
    Future.delayed(const Duration(seconds: 1), () {
      d = DateTime.now();
      setState(() {});
      AnalogStart();
    });
  }

  @override
  void initState() {
    super.initState();
    AnalogStart();
  }

  @override
  Widget build(BuildContext context) {
    TextScaler textScaler = MediaQuery.of(context).textScaler;
    Size size = MediaQuery.of(context).size;
    double h = size.height;
    double w = size.width;

    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text("Aayushi Nikhare"),
              accountEmail: Text("aayushinikhare@gmail.com"),
              currentAccountPicture: CircleAvatar(),
            ),
            //options
            clockOptionTile(
              title: "Analog Clock",
              val: _isAnalog,
              onChanged: (val) => setState(
                () => _isAnalog = !_isAnalog,
              ),
            ),
            clockOptionTile(
              title: "Timer",
              val: _isTimer,
              onChanged: (val) => setState(
                () => _isTimer = !_isTimer,
              ),
            ),
            clockOptionTile(
              title: "Digital Clock",
              val: _isDigital,
              onChanged: (val) => setState(
                () => _isDigital = !_isDigital,
              ),
            ),
            clockOptionTile(
              title: "Strap Clock",
              val: _isStrap,
              onChanged: (val) => setState(
                () => _isStrap = !_isStrap,
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Clock",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        // val : _isAnalog,
        // onChanged
        // backgroundColor: Colors.black,
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          //Analogue: --------------
          Visibility(
            visible: _isAnalog,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Analog Clock",
                  style: TextStyle(
                    color: Colors.yellow,
                    fontSize: textScaler.scale(30),
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.yellow,
                  ),
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(16),
                      height: size.height * 0.6,
                      child: Transform.rotate(
                        angle: pi / 2,
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          alignment: Alignment.center,
                          height: size.height * 6,
                          width: size.width,
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white,
                                blurRadius: 18,
                                offset: Offset(0, 0),
                              ),
                            ],
                          ),
                          child: Stack(
                            children: [
                              ...List.generate(
                                60,
                                (index) => Transform.rotate(
                                  angle: index * (pi * 2) / 60,
                                  child: Divider(
                                      endIndent: index % 5 == 0
                                          ? size.width * 0.88
                                          : size.width * 0.899,
                                      thickness: index % 5 == 0 ? 7 : 2,
                                      color: index % 15 == 0
                                          ? Colors.yellow
                                          : Colors.white),
                                ),
                              ),
                              // hour :----------
                              Transform.rotate(
                                angle: d.hour * (pi * 2) / 12,
                                child: Divider(
                                  indent: 90,
                                  endIndent: size.width * 0.5 - 23,
                                  thickness: 5,
                                  color: Colors.white,
                                ),
                              ),
                              //minute :---------
                              Transform.rotate(
                                angle: d.minute * (pi * 2) / 60,
                                child: Divider(
                                  indent: 50,
                                  endIndent: size.width * 0.5 - 23,
                                  thickness: 3,
                                  color: Colors.white,
                                ),
                              ),
                              //seconds :------------
                              Transform.rotate(
                                angle: d.second * (pi * 2) / 60,
                                child: Divider(
                                  indent: 35,
                                  endIndent: size.width * 0.5 - 23,
                                  thickness: 2,
                                  color: Colors.yellow,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          //stopwatch
          Visibility(
            visible: _isTimer,
            child: Container(
              decoration: const BoxDecoration(color: Colors.black),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: h * 0.1,
                  ),
                  Text(
                    "StopWatch",
                    style: TextStyle(
                      color: Colors.yellow,
                      fontSize: textScaler.scale(32),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Divider(
                    indent: w * 0.27,
                    endIndent: w * 0.27,
                    color: Colors.yellow,
                  ),
                  Expanded(
                    flex: 4,
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.yellow,
                              offset: Offset(1, 0),
                              blurRadius: 5,
                            )
                          ],
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(2),
                        ),
                        child: Text(
                          " ${hour.toString().padLeft(2, '0')} : ${minute.toString().padLeft(2, '0')} : ${second.toString().padLeft(2, '0')} ",
                          style: TextStyle(
                            color: Colors.yellow,
                            fontSize: textScaler.scale(50),
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            if (!isStop) {
                              timer();
                            }
                            setState(() {});
                          },
                          icon: const Icon(Icons.timer),
                          label: const Text("Start"),
                        ),
                        SizedBox(
                          width: w * 0.025,
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            setState(() {
                              isStop = false;
                            });
                          },
                          icon: const Icon(Icons.access_time_rounded),
                          label: const Text("Stop"),
                        ),
                        SizedBox(
                          width: w * 0.025,
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            setState(() {
                              isStop = false;
                              hour = minute = second = 0;
                            });
                          },
                          icon: const Icon(
                            Icons.stop,
                          ),
                          label: const Text("Restart"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // digital
          Visibility(
            visible: _isDigital,
            child: Container(
              color: Colors.black,
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      "Digital Clock",
                      style: TextStyle(
                          color: Colors.yellow,
                          fontSize: textScaler.scale(30),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Divider(
                    indent: w * 0.27,
                    endIndent: w * 0.27,
                    color: Colors.yellow,
                  ),
                  SizedBox(
                    height: h * 0.20,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.yellow,
                            offset: Offset(1, 0),
                            blurRadius: 5,
                          )
                        ],
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: Text(
                        " ${d.hour.toString().padLeft(2, '0')} : ${d.minute.toString().padLeft(2, '0')} : ${d.second.toString().padLeft(2, '0')} ",
                        style: TextStyle(
                          color: Colors.yellow,
                          fontSize: textScaler.scale(70),
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: h * 0.02,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "${d.day.toString().padLeft(2, "0")}, ${d.month.toString().padLeft(2, '0')}, ${d.year}          ",
                      style: TextStyle(
                        color: Colors.yellow,
                        fontSize: textScaler.scale(20),
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: h * 0.2,
                  ),
                ],
              ),
            ),
          ),
          //Strap
          Visibility(
            visible: _isStrap,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Strap Clock",
                    style: TextStyle(
                      color: Colors.yellow,
                      fontSize: textScaler.scale(32),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Divider(
                    indent: w * 0.27,
                    endIndent: w * 0.27,
                    color: Colors.yellow,
                  ),
                  SizedBox(
                    height: h * 0.2,
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Transform.scale(
                        scale: 8,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          value: d.hour / 12,
                          color: Colors.yellow,
                        ),
                      ),
                      Transform.scale(
                        scale: 10,
                        child: CircularProgressIndicator(
                          strokeWidth: 1,
                          value: d.minute / 60,
                          color: Colors.yellow,
                        ),
                      ),
                      Transform.scale(
                        scale: 12,
                        child: CircularProgressIndicator(
                          strokeWidth: 1,
                          value: d.second / 60,
                          color: Colors.yellow,
                        ),
                      ),
                      Text(
                        textAlign: TextAlign.center,
                        "${d.hour.toString().padLeft(2, '0')} : ${d.minute.toString().padLeft(2, '0')} : ${d.second.toString().padLeft(2, '0')}",
                        style: TextStyle(
                            color: Colors.yellow,
                            fontWeight: FontWeight.bold,
                            fontSize: textScaler.scale(22)),
                      ),
                      SizedBox(
                        height: h * 0.3,
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      backgroundColor: Colors.black,
      // timer

      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.black,
        backgroundColor: Colors.white,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: "Home",
          ),
          // GestureDetector(
          //   onTap: () {
          //     Navigator.of(context).pushNamed(MyRoutes.DigitalPage);
          //   },
          BottomNavigationBarItem(
            icon: IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(MyRoutes.DigitalPage);
              },
              icon: const Icon(Icons.timer),
            ),
            label: "Timer",
          ),
        ],
      ),
    );
  }
}
