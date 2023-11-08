import 'package:flutter/material.dart';
import 'package:flutter_dashboard/main.dart';

class Indicator extends StatefulWidget {
  const Indicator({super.key});

  @override
  State<Indicator> createState() => _IndicatorState();
}

class _IndicatorState extends State<Indicator> {
  final double iconSize = 100;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: displayWidth,
        height: displayHeight,
        child: Stack(
          children: [
            Positioned(
                left: 50,
                top: (displayHeight - iconSize) / 2,
                child: Icon(
                  Icons.keyboard_arrow_left,
                  size: iconSize,
                )),
            Positioned(
                right: 50,
                top: (displayHeight - iconSize) / 2,
                child: Icon(
                  Icons.keyboard_arrow_right,
                  size: iconSize,
                ))
          ],
        ));
  }
}
