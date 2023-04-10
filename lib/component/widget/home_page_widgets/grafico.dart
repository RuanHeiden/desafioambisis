
import 'package:desafioambisis/component/page/home_page.dart';
import 'package:desafioambisis/component/provider/filtro_date_provider.dart';
import 'package:desafioambisis/core/database/esg/esg_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:desafioambisis/component/const/const_color.dart';

Widget grafico({required BuildContext context, required EsgService getItEsgService}) {
  return FutureBuilder(
    future: getItEsgService.buscaMediaPorAno(
      dateInicial:
          context.watch<FiltroDateProvider>().dateInicialController.text,
      dateFinal: context.watch<FiltroDateProvider>().dateFinalController.text,
    ),
    builder: (contex, snapshot) {
      switch (snapshot.connectionState) {
        case ConnectionState.none:
          return Text('none');
        case ConnectionState.waiting:
          return chart(map: {});
        case ConnectionState.active:
          return Text('active');
        case ConnectionState.done:
          return chart(map: snapshot.data!);
      }
    },
  );
  // return SfCartesianChart(
  //   series: <ChartSeries>[
  //     ColumnSeries<SalesData, double>(
  //       dataSource: getColumnData(),
  //       xValueMapper: (SalesData sales, _) => sales.x,
  //       yValueMapper: (SalesData sales, _) => sales.y,
  //     ),
  //   ],
  // );
}

Widget chart({required Map<int, double> map}) {
  List<Map<String, dynamic>> listMediaByDate = [];
  for (int i = 0; i < map.length; i++) {
    int date = map.keys.toList()[i];
    double media = map.values.toList()[i];
    listMediaByDate.add({'date': date, 'media': media});
  }

  return SfCartesianChart(
    series: <ChartSeries>[
      ColumnSeries<SalesData, double>(
        gradient: myColor.degradeVerticalGreen,
        borderRadius: BorderRadius.circular(40),
        dataSource: getColumnData(list: listMediaByDate),
        xValueMapper: (SalesData sales, _) => sales.x,
        yValueMapper: (SalesData sales, _) => sales.y,
      ),
    ],
  );
}

class SalesData {
  double x, y;
  SalesData(this.x, this.y);
}