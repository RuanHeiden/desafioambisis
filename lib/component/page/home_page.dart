import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:desafioambisis/component/provider/filtro_date_provider.dart';
import 'package:desafioambisis/component/widget/container_base_l.dart';
import 'package:desafioambisis/component/widget/button_s.dart';
import 'package:desafioambisis/component/widget/home_page_widgets/container_filtro.dart';
import 'package:desafioambisis/component/widget/home_page_widgets/container_grafico_barra_horizoantal.dart';
import 'package:desafioambisis/component/widget/home_page_widgets/grafico.dart';
import 'package:desafioambisis/core/database/esg/esg_service.dart';
import 'package:desafioambisis/core/database/esg/esgdb_store.dart';
import 'package:desafioambisis/core/modals/esg.dart';
import 'package:desafioambisis/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:desafioambisis/component/const/const_color.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final getItEsgDB = getIt<Esgdb>();
  final getItEsgService = getIt<EsgService>();

  get mediaWidth => MediaQuery.of(context).size.width;
  get mediaHeight => MediaQuery.of(context).size.height;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 214, 214, 216),
      // 214 214 216 1
      appBar: _appbar(),
      body: ListView(
        children: [
          /// Container Filtro
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Container(
              // color: Colors.red,
              height: 175,
              child: ContainerFiltroHomePage(
                context: context,
                mediaWidth: mediaWidth,
              ),
            ),
          ),

          Container(
            // color: Colors.amber,
            height: 465,
            child: graficoDeBarraVertical(),
          ),

          ///Grafico de barra horizontal (AMBIENTAL)
          FutureBuilder(
            future: getItEsgService.buscaByType(
              buscaType: 0,
              dateInicial: context
                  .watch<FiltroDateProvider>()
                  .dateInicialController
                  .text,
              dateFinal:
                  context.watch<FiltroDateProvider>().dateFinalController.text,
            ),
            builder: (context, snapshot) {
              //Text(snackBar.data![1].toString()
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  // TODO: Handle this case.
                  return Text('none');
                case ConnectionState.waiting:
                  return Container(
                    // color: Colors.blue,
                    height: 120,
                    child: containerGraficoAmbiental(
                      context: context,
                      mediaWidth: mediaWidth,
                      title: 'Ambiental',
                      icon: Icons.nature_sharp,
                      total: 0,
                      subTotal: 0,
                    ),
                  );
                case ConnectionState.active:
                  return Text('active');
                case ConnectionState.done:
                  return Container(
                    // color: Colors.blue,
                    height: 120,
                    child: containerGraficoAmbiental(
                      context: context,
                      mediaWidth: mediaWidth,
                      title: 'Ambiental',
                      icon: Icons.nature_sharp,
                      total: snapshot.data![0],
                      subTotal: snapshot.data![1],
                    ),
                  );
              }
            },
          ),

          ///Grafico de barra horizontal (SOCIAL)
          FutureBuilder(
            future: getItEsgService.buscaByType(
              buscaType: 1,
              dateInicial: context
                  .watch<FiltroDateProvider>()
                  .dateInicialController
                  .text,
              dateFinal:
                  context.watch<FiltroDateProvider>().dateFinalController.text,
            ),
            builder: (context, snapshot) {
              //Text(snackBar.data![1].toString()
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  // TODO: Handle this case.
                  return Text('none');
                case ConnectionState.waiting:
                  return Container(
                    // color: Colors.teal,
                    height: 120,
                    child: containerGraficoAmbiental(
                      context: context,
                      mediaWidth: mediaWidth,
                      title: 'Social',
                      icon: Icons.nature_people_rounded,
                      total: 0,
                      subTotal: 0,
                    ),
                  );
                case ConnectionState.active:
                  return Text('active');
                case ConnectionState.done:
                  return Container(
                    // color: Colors.teal,
                    height: 120,
                    child: containerGraficoAmbiental(
                      context: context,
                      mediaWidth: mediaWidth,
                      title: 'Social',
                      icon: Icons.nature_people_rounded,
                      total: snapshot.data![0],
                      subTotal: snapshot.data![1],
                    ),
                  );
              }
            },
          ),

          ///Grafico de barra horizontal (GOVERNAMENTAL)
          FutureBuilder(
            future: getItEsgService.buscaByType(
              buscaType: 2,
              dateInicial: context
                  .watch<FiltroDateProvider>()
                  .dateInicialController
                  .text,
              dateFinal:
                  context.watch<FiltroDateProvider>().dateFinalController.text,
            ),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return Text('none');
                case ConnectionState.waiting:
                  return Container(
                    height: 120,
                    child: containerGraficoAmbiental(
                      context: context,
                      mediaWidth: mediaWidth,
                      title: 'Governamental',
                      icon: Icons.maps_home_work_rounded,
                      total: 0,
                      subTotal: 0,
                    ),
                  );
                case ConnectionState.active:
                  return Text('active');
                case ConnectionState.done:
                  return Container(
                    // color: Colors.red,
                    height: 120,
                    child: containerGraficoAmbiental(
                      context: context,
                      mediaWidth: mediaWidth,
                      title: 'Governamental',
                      icon: Icons.maps_home_work_rounded,
                      total: snapshot.data![0],
                      subTotal: snapshot.data![1],
                    ),
                  );
              }
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        enableFeedback: false,
        onPressed: () async {
          List<Esg> listesg = await getItEsgDB.selectEsg();
          if (listesg.isEmpty) {
            for (int i = 0; i < ListEsg.length; i++) {
              getItEsgDB.createEsg(
                Esg(
                  ListEsg[i]['id'],
                  DateTime.parse(ListEsg[i]['date']),
                  ListEsg[i]['isComplete'],
                  ListEsg[i]['type'],
                ),
              );
            }
            Provider.of<FiltroDateProvider>(context, listen: false)
                .limpaFiltro();
          } else {
            print('Base Esg já alimentada !');
          }
        },
        tooltip: 'Alimentar Banco ESG',
        child: const Icon(Icons.save),
      ),
    );
  }

  Widget graficoDeBarraVertical() {
    return containerBaseL(
      context: context,
      mediaWidth: mediaWidth,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.bar_chart_sharp,
                    size: 30,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    'Resumo',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text(
                    'Regular ',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  Icon(
                    Icons.circle,
                    color: myColor.myGreen,
                    size: 15,
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15, bottom: 10),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Container(
                    color: Colors.grey.shade300,
                    height: 2,
                    width: double.infinity,
                  ),
                ),
                Row(
                  children: [
                    ///Porcentagem de crecimento
                    FutureBuilder(
                      future: getItEsgService.buscaCrescimentoESGByDate(
                        dateInicial: context
                            .watch<FiltroDateProvider>()
                            .dateInicialController
                            .text,
                        dateFinal: context
                            .watch<FiltroDateProvider>()
                            .dateFinalController
                            .text,
                      ),
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                            return Text('none');
                          case ConnectionState.waiting:
                            return _containerDetalhesResumoESG(
                                title: 'Crescimento', subTitle: '0%');
                          case ConnectionState.active:
                            return Text('active');
                          case ConnectionState.done:
                            return _containerDetalhesResumoESG(
                              title: 'Crescimento',
                              subTitle: snapshot.data.toString(),
                            );
                        }
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Container(
                        color: Colors.grey.shade300,
                        height: 30,
                        width: 1,
                      ),
                    ),

                    ///Total ESG Buscado
                    FutureBuilder(
                      future: getItEsgService.buscaTotalESGByDate(
                        dateInicial: context
                            .watch<FiltroDateProvider>()
                            .dateInicialController
                            .text,
                        dateFinal: context
                            .watch<FiltroDateProvider>()
                            .dateFinalController
                            .text,
                      ),
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                            // TODO: Handle this case.
                            return Text('none');
                          case ConnectionState.waiting:
                            // TODO: Handle this case.
                            return _containerDetalhesResumoESG(
                                title: 'Total', subTitle: '0');
                          case ConnectionState.active:
                            // TODO: Handle this case.
                            return Text('active');
                          case ConnectionState.done:
                            // TODO: Handle this case.
                            return _containerDetalhesResumoESG(
                                title: 'Total',
                                subTitle: snapshot.data.toString());
                        }
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Container(
                        color: Colors.grey.shade300,
                        height: 30,
                        width: 1,
                      ),
                    ),

                    ///Media de tarefas concluidas por ano
                    FutureBuilder(
                      future: getItEsgService.buscaMediaConcluidaByDate(
                        dateInicial: context
                            .watch<FiltroDateProvider>()
                            .dateInicialController
                            .text,
                        dateFinal: context
                            .watch<FiltroDateProvider>()
                            .dateFinalController
                            .text,
                      ),
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                            return Text('none');
                          case ConnectionState.waiting:
                            return _containerDetalhesResumoESG(
                                title: 'Média', subTitle: '0');
                          case ConnectionState.active:
                            return Text('active');
                          case ConnectionState.done:
                            // TODO: Handle this case.
                            return _containerDetalhesResumoESG(
                                title: 'Média',
                                subTitle: snapshot.data!.toStringAsFixed(1));
                        }
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Container(
                        color: Colors.grey.shade300,
                        height: 30,
                        width: 1,
                      ),
                    ),

                    ///Total concluido
                    FutureBuilder(
                      future: getItEsgService.buscaTotalConcluidoByDate(
                        dateInicial: context
                            .watch<FiltroDateProvider>()
                            .dateInicialController
                            .text,
                        dateFinal: context
                            .watch<FiltroDateProvider>()
                            .dateFinalController
                            .text,
                      ),
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                            return Text('none');
                          case ConnectionState.waiting:
                            return _containerDetalhesResumoESG(
                                title: 'Concluídas', subTitle: '0');
                          case ConnectionState.active:
                            return Text('none');
                          case ConnectionState.done:
                            return _containerDetalhesResumoESG(
                                title: 'Concluídas',
                                subTitle: snapshot.data.toString());
                        }
                      },
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Container(
                    color: Colors.grey.shade300,
                    height: 2,
                    width: double.infinity,
                  ),
                ),
              ],
            ),
          ),
          grafico(context: context, getItEsgService: getItEsgService),
        ],
      ),
    );
  }
}

_containerDetalhesResumoESG({required String title, required String subTitle}) {
  return Expanded(
    flex: 1,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Colors.black54,
            ),
          ),
          SizedBox(
            height: 3,
          ),
          Text(
            subTitle == 'null'? '0%' : subTitle,
            style: TextStyle(
              color: myColor.myGreen,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    ),
  );
}

///AppBar Dashboard ESG
AppBar _appbar() {
  return AppBar(
    elevation: 0,
    backgroundColor: Colors.white,
    flexibleSpace: Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 6),
              child: Icon(Icons.cloud_outlined),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 6),
              child: Icon(Icons.chat),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 6),
              child: Icon(Icons.list),
            ),
          ],
        ),
      ),
    ),
    leading: const Icon(
      Icons.arrow_back_ios,
      size: 18,
      color: Colors.black,
    ),
    title: const Text(
      'Dashboard ESG',
      style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w700,
      ),
    ),
  );
}

dynamic getColumnData({required List<Map<String, dynamic>> list}) {
  List<SalesData> columnData = [];
  for (int i = 0; i < list.length; i++) { 
    columnData.add(
      SalesData(double.parse(list[i]['date'].toString()),
          double.parse(list[i]['media'].toString())),
    );
  }
  return columnData;
}

///Lista de ESG para gravar no sqlite
List<Map<String, dynamic>> ListEsg = [
  {"id": 1, "date": "2011-11-01", "isComplete": 0, "type": 0},
  {"id": 2, "date": "2011-10-02", "isComplete": 0, "type": 1},
  {"id": 3, "date": "2011-10-03", "isComplete": 0, "type": 2},
  {"id": 4, "date": "2011-09-04", "isComplete": 1, "type": 0},
  {"id": 5, "date": "2011-08-05", "isComplete": 1, "type": 1},
  {"id": 6, "date": "2011-07-06", "isComplete": 1, "type": 2},
  {"id": 7, "date": "2010-02-07", "isComplete": 0, "type": 0},
  {"id": 8, "date": "2010-02-08", "isComplete": 0, "type": 1},
  {"id": 9, "date": "2010-02-09", "isComplete": 0, "type": 2},
  {"id": 10, "date": "2010-02-10", "isComplete": 1, "type": 0},
  {"id": 11, "date": "2010-02-11", "isComplete": 1, "type": 1},
  {"id": 12, "date": "2010-02-12", "isComplete": 1, "type": 2},
  {"id": 13, "date": "2009-05-05", "isComplete": 0, "type": 0},
  {"id": 14, "date": "2009-05-06", "isComplete": 0, "type": 1},
  {"id": 15, "date": "2009-05-07", "isComplete": 0, "type": 2},
  {"id": 16, "date": "2009-05-08", "isComplete": 0, "type": 0},
  {"id": 17, "date": "2009-05-09", "isComplete": 0, "type": 1},
  {"id": 18, "date": "2009-05-10", "isComplete": 0, "type": 2},
  {"id": 19, "date": "2022-01-10", "isComplete": 0, "type": 0},
  {"id": 20, "date": "2022-02-11", "isComplete": 0, "type": 1},
  {"id": 21, "date": "2022-03-12", "isComplete": 0, "type": 2},
  {"id": 19, "date": "2022-04-13", "isComplete": 1, "type": 0},
  {"id": 20, "date": "2022-05-14", "isComplete": 1, "type": 1},
  {"id": 21, "date": "2022-06-15", "isComplete": 1, "type": 2},
  {"id": 22, "date": "2021-01-10", "isComplete": 0, "type": 0},
  {"id": 23, "date": "2021-02-11", "isComplete": 0, "type": 1},
  {"id": 24, "date": "2021-03-12", "isComplete": 0, "type": 2},
  {"id": 25, "date": "2021-04-13", "isComplete": 1, "type": 0},
  {"id": 26, "date": "2021-05-14", "isComplete": 1, "type": 1},
  {"id": 27, "date": "2021-06-15", "isComplete": 1, "type": 2},
  {"id": 28, "date": "2023-04-08", "isComplete": 1, "type": 2},
  {"id": 29, "date": "2019-04-08", "isComplete": 1, "type": 0},
  {"id": 30, "date": "2019-04-08", "isComplete": 1, "type": 0},
  {"id": 31, "date": "2019-05-09", "isComplete": 1, "type": 0},
  {"id": 32, "date": "2020-05-09", "isComplete": 1, "type": 0},
  {"id": 33, "date": "2020-05-10", "isComplete": 1, "type": 0},
  {"id": 34, "date": "2020-06-10", "isComplete": 1, "type": 0},
  {"id": 35, "date": "2021-06-10", "isComplete": 1, "type": 0},
  {"id": 36, "date": "2021-06-15", "isComplete": 1, "type": 0},
  {"id": 37, "date": "2022-07-15", "isComplete": 1, "type": 0},
  {"id": 38, "date": "2022-07-15", "isComplete": 1, "type": 0},
  {"id": 39, "date": "2023-07-15", "isComplete": 1, "type": 1},
  {"id": 40, "date": "2023-08-15", "isComplete": 1, "type": 1},
  {"id": 15702, "date": "2015-03-10", "isComplete": 0, "type": 2},
  {"id": 47028, "date": "2015-08-16", "isComplete": 1, "type": 1},
  {"id": 82496, "date": "2023-07-05", "isComplete": 0, "type": 0},
  {"id": 90314, "date": "2016-06-02", "isComplete": 1, "type": 1},
  {"id": 27590, "date": "2016-12-20", "isComplete": 0, "type": 0},
  {"id": 63107, "date": "2023-11-25", "isComplete": 1, "type": 2},
  {"id": 51734, "date": "2023-12-18", "isComplete": 1, "type": 0},
  {"id": 98271, "date": "2017-11-06", "isComplete": 0, "type": 1},
  {"id": 13028, "date": "2023-08-10", "isComplete": 1, "type": 2},
  {"id": 41067, "date": "2017-05-19", "isComplete": 1, "type": 0},
  {"id": 75932, "date": "2023-12-06", "isComplete": 0, "type": 2},
  {"id": 64270, "date": "2023-06-28", "isComplete": 1, "type": 1},
  {"id": 59724, "date": "2018-04-14", "isComplete": 1, "type": 0},
  {"id": 18039, "date": "2018-07-23", "isComplete": 0, "type": 1},
  {"id": 92650, "date": "2023-09-13", "isComplete": 0, "type": 2},
  {"id": 25698, "date": "2023-10-04", "isComplete": 1, "type": 0},
  {"id": 70425, "date": "2019-08-08", "isComplete": 1, "type": 1},
  {"id": 93201, "date": "2019-06-26", "isComplete": 0, "type": 2},
  {"id": 67890, "date": "2023-10-15", "isComplete": 1, "type": 0},
  {"id": 23456, "date": "2019-02-28", "isComplete": 0, "type": 1},
  {"id": 78901, "date": "2023-08-20", "isComplete": 1, "type": 2},
  {"id": 34567, "date": "2023-11-05", "isComplete": 0, "type": 0},
  {"id": 34567, "date": "2014-11-05", "isComplete": 0, "type": 0},
  {"id": 34567, "date": "2015-11-05", "isComplete": 0, "type": 0},
  {"id": 34567, "date": "2016-11-05", "isComplete": 0, "type": 0},
  {"id": 34567, "date": "2017-11-05", "isComplete": 0, "type": 0},
  {"id": 90123, "date": "2019-05-01", "isComplete": 1, "type": 1}
];
