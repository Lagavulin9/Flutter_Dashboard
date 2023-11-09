import 'package:flutter/material.dart';

class SpeedModel extends ChangeNotifier {
  double _speed = 100.12;
  double _rpm = 123.312;

  int get speed => _speed.round();
  int get rpm => _rpm.round();
}
