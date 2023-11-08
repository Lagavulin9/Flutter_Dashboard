import 'package:flutter/material.dart';
import 'package:flutter_dashboard/main.dart';

class Indicator extends StatefulWidget {
  const Indicator({super.key});

  @override
  State<Indicator> createState() => _IndicatorState();
}

class _IndicatorState extends State<Indicator> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: displayWidth,
        height: displayHeight,
        child: Stack(
          children: [
            Positioned(
                left: 50,
                top: displayHeight / 2 - 20,
                child: Icon(Icons.arrow_left)),
            Positioned(
                right: 50,
                top: displayHeight / 2 - 20,
                child: Icon(Icons.arrow_right))
          ],
        ));
  }
}
