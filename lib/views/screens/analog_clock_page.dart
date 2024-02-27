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
            UserAccountsDrawerHeader(
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
              val: _isDigital,
              onChanged: (val) => setState(
                () => _isStrap = !_isStrap,
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text(
          "Clock",
        ),
        // val : _isAnalog,
        // onChanged
        // backgroundColor: Colors.black,
      ),
      body: Stack(
        children: [
          //Analog: --------------
          Visibility(
            visible: _isAnalog,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        "https://images.rawpixel.com/image_800/cHJpdmF0ZS9sci9pbWFnZXMvd2Vic2l0ZS8yMDIzLTExL3Jhd3BpeGVsb2ZmaWNlMTBfYV9kaXZlcnNpdHlfYmxhY2tfYnJpY2tzX2FyZV9hcnJhbmdlZF9vbl9hbl9lbV9mOWI0ODljYy1kMjU4LTQ3OGUtYmVhNC00MWQwMTVkM2MzNjFfMS5qcGc.jpg",
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Transform.rotate(
                    angle: pi / 2,
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      alignment: Alignment.center,
                      height: size.height * 6,
                      width: size.width,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.4),
                        shape: BoxShape.circle,
                      ),
                      child: Stack(
                        children: [
                          ...List.generate(
                            60,
                            (index) => Transform.rotate(
                              angle: index * (pi * 2) / 60,
                              child: Divider(
                                  endIndent: index % 5 == 0
                                      ? size.width * 0.86
                                      : size.width * 0.88,
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
                              indent: 70,
                              endIndent: size.width * 0.5 - 23,
                              thickness: 4,
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
                              indent: 30,
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
          ),
          Visibility(
            visible: _isTimer,
            child: Container(
              decoration: const BoxDecoration(color: Color(0xffF6F5F5)),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 5,
                    child: Align(
                      child: Text(
                        "${hour.toString().padLeft(2, '0')} : ${minute.toString().padLeft(2, '0')} : ${second.toString().padLeft(2, '0')}",
                        style: TextStyle(
                          fontSize: textScaler.scale(35),
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
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
                          icon: const Icon(Icons.stop),
                          label: const Text("Restart"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: _isDigital,
            child: Container(
              height: h * 0.1,
              width: w * 0.9,
              decoration: BoxDecoration(
                color: Colors.grey,
              ),
              child: Text(
                "${d.hour.toString().padLeft(2, '0')} : ${d.minute.toString().padLeft(2, '0')} : ${d.second.toString().padLeft(2, '0')}",
                style: TextStyle(
                  fontSize: textScaler.scale(35),
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
            ),
          ),
          Visibility(
            visible: _isStrap,
            child: Center(
              child: Stack(
                children: [
                  Transform.scale(
                    scale: 2,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      value: d.hour / 12,
                      color: Colors.yellow,
                    ),
                  ),
                  Transform.scale(
                    scale: 4,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      value: d.minute / 60,
                      color: Colors.yellow,
                    ),
                  ),
                  Transform.scale(
                    scale: 6,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      value: d.second / 60,
                      color: Colors.yellow,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
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
          // ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_sharp),
            label: "Me",
          ),
        ],
      ),
    );
  }
}
