import 'package:flutter/material.dart';
import 'package:flutter_dashboard/main.dart';
import 'package:flutter_dashboard/providers/control_provider.dart';
import 'package:provider/provider.dart';

// class Indicator extends StatefulWidget {
//   const Indicator({super.key, required this.indicator, required this.blink});

//   final String indicator;
//   final bool blink;

//   @override
//   State<Indicator> createState() => _IndicatorState();
// }

// class _IndicatorState extends State<Indicator> {
//   Timer? timer;
//   bool isOn = false;
//   final double iconSize = 100;

//   @override
//   void initState() {
//     debugPrint("isblink? ${widget.blink}");
//     if (widget.blink) {
//       timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//         isOn = !isOn;
//         setState(() {});
//       });
//     }
//     super.initState();
//   }

//   @override
//   void dispose() {
//     timer?.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//         width: displayWidth,
//         height: displayHeight,
//         child: Stack(
//           children: [
//             Positioned(
//                 left: 40,
//                 top: displayHeight / 2 - (iconSize * 0.7),
//                 child: widget.indicator == "Left" && isOn
//                     ? Icon(
//                         Icons.keyboard_arrow_left,
//                         size: iconSize,
//                       )
//                     : const SizedBox()),
//             Positioned(
//                 right: 40,
//                 top: displayHeight / 2 - (iconSize * 0.7),
//                 child: widget.indicator == "Right" && isOn
//                     ? Icon(
//                         Icons.keyboard_arrow_left,
//                         size: iconSize,
//                       )
//                     : const SizedBox())
//           ],
//         ));
//   }
// }

class Indicator extends StatelessWidget {
  const Indicator({super.key});
  final double iconSize = 100;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: displayWidth,
      height: displayHeight,
      child: Stack(children: [
        Positioned(
            left: 40,
            top: displayHeight / 2 - (iconSize * 0.7),
            child: Consumer<ControlModel>(
              builder: (context, model, child) {
                return model.indicator == "Left" && model.isBlink
                    ? Icon(
                        Icons.keyboard_arrow_left,
                        size: iconSize,
                      )
                    : const SizedBox();
              },
            )),
        Positioned(
            right: 40,
            top: displayHeight / 2 - (iconSize * 0.7),
            child: Consumer<ControlModel>(
              builder: (context, model, child) {
                return model.indicator == "Right" && model.isBlink
                    ? Icon(
                        Icons.keyboard_arrow_right,
                        size: iconSize,
                      )
                    : const SizedBox();
              },
            ))
      ]),
    );
  }
}
