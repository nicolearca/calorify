import 'dart:io';
import 'package:calorify/base.dart';
import 'package:calorify/models/log_summary.dart';
import 'package:calorify/services/db_initializer.dart';
import 'package:calorify/services/log_service.dart';
import 'package:calorify/models/log.dart';
import 'package:calorify/models/step_model.dart';
import 'package:calorify/services/log_summary_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_guid/flutter_guid.dart';
import 'package:pedometer/pedometer.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

String formatDate(DateTime d) {
  return d.toString().substring(0, 19);
}

void main() {
  if (Platform.isWindows || Platform.isLinux) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => StepModel())],
      child: const RootApp()));
}

class RootApp extends StatefulWidget {
  const RootApp({super.key});

  @override
  State<RootApp> createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  late Stream<StepCount> _stepCountStream;

  Database? db;
  late LogService logService;
  late LogSummaryService logSummaryService;

  @override
  void initState() {
    super.initState();

    initializeDb();
    if (Platform.isAndroid || Platform.isIOS) initStepListener();
  }

  void initializeDb() async {
    db = await initDb();
    logService = LogService(db: db!);
    logSummaryService = LogSummaryService(db: db!);

    final now = DateTime.now();
    final steps =
        await logService.getSteps(day: DateTime(now.year, now.month, now.day));

    Provider.of<StepModel>(context, listen: false).update(steps);

    final uncachedDates = await logSummaryService.getUncachedDateLogs();

    if (uncachedDates.isEmpty) return;

    for (var date in uncachedDates) {
      final steps = await logService.getSteps(day: date);

      await logSummaryService.insert([
        LogSummary(
          id: Guid.newGuid.value,
          date: date,
          totalSteps: steps,
        )
      ]);
    }
  }

  Future<void> onStepCount(StepCount event) async {
    db ??= await initDb();

    final now = DateTime.now();

    await logService.insert(Log(
      id: Guid.newGuid.value,
      steps: event.steps,
      date: now,
    ));

    final steps =
        await logService.getSteps(day: DateTime(now.year, now.month, now.day));

    setState(() {
      Provider.of<StepModel>(context, listen: false).update(steps);
    });
  }

  void initStepListener() {
    if (!mounted) return;

    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount);
  }

  @override
  Widget build(BuildContext context) {
    return const Base();
  }
}
