import 'dart:math';

import 'package:flutter/material.dart';

Widget analogClock(
    {required textScaler, required w, required size, required d}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        "Analog Clock",
        style: TextStyle(
          color: Colors.yellow,
          fontSize: textScaler.scale(30),
        ),
      ),
      Divider(
        indent: w * 0.30,
        endIndent: w * 0.27,
        color: Colors.yellow,
        thickness: 2,
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
                                ? size.width * 0.87
                                : size.width * 0.88,
                            thickness: index % 5 == 0 ? 7 : 2,
                            color:
                                index % 15 == 0 ? Colors.yellow : Colors.white),
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
  );
}
