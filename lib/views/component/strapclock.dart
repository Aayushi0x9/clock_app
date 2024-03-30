import 'package:flutter/material.dart';

Widget strapClock({required textScaler, required w, required d, required h}) {
  return Center(
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
          thickness: 2,
        ),
        SizedBox(
          height: h * 0.2,
        ),
        Stack(
          alignment: Alignment.center,
          children: [
            Transform.scale(
              scale: 6,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                value: d.hour / 24,
                color: Colors.yellow,
              ),
            ),
            Transform.scale(
              scale: 8,
              child: CircularProgressIndicator(
                strokeWidth: 1,
                value: d.minute / 60,
                color: Colors.yellow,
              ),
            ),
            Transform.scale(
              scale: 10,
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
  );
}
