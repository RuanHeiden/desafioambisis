import 'package:desafioambisis/core/database/esg/esgdb_store.dart';
import 'package:desafioambisis/core/modals/esg.dart';

class EsgService {
  final Esgdb esgdb;

  EsgService({required this.esgdb});

  //type - [0,1,2]
  Future<List> buscaByType({
    required int buscaType,
    String? dateInicial = '00/00/000',
    String? dateFinal,
  }) async {
    List totalQuantidade = [];
    List<Esg> listEsg = await esgdb.selectEsg();

    if (dateInicial != null && dateFinal != null) {
      DateTime startTime = DateTime.parse(dateInicial);
      DateTime endTime = DateTime.parse(dateFinal);
      totalQuantidade = [
        listEsg
            .where(
              (element) =>
                  element.type == buscaType &&
                  element.date.isAfter(startTime) &&
                  element.date.isBefore(endTime),
            )
            .toList()
            .length,
        listEsg
            .where(
              (element) =>
                  element.type == buscaType &&
                  element.isComplete == 1 &&
                  element.date.isAfter(startTime) &&
                  element.date.isBefore(endTime),
            )
            .toList()
            .length
      ];
    } else {
      totalQuantidade = [
        listEsg.where((element) => element.type == buscaType).toList().length,
        listEsg
            .where((element) =>
                element.type == buscaType && element.isComplete == 1)
            .toList()
            .length
      ];
    }

    return totalQuantidade;
  }

  ///Busca media por ano com base na data (de - até)
  Future<Map<int, double>> buscaMediaPorAno({
    required String dateInicial,
    required String dateFinal,
  }) async {
    DateTime startTime = DateTime.parse(dateInicial);
    DateTime endTime = DateTime.parse(dateFinal);
    List<Esg> listEsg = await esgdb.selectEsg();
    List<Map<String, dynamic>> mediaPorAno = [];

    List<Esg> listEsgByDate = listEsg
        .where(
          (element) =>
              element.date.isAfter(startTime) && element.date.isBefore(endTime),
        )
        .toList();
    for (int i = 0; i < listEsgByDate.length; i++) {
      mediaPorAno.add(
        {
          'date': listEsgByDate[i].date.year,
          'media': await buscaMediaConcluidaByDate(
            dateInicial: listEsgByDate[i].date.toString(),
            dateFinal: listEsgByDate[i]
                .date
                .add(
                  const Duration(
                    days: 1 * 365,
                  ),
                )
                .toString(),
          ),
        },
      );
    }
 
    Map<int, List<double>> mediasPorAno = {};
    for (var info in mediaPorAno) {
      int ano = info["date"];
      double media = info["media"];
      if (mediasPorAno.containsKey(ano)) {
        mediasPorAno[ano]?.add(media);
      } else {
        mediasPorAno[ano] = [media];
      }
    }

    Map<int, double> mediaPorAnos = {};
    List<Map<String, double>> listPorAnosss =[];

    for (var entry in mediasPorAno.entries) {
      int ano = entry.key;
      List<double> medias = entry.value;
      double mediaAnual = medias.reduce((a, b) => a + b) / medias.length;
      mediaPorAnos[ano] = mediaAnual; 
    } 

    return mediaPorAnos;
  }

  ///Busca a porcentagem de crecimento com base no media por ano
  Future<String> buscaCrescimentoESGByDate({
    required String dateInicial,
    required String dateFinal,
  }) async {
    Map<int, double> listMedia = await buscaMediaPorAno(
      dateInicial: dateInicial,
      dateFinal: dateFinal,
    ); 
    // encontrar o dado mais antigo e o mais recente
    int dadoMaisAntigo = listMedia.keys.reduce((a, b) => a < b ? a : b);
    int dadoMaisRecente = listMedia.keys.reduce((a, b) => a > b ? a : b);

    // calcular a diferença entre os valores
    double diferenca = listMedia[dadoMaisRecente]! - listMedia[dadoMaisAntigo]!;

    // calcular a porcentagem de crescimento
    double porcentagemCrescimento =
        (diferenca / listMedia[dadoMaisAntigo]!) * 100;

    // imprimir o resultado 
    return porcentagemCrescimento.toStringAsFixed(2);
  }

  ///Busca total Esg com base na data (de - até)
  Future<int> buscaTotalESGByDate({
    required String dateInicial,
    required String dateFinal,
  }) async {
    List<Esg> listEsg = await esgdb.selectEsg();
    DateTime startTime = DateTime.parse(dateInicial);
    DateTime endTime = DateTime.parse(dateFinal);
    return listEsg
        .where(
          (element) =>
              element.date.isAfter(startTime) && element.date.isBefore(endTime),
        )
        .toList()
        .length;
  }

  ///Busca a media concluida com base na data
  Future<double> buscaMediaConcluidaByDate({
    required String dateInicial,
    required String dateFinal,
  }) async {
    DateTime startTime = DateTime.parse(dateInicial);
    DateTime endTime = DateTime.parse(dateFinal);
    List<Esg> listEsg = await esgdb.selectEsg();

    List<Esg> listEsgByDate = listEsg
        .where(
          (element) =>
              element.date.isAfter(startTime) && element.date.isBefore(endTime),
        )
        .toList();

    // Contando o número de tarefas concluídas
    int tarefasConcluidas = 0;
    for (var list in listEsgByDate) {
      if (list.isComplete == 1) {
        tarefasConcluidas++;
      }
    }

    // Calculando a duração do período de tempo em anos
    DateTime lastDate = DateTime.parse(dateFinal);
    DateTime firstDate = DateTime.parse(dateInicial);
    double diasDoAno = lastDate.difference(firstDate).inDays / 365;

    // Calculando a média geral de tarefas concluídas por ano
    double avgTasksCompleted = tarefasConcluidas / diasDoAno;

    return avgTasksCompleted;
  }

  Future<int> buscaTotalConcluidoByDate({
    required String dateInicial,
    required String dateFinal,
  }) async {
    DateTime startTime = DateTime.parse(dateInicial);
    DateTime endTime = DateTime.parse(dateFinal);
    List<Esg> listEsg = await esgdb.selectEsg();

    List<Esg> listEsgByDate = listEsg
        .where(
          (element) =>
              element.date.isAfter(startTime) && element.date.isBefore(endTime),
        )
        .toList();
    return listEsgByDate.length;
  }
}
