import 'package:flutter/material.dart';

class CarInfoModel extends ChangeNotifier {
  double _volt = 11.2;
  double _current = 1.2;
  double _power = 13.2;
  double _battery = 0.712;

  double get volt => _volt;
  double get current => _current;
  double get power => _power;
  double get battery => _battery;
}
