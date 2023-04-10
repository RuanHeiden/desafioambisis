import 'package:flutter/material.dart';

class myColor {
  static Color myGreen = const Color.fromARGB(250, 37, 121, 95);
  // static Color blueSWOpacity = const Color.fromARGB(250, 42, 88, 149);
  // static Color blueSWclaro = Color.fromARGB(94, 27, 126, 255);
  // static Color blackSW = const Color.fromARGB(250, 39, 39, 39);
  static const LinearGradient degradeVerticalGreen = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color.fromARGB(250, 8, 166, 128), Color.fromARGB(250, 4, 77, 65)],
  );

  static const LinearGradient degradeHorizontalGreen = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [Color.fromARGB(250, 8, 166, 128), Color.fromARGB(250, 4, 77, 65)],
  );

  static LinearGradient degradeWhite = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Colors.grey.shade200, Colors.grey.shade300],
  );
}
