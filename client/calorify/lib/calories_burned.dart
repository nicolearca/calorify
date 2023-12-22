import 'package:calorify/models/step_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CaloriesBurned extends StatefulWidget {
  const CaloriesBurned({super.key});

  @override
  State<CaloriesBurned> createState() => _CaloriesBurnedState();
}

class _CaloriesBurnedState extends State<CaloriesBurned>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _animation;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _animationController.repeat(reverse: true);
    _animation = Tween(begin: 0.0, end: 80.0).animate(_animationController)
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context)
        .textTheme
        .apply(displayColor: Colors.white, bodyColor: Colors.white70);

    return Consumer<StepModel>(
      builder: (context, model, child) {
        final format = NumberFormat("###,##0.0#", "en_US");
        final calories = model.steps * 0.04;

        return Column(children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.transparent,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.amberAccent,
                            blurRadius: _animation.value,
                            spreadRadius: _animation.value * 0.75)
                      ]),
                ),
              ),
              Image.asset('assets/images/logo.png', width: 150),
            ],
          ),
          Text(
            format.format(calories),
            style: textTheme.displayMedium,
            textAlign: TextAlign.center,
          ),
          Text(
            'calories burned',
            style: textTheme.headlineSmall,
            textAlign: TextAlign.center,
          )
        ]);
      },
    );
  }
}
