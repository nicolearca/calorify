import 'package:calorify/models/log_summary.dart';
import 'package:sqflite/sqflite.dart';

class LogSummaryService {
  Database db;

  LogSummaryService({required this.db});

  Future<List<DateTime>> getUncachedDateLogs() async {
    const query = "SELECT * FROM log_summary ORDER BY date DESC LIMIT 1";
    var result = await db.rawQuery(query);

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    if (result.isEmpty) {
      return List.generate(1, (i) => today.subtract(const Duration(days: 1)));
    }

    final Map<String, dynamic> first = result.first;
    final last = DateTime.parse(first['date']);

    var start = DateTime(last.year, last.month, last.day + 1);

    List<DateTime> range = [];
    while (start.isBefore(today)) {
      range.add(start);
      start = start.add(const Duration(days: 1));
    }

    return range;
  }

  Future<void> insert(List<LogSummary> logSummaries) async {
    Batch batch = db.batch();
    for (var logSummary in logSummaries) {
      batch.insert(
        'log_summary',
        logSummary.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit(noResult: true);
  }
}
