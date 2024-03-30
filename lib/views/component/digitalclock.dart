import 'package:flutter/material.dart';

import '../../utils/Global.dart';

Widget digitClock({required textScaler, required w, required h, required d}) {
  return Padding(
    padding: const EdgeInsets.all(40),
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
          thickness: 2,
        ),
        SizedBox(
          height: h * 0.20,
        ),
//time
        Container(
          padding: const EdgeInsets.all(10),
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                " ${d.hour.toString().padLeft(2, '0')} : ${d.minute.toString().padLeft(2, '0')}",
                style: TextStyle(
                  color: Colors.yellow,
                  fontSize: textScaler.scale(70),
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
              SizedBox(width: w * 0.08),
              (d.hour) >= 12
                  ? Text(
                      'PM',
                      style: TextStyle(
                        color: Colors.yellow,
                        fontSize: textScaler.scale(50),
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    )
                  : Text(
                      'AM',
                      style: TextStyle(
                        color: Colors.yellow,
                        fontSize: textScaler.scale(50),
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
            ],
          ),
        ),
        SizedBox(
          height: h * 0.01,
        ),
//date
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "${Day[d.weekday - 1]} , ${d.day.toString()} ${Month[d.month - 1]}",
              style: const TextStyle(
                  color: Colors.yellow,
                  letterSpacing: 3,
                  fontWeight: FontWeight.w400,
                  fontSize: 20),
            ),
          ],
        )
      ],
    ),
  );
}
