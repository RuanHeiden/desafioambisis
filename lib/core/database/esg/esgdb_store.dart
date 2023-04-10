import 'package:desafioambisis/core/database/create_database.dart';
import 'package:desafioambisis/core/modals/esg.dart';
import 'package:sqflite/sqflite.dart';

class Esgdb {
  static const String nameTB = 'esg_goal';
  static const String estruturaTable = 'CREATE TABLE $nameTB('
      'id INTEGER,' //PRIMARY KEY
      'date TEXT,'
      'isComplete INTEGER,'
      'type INTEGER)';
 
  ///Cria Esg
  Future<bool> createEsg(Esg esg) async {
    try {
      final Database db = await getDatabase();
      final Map<String, dynamic> esgMap = Map();

      esgMap['id'] = esg.id;
      esgMap['date'] = esg.date.toString();
      esgMap['isComplete'] = esg.isComplete;
      esgMap['type'] = esg.type;

      db.insert(nameTB, esgMap);
      selectEsg();
      return true;
    } catch (e) {
      print('Algo de errado no Esgdb.createEsg, erro:($e)');
      return false;
    }
  }

  ///Busca Esg
  Future<List<Esg>> selectEsg() async {
    final Database db = await getDatabase();
    await db.query(nameTB);

    try {
      final List<Map<String, dynamic>> result =
          await db.rawQuery('SELECT * FROM $nameTB');
      final List<Esg> listEsg = [];
      for (Map<String, dynamic> row in result) {
        Esg unEsg = Esg(
          row['id'] ?? 0,
          DateTime.parse(row['date']),
          row['isComplete'],
          row['type'],
        );
        listEsg.add(unEsg);
      } 
      return listEsg;
    } catch (e) {
      print('Algo de errado no Esgdb.selectEsg, erro:($e)');
      return [];
    }
  }

  ///Delete Esg
  Future<int> deleteEsg() async {
    final Database db = await getDatabase();
    print('delta Esg'); 
    return db.delete(nameTB); 
  }
} 

// - id
// - date
// - isComplete: 0 para uma meta não concluída e 1 para metas concluídas.
// - type: