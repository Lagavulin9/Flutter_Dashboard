import 'dart:async';

import 'package:flutter/material.dart';

class ControlModel extends ChangeNotifier {
  Timer? timer;
  String _gear = "P";
  String _indicator = "None";
  bool _blink = false;
  bool _isTimerOn = false;

  String get gear => _gear;
  String get indicator => _indicator;
  bool get isBlink => _blink;

  void setIndicator(String indicator) {
    if (indicator != "None") {
      if (!_isTimerOn) {
        timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
          _blink = !_blink;
          notifyListeners();
        });
      } else {
        timer?.cancel();
        _blink = false;
        notifyListeners();
      }
      _isTimerOn = !_isTimerOn;
    } else if (_isTimerOn) return;
    _indicator = indicator;
    debugPrint("$indicator, $_blink");
  }
}
