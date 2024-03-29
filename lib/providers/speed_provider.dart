import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_dashboard/providers/commonAPI.dart';

class SpeedModel extends ChangeNotifier {
  final CommonAPI bridge = CommonAPI();
  late Timer timer;
  late int _speed;

  int get speed => _speed;

  SpeedModel() {
    _speed = bridge.getSpeed();
    timer = Timer.periodic(const Duration(milliseconds: 16), (timer) {
      int newSpeed = bridge.getSpeed();
      if (_speed != newSpeed) {
        _speed = newSpeed;
        notifyListeners();
      }
    });
  }
}
