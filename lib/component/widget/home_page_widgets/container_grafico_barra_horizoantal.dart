import 'package:desafioambisis/component/widget/container_base_l.dart';
import 'package:flutter/material.dart';
import 'package:desafioambisis/component/const/const_color.dart';

containerGraficoAmbiental({
  required BuildContext context,
  required double mediaWidth,
  required String title,
  required IconData icon,
  required int total,
  required int subTotal,
}) {
  return containerBaseL(
    context: context,
    mediaWidth: mediaWidth,
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ///Icon e title
            Row(
              children: [
                Icon(
                  icon,
                  size: 30,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),

            ///outros dados
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Text(
                      'Total: ',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54),
                    ),
                    Text(
                      total.toString(),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: myColor.myGreen,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Concluídas: ',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54),
                    ),
                    Text(
                      subTotal.toString(),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: myColor.myGreen,
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),

        ///Grafico em barra horizontal
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Container(
            child: total != 0
                ? LinearProgressIndicator(
                    minHeight: 8,
                    value: subTotal / total,
                    backgroundColor: Colors.grey.shade300,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      myColor.myGreen,
                    ),
                  )
                : Container(
                    height: 8,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    width: double.infinity,
                  ),
          ),
        ),
      ],
    ),
  );
}
