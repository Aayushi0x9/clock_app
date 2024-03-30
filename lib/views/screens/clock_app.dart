import 'package:analog_clock_app/views/component/analogclock.dart';
import 'package:analog_clock_app/views/component/bottomNavigationbar.dart';
import 'package:analog_clock_app/views/component/clock_optiontile.dart';
import 'package:analog_clock_app/views/component/digitalclock.dart';
import 'package:analog_clock_app/views/component/strapclock.dart';
import 'package:analog_clock_app/views/component/timeview.dart';
import 'package:flutter/material.dart';

import '../../utils/img.dart';

class ClockPage extends StatefulWidget {
  const ClockPage({super.key});

  @override
  State<ClockPage> createState() => _ClockPageState();
}

class _ClockPageState extends State<ClockPage> {
  DateTime d = DateTime.now();
  bool _isAnalog = false;
  bool _isStopWatch = false;
  bool _isDigital = true;
  bool _isImage = false;
  bool _isStrap = false;
  late String Image =
      "https://m.media-amazon.com/images/I/21i-4Jd8SsL._AC_UF1000,1000_QL80_.jpg";
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
              title: "Stopwatch",
              val: _isStopWatch,
              onChanged: (val) => setState(
                () => _isStopWatch = !_isStopWatch,
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
            clockOptionTile(
              title: "Image",
              val: _isImage,
              onChanged: (val) => setState(
                () => _isImage = !_isImage,
              ),
            ),
            _isImage
                ? SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                        Images.length,
                        (index) => GestureDetector(
                          onTap: () {
                            setState(
                              () {
                                Image = Images[index];
                              },
                            );
                          },
                          child: Container(
                            width: 150,
                            height: 180,
                            margin: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Image == Images[index]
                                    ? Colors.black
                                    : Colors.white,
                                style: BorderStyle.solid,
                                width: 3,
                              ),
                              image: DecorationImage(
                                image: NetworkImage(
                                  Images[index],
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                : Container(),
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
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          //Analogue: --------------
          Visibility(
            visible: _isAnalog,
            child: analogClock(textScaler: textScaler, w: w, size: size, d: d),
          ),
          //stopwatch
          Visibility(
            visible: _isStopWatch,
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
                  thickness: 2,
                ),
                timeView(
                    hour: hour,
                    minute: minute,
                    second: second,
                    textScaler: textScaler),
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
          // digital
          Visibility(
            visible: _isDigital,
            child: digitClock(textScaler: textScaler, w: w, h: h, d: d),
          ),
          //Strap
          Visibility(
            visible: _isStrap,
            child: strapClock(textScaler: textScaler, w: w, d: d, h: h),
          ),
        ],
      ),
      backgroundColor: Colors.black,
      // timer

      bottomNavigationBar: MyNavigationBar(context: context),
    );
  }
}
