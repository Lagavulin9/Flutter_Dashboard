import 'package:flutter/material.dart';

class AlertModel extends ChangeNotifier {
  bool _signalLost = false;
  bool _lowBattery = false;
  bool _sensorLost = false;
  bool _whatever = false;

  bool get signalLost => _signalLost;
  bool get lowBattery => _lowBattery;
  bool get sensorLost => _sensorLost;
  bool get whatever => _whatever;
}
