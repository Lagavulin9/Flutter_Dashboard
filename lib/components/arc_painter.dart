import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_dashboard/providers/sonar_provider.dart';

class ArcPainter extends CustomPainter {
  const ArcPainter({required this.offsetAngle, required this.model});
  final double offsetAngle;
  final SonarModel model;

  @override
  void paint(Canvas canvas, Size size) {
    const factor = 2.0;
    final sizes = [100, 75, 50].map((e) => e * factor).toList();
    final offsets = List.generate(sizes.length, (index) => -sizes[index] / 2);
    final offsetsAndSizes = List.generate(
        sizes.length,
        (index) =>
            Offset(offsets[index], offsets[index]) &
            Size(sizes[index], sizes[index]));
    var distance = 100;
    for (int i = 0; i < offsetsAndSizes.length; i++) {
      var color = i == 0 && distance < 30
          ? Colors.red
          : i == 1 && distance <= 15
              ? Colors.red
              : i == 2 && distance <= 5
                  ? Colors.red
                  : Colors.amber;
      canvas.drawArc(
        offsetsAndSizes[i],
        offsetAngle,
        math.pi / 2,
        false,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 5 * factor
          ..color = color,
      );
    }

    // var setProperties = [
    //   {
    //     'startAngle': -4 * math.pi / 24,
    //     'sweepAngle': -4 * math.pi / 24,
    //     'area': 'right',
    //   },
    //   {
    //     'startAngle': -9 * math.pi / 24,
    //     'sweepAngle': -6 * math.pi / 24,
    //     'area': 'middle',
    //   },
    //   {
    //     'startAngle': -16 * math.pi / 24,
    //     'sweepAngle': -4 * math.pi / 24,
    //     'area': 'left',
    //   },
    // ];

    // for (var setProps in setProperties) {
    //   const factor = 2.0;
    //   final sizes = [100, 75, 50].map((e) => e * factor).toList();
    //   final offsets = List.generate(sizes.length, (index) => -sizes[index] / 2);
    //   final offsetsAndSizes = List.generate(
    //       sizes.length,
    //       (index) =>
    //           Offset(offsets[index], offsets[index]) &
    //           Size(sizes[index], sizes[index]));
    //   var distance = setProps['area'] == 'left'
    //       ? model.left
    //       : setProps['area'] == 'middle'
    //           ? model.middle
    //           : model.right;
    //   for (int i = 0; i < offsetsAndSizes.length; i++) {
    //     var color = i == 0 && distance <= 30
    //         ? Colors.red
    //         : i == 1 && distance <= 20
    //             ? Colors.red
    //             : i == 2 && distance <= 10
    //                 ? Colors.red
    //                 : Colors.amber;
    //     canvas.drawArc(
    //       offsetsAndSizes[i],
    //       setProps['startAngle']! as double,
    //       setProps['sweepAngle']! as double,
    //       false,
    //       Paint()
    //         ..style = PaintingStyle.stroke
    //         ..strokeWidth = 5 * factor
    //         ..color = color,
    //     );
    //   }
    // }

    // canvas.drawArc(Offset(-50, -50) & Size(100, 100), -4 * math.pi / 24,
    //     -4 * math.pi / 24, false, paint1);
    // canvas.drawArc(Offset(-37.5, -37.5) & Size(75, 75), -4 * math.pi / 24,
    //     -4 * math.pi / 24, false, paint1);
    // canvas.drawArc(Offset(-25, -25) & Size(50, 50), -4 * math.pi / 24,
    //     -4 * math.pi / 24, false, paint2);

    // canvas.drawArc(Offset(-50, -50) & Size(100, 100), -9 * math.pi / 24,
    //     -6 * math.pi / 24, false, paint2);
    // canvas.drawArc(Offset(-37.5, -37.5) & Size(75, 75), -9 * math.pi / 24,
    //     -6 * math.pi / 24, false, paint2);
    // canvas.drawArc(Offset(-25, -25) & Size(50, 50), -9 * math.pi / 24,
    //     -6 * math.pi / 24, false, paint1);

    // canvas.drawArc(Offset(-50, -50) & Size(100, 100), -16 * math.pi / 24,
    //     -4 * math.pi / 24, false, paint1);
    // canvas.drawArc(Offset(-37.5, -37.5) & Size(75, 75), -16 * math.pi / 24,
    //     -4 * math.pi / 24, false, paint1);
    // canvas.drawArc(Offset(-25, -25) & Size(50, 50), -16 * math.pi / 24,
    //     -4 * math.pi / 24, false, paint2);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
