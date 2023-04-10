import 'package:flutter/material.dart';
import 'package:desafioambisis/component/const/const_color.dart';

Widget buttonS({
  required BuildContext context,
  required double mediaWidth,
  required Widget child,
  // required Color color,
  required GestureTapCallback function,
  LinearGradient? gradient,
}) {
  return Material(
    borderRadius: BorderRadius.circular(15),
    child: InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: function,
      child: Container(
        decoration: BoxDecoration(
          // color: gradient == null ? color : null,
          gradient: gradient,
          //color: const Color.fromARGB(150, 214, 214, 216),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: child,
        ),
      ),
    ),
  );
}

// Material(
//                 borderRadius: BorderRadius.circular(15), 
//                 child: InkWell(
//                   borderRadius: BorderRadius.circular(15),
//                   onTap: () {},
//                   child: Container(
//     decoration: BoxDecoration(
//       color: color,
//       //color: const Color.fromARGB(150, 214, 214, 216),
//       borderRadius: BorderRadius.circular(10),
//     ),
//     child: Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
//       child: child,
//     ),
//   );
//                 ),
//               ),