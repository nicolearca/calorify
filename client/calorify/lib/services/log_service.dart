import 'package:calorify/models/log.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

class LogService {
  Database db;

  LogService({required this.db});

  Future<void> insert(Log log) async {
    await db.insert(
      'log',
      log.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Log>> filter(DateTime startDate, DateTime endDate) async {
    final formatter = DateFormat('yyyy-MM-ddTHH:mm:ss');
    final start = formatter.format(startDate);
    final end = formatter.format(endDate.add(const Duration(days: 1)));

    final query = "SELECT * FROM log where date >= '$start' and date < '$end'";
    final List<Map<String, dynamic>> maps = await db.rawQuery(query);

    if (maps.isEmpty) {
      return [];
    }

    return List.generate(maps.length, (i) {
      return Log(
        id: maps[i]['id'],
        steps: maps[i]['steps'],
        date: DateTime.parse(maps[i]['date']),
      );
    });
  }

  Future<Log?> getLast(Database db, DateTime limitDate) async {
    final formatter = DateFormat('yyyy-MM-ddTHH:mm:ss');
    final limit = formatter.format(limitDate);

    final query =
        "SELECT * FROM log where date < '$limit' ORDER BY date DESC LIMIT 1";
    var result = await db.rawQuery(query);

    if (result.isEmpty) {
      return null;
    }

    final Map<String, dynamic> first = result.first;
    return Log(
      id: first['id'],
      steps: first['steps'],
      date: DateTime.parse(first['date']),
    );
  }

  Future<int> getSteps({required DateTime day, double moe = 0.02}) async {
    final nextDay = DateTime(day.year, day.month, day.day + 1);

    final logs = await filter(day, nextDay);
    if (logs.isEmpty) {
      return 0;
    }

    var last = await getLast(db, day);

    last ??= logs[0];

    var steps = 0;
    var cursor = last;
    for (var i = 1; i < logs.length; i++) {
      final current = logs[i];

      if (current.steps < cursor.steps) {
        steps += current.steps;
      } else {
        steps += current.steps - cursor.steps;
      }

      cursor = current;
    }

    return (steps * (1 - moe)).round();
  }
}
