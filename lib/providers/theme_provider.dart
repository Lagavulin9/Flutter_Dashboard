import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_dashboard/providers/commonAPI.dart';

class ThemeModel extends ChangeNotifier {
  final CommonAPI bridge = CommonAPI();
  late Timer timer;
  ThemeMode _mode = ThemeMode.light;

  ThemeMode get mode => _mode;

  ThemeModel() {
    timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      ThemeMode newMode =
          bridge.getLightMode() ? ThemeMode.light : ThemeMode.dark;
      if (newMode != _mode) {
        _mode = newMode;
        notifyListeners();
      }
    });
  }

  void toggleTheme() {
    _mode = _mode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}
