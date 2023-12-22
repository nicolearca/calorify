class LogSummary {
  final String id;
  final int totalSteps;
  final DateTime date;

  LogSummary({required this.id, required this.totalSteps, required this.date});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'totalSteps': totalSteps,
    };
  }

  @override
  String toString() {
    return 'LogSummary{id: $id, date: $date}, totalSteps: $totalSteps';
  }
}
