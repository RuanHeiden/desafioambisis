import 'package:date_time_picker/date_time_picker.dart';
import 'package:desafioambisis/component/provider/filtro_date_provider.dart';
import 'package:desafioambisis/component/widget/button_s.dart';
import 'package:desafioambisis/component/widget/container_base_l.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:desafioambisis/component/const/const_color.dart';

///Container bloco filtros por data
Widget ContainerFiltroHomePage({
  required BuildContext context,
  required double mediaWidth,
}) {
  Color _corButton({required String type}) {
    return context.watch<FiltroDateProvider>().typeFiltro == type
        ? myColor.myGreen
        : Color.fromARGB(150, 214, 214, 216); 
  }

  Color _corTextButton({required String type}) {
    return context.watch<FiltroDateProvider>().typeFiltro == type
        ? Colors.white
        : Colors.black;
  }

  Color _corTextFieldDataDeAte({required String type}) {
    return context.watch<FiltroDateProvider>().typeFiltro == type
        ? Colors.black87
        : Colors.grey;
  }

  LinearGradient _corButtonGradient({required String type}) {
    return context.watch<FiltroDateProvider>().typeFiltro == type
        ? myColor.degradeVerticalGreen
        : myColor.degradeWhite;
  }

  return containerBaseL(
    context: context,
    mediaWidth: mediaWidth,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Filtros',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buttonS(
                context: context,
                mediaWidth: mediaWidth,
                child: Text(
                  '2 Anos',
                  style: TextStyle(
                    color: _corTextButton(type: '2 Anos'),
                  ),
                ),
                // color: _corButton(type: '2 Anos'),
                gradient: _corButtonGradient(type: '2 Anos'),
                function: () {
                  Provider.of<FiltroDateProvider>(context, listen: false)
                      .trocaFiltro(tipo: '2 Anos');
                },
              ),
              buttonS(
                context: context,
                mediaWidth: mediaWidth,
                child: Text(
                  '5 Anos',
                  style: TextStyle(
                    color: _corTextButton(type: '5 Anos'),
                  ),
                ),
                // color: _corButton(type: '5 Anos'),
                gradient: _corButtonGradient(type: '5 Anos'),
                function: () {
                  Provider.of<FiltroDateProvider>(context, listen: false)
                      .trocaFiltro(tipo: '5 Anos');
                },
              ),
              buttonS(
                context: context,
                mediaWidth: mediaWidth,
                child: Text(
                  '7 Anos',
                  style: TextStyle(
                    color: _corTextButton(type: '7 Anos'),
                  ),
                ),
                // color: _corButton(
                //   type: '7 Anos',
                // ),
                gradient: _corButtonGradient(type: '7 Anos'),
                function: () {
                  Provider.of<FiltroDateProvider>(context, listen: false)
                      .trocaFiltro(tipo: '7 Anos');
                },
              ),
              buttonS(
                context: context,
                mediaWidth: mediaWidth,
                child: Text(
                  'Por data',
                  style: TextStyle(
                    color: _corTextButton(type: 'Por data'),
                  ),
                ),
                // color: _corButton(type: 'Por data'),
                gradient: _corButtonGradient(type: 'Por data'),
                // myColor.degradeVerticalGreen,
                function: () {
                  Provider.of<FiltroDateProvider>(context, listen: false)
                      .trocaFiltro(tipo: 'Por data');
                },
              ),
            ],
          ),
        ),

        ///TextField data de até
        Container(
          child: Row(
            children: [
              Icon(Icons.date_range_outlined,
                  color: _corTextFieldDataDeAte(type: 'Por data')),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Container(
                    decoration: BoxDecoration(
                      color: context.watch<FiltroDateProvider>().typeFiltro ==
                              'Por data'
                          ? Colors.transparent
                          : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: Colors.grey.shade300,
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: Container(
                              height: 30,
                              width: 100,
                              // color: Colors.amber,
                              child: Padding(
                                padding: EdgeInsets.only(left: 15),
                                child: DateTimePicker(
                                  enabled: context
                                              .watch<FiltroDateProvider>()
                                              .typeFiltro ==
                                          'Por data'
                                      ? true
                                      : false,
                                  controller: context
                                      .watch<FiltroDateProvider>()
                                      .dateInicialController,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    labelStyle: TextStyle(
                                        color: _corTextFieldDataDeAte(
                                            type: 'Por data')),
                                  ),
                                  dateMask: 'dd/MM/yyyy',
                                  dateLabelText: 'Date',
                                  firstDate: DateTime(1800),
                                  lastDate: DateTime(2100),
                                  icon: const Icon(Icons.event),
                                  use24HourFormat: false,
                                  locale: const Locale('pt', 'BR'),
                                  onChanged: (val) {
                                    Provider.of<FiltroDateProvider>(context,
                                            listen: false)
                                        .altDataInicio(date: val);
                                  },
                                  // validator: (val) {
                                  //   return null;
                                  // },
                                  // onSaved: (val) => print(val),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: Container(
                            color: Colors.grey.shade300,
                            height: 20,
                            width: 1,
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: Container(
                              height: 30,
                              width: 100,
                              // color: Colors.amber,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: DateTimePicker(
                                  enabled: context
                                              .watch<FiltroDateProvider>()
                                              .typeFiltro ==
                                          'Por data'
                                      ? true
                                      : false,
                                  controller: context
                                      .watch<FiltroDateProvider>()
                                      .dateFinalController,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    labelStyle: TextStyle(
                                      color: _corTextFieldDataDeAte(
                                        type: 'Por data',
                                      ),
                                    ),
                                  ),
                                  dateMask: 'dd/MM/yyyy',
                                  dateLabelText: 'Date',
                                  firstDate: DateTime(1800),
                                  lastDate: DateTime(2100),
                                  icon: const Icon(Icons.event),
                                  use24HourFormat: false,
                                  locale: const Locale('pt', 'BR'),
                                  onChanged: (val) {
                                    Provider.of<FiltroDateProvider>(context,
                                            listen: false)
                                        .altDataFinal(date: val);
                                  },
                                  // validator: (val) {
                                  //   return null;
                                  // },
                                  // onSaved: (val) => print(val),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Material(
                borderRadius: BorderRadius.circular(20),
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    ///Limpa data inicio e fim
                    Provider.of<FiltroDateProvider>(context, listen: false)
                        .limpaFiltro();
                        
                  },
                  child: CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.transparent,
                    // backgroundColor: Colors.red,
                    child: Icon(
                      Icons.close,
                      color: _corTextFieldDataDeAte(type: 'Por data'),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    ),
  );
}
