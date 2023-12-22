import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> initDb() async {
  return openDatabase(join(await getDatabasesPath(), 'calorify.db'),
      onCreate: (db, version) async {
    await db.execute(
      'CREATE TABLE log(id TEXT PRIMARY KEY, date TEXT, steps INTEGER);',
    );
    await db.execute(
      'CREATE TABLE log_summary(id TEXT PRIMARY KEY, date TEXT, totalSteps INTEGER);',
    );
  }, version: 1);
}
