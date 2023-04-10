import 'package:flutter/material.dart';

Widget containerBaseL({
  required BuildContext context,
  required double mediaWidth,
  required Widget child,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
    child: Column(
      children: [
        Container(
          width: mediaWidth,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: child,
          ),
        )
      ],
    ),
  );
}
