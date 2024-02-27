import 'package:flutter/material.dart';

Widget clockOptionTile({
  required String title,
  required bool val,
  required Function(bool) onChanged,
}) {
  return Padding(
    padding: EdgeInsets.all(8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        Switch(
          value: val,
          onChanged: onChanged,
        )
      ],
    ),
  );
}
