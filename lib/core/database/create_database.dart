 
import 'package:desafioambisis/core/database/esg/esgdb_store.dart';
import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
 

Future<Database> getDatabase() async {
  final String dbPath = await getDatabasesPath();
  final String path = join(dbPath, 'ambsis.db');

  return openDatabase(
    path,
    onCreate: (db, version) {
      db.execute(Esgdb.estruturaTable);
    },
    version: 1,
  ); 
}
