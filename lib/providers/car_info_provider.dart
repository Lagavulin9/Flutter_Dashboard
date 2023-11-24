import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_dashboard/providers/commonAPI.dart';

class CarInfoModel extends ChangeNotifier {
  CommonAPI bridge = CommonAPI();
  late InfoStruct _info;
  Timer? timer;

  double get volt => _info.vol;
  double get current => _info.cur;
  double get power => _info.pwr;
  double get battery => _info.bat;

  CarInfoModel() {
    InfoStruct info = bridge.getInfo();
    _info = info;
    timer = Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      InfoStruct newInfo = bridge.getInfo();
      if (_info != newInfo) {
        _info = newInfo;
        notifyListeners();
      }
    });
  }
}
