import 'package:flutter/material.dart';

import '../../utils/MyRoute.dart';

Widget MyNavigationBar({
  required context,
}) {
  return BottomNavigationBar(
    unselectedItemColor: Colors.grey,
    selectedItemColor: Colors.black,
    backgroundColor: Colors.white,
    items: [
      const BottomNavigationBarItem(
        icon: Icon(Icons.home_rounded),
        label: "Home",
      ),
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
  );
}
