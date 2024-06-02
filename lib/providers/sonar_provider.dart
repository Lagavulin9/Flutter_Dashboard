import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_dashboard/providers/commonAPI.dart';

class SonarModel extends ChangeNotifier {
  CommonAPI bridge = CommonAPI();
  late SonarStruct _sonar;
  int limit = 10;
  Timer? timer;

  int get front => _sonar.front;
  int get rear => _sonar.rear;
  bool get tooClose => (front <= limit) || (rear <= limit);

  SonarModel() {
    SonarStruct sonar = bridge.getSonar();
    _sonar = sonar;
    timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      SonarStruct newsonar = bridge.getSonar();
      if (_sonar != newsonar) {
        _sonar = newsonar;
        notifyListeners();
      }
    });
  }
}
