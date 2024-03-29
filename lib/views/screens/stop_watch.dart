import 'package:flutter/material.dart';

class DigitalPage extends StatefulWidget {
  const DigitalPage({super.key});

  @override
  State<DigitalPage> createState() => _DigitalPageState();
}

class _DigitalPageState extends State<DigitalPage> {
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

  @override
  Widget build(BuildContext context) {
    TextScaler textScaler = MediaQuery.of(context).textScaler;
    Size size = MediaQuery.of(context).size;
    double h = size.height;
    double w = size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Clock App",
          style: TextStyle(
              fontSize: textScaler.scale(22), fontWeight: FontWeight.bold),
        ),
      ),
      body: Visibility(
        // visible: _isTimer,
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
    );
  }
}
