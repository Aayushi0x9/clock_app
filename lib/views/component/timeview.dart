import 'package:flutter/material.dart';

Widget timeView(
    {required hour, required minute, required second, required textScaler}) {
  return Expanded(
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
  );
}
