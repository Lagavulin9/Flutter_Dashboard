import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_dashboard/providers/commonAPI.dart';

class ControlModel extends ChangeNotifier {
  final CommonAPI bridge = CommonAPI();
  Timer? timer;
  Timer? blinkTimer;
  late String _gear;
  late String _indicator;
  bool _blink = false;
  bool _isTimerOn = false;

  String get gear => _gear;
  String get indicator => _indicator;
  bool get isBlink => _blink;

  void setIndicator(String indicator) {
    if (indicator != "None") {
      if (!_isTimerOn) {
        blinkTimer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
          _blink = !_blink;
          notifyListeners();
        });
      } else {
        blinkTimer?.cancel();
        _blink = false;
        notifyListeners();
      }
      _isTimerOn = !_isTimerOn;
    } else if (_isTimerOn) return;
    _indicator = indicator;
    debugPrint("$indicator, $_blink");
  }

  ControlModel() {
    _gear = bridge.getGear();
    _indicator = bridge.getIndicator();
    timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      String newGear = bridge.getGear();
      String newIndicator = bridge.getIndicator();
      if (_gear != newGear) {
        _gear = newGear;
        notifyListeners();
      }
      if (_indicator != newIndicator) {
        setIndicator(newIndicator);
        notifyListeners();
      }
    });
  }
}
