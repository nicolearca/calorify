import 'package:flutter/widgets.dart';

class StepModel extends ChangeNotifier {
  var steps = 0;

  void init(int steps) {
    this.steps = steps;
    notifyListeners();
  }

  void update(int steps) {
    this.steps = steps;
    notifyListeners();
  }
}
