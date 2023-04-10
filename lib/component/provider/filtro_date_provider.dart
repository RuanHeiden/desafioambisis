import 'package:flutter/material.dart';

class FiltroDateProvider with ChangeNotifier {
  ///Data atual
  final DateTime dateNow = DateTime.now();

  final dateInicialController = TextEditingController();
  final dateFinalController = TextEditingController();
  String typeFiltro = '2 Anos';

  ///Start 2 Anos
  FiltroDateProvider() {
    trocaFiltro(tipo: '2 Anos');
  }

  ///Por Data
  /// 2 Aons
  /// 5 Anos
  /// 7 Anos

  trocaFiltro({required String tipo}) {
    typeFiltro = tipo;

    switch (tipo) {
      case '2 Anos':
        dateInicialController.text =
            dateNow.subtract(const Duration(days: 2 * 365)).toString();
        dateFinalController.text = dateNow.toString();

        break;
      case '5 Anos':
        dateInicialController.text =
            dateNow.subtract(const Duration(days: 5 * 365)).toString();
        dateFinalController.text = dateNow.toString();
        break;
      case '7 Anos':
        dateInicialController.text =
            dateNow.subtract(const Duration(days: 7 * 365)).toString();
        dateFinalController.text = dateNow.toString();
        break;
      // case 'Por data':
      //   limpaFiltro();
      //   break;
    }
    notifyListeners();
  }

  limpaFiltro() {
    dateInicialController.text = '1900-01-01';
    dateFinalController.text = DateTime.now().toString();
    typeFiltro = 'Por data';
    notifyListeners();
  }

  altDataInicio({String? date}) {
    dateInicialController.text = date.toString();
    notifyListeners();
  }

  altDataFinal({String? date}) {
    dateFinalController.text = date.toString();
    notifyListeners();
  }

  teste() {
    print('DateNow ---- $dateNow');
  }
}
