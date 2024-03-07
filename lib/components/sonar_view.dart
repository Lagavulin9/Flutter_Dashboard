import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dashboard/components/arc_painter.dart';
import 'package:flutter_dashboard/providers/sonar_provider.dart';

class SonarView extends StatelessWidget {
  const SonarView({required this.model});
  final SonarModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 100),
        CustomPaint(
          painter: ArcPainter(model: model),
        ),
        SizedBox(
            width: 80,
            height: 80,
            child: Image.asset(
              'assets/top_view.png',
              fit: BoxFit.scaleDown,
            ))
      ],
    );
  }
}
