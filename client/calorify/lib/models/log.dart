class Log {
  final String id;
  final int steps;
  final DateTime date;

  Log({required this.id, required this.steps, required this.date});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'steps': steps,
    };
  }

  @override
  String toString() {
    return 'Log{id: $id, date: $date}, steps: $steps';
  }
}
