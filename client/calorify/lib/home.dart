import 'package:calorify/calories_burned.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 50, bottom: 50),
              child: CaloriesBurned(),
            )
          ],
        ),
      ),
    );
  }
}
