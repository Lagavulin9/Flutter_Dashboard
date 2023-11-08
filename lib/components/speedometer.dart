import 'package:flutter/material.dart';

class Speedometer extends StatefulWidget {
  const Speedometer({super.key});

  @override
  State<Speedometer> createState() => _SpeedometerState();
}

class _SpeedometerState extends State<Speedometer> {
  @override
  Widget build(BuildContext context) {
    return Text("Speed");
  }
}
