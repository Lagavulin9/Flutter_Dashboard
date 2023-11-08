import 'package:cupertino_battery_indicator/cupertino_battery_indicator.dart';
import 'package:flutter/material.dart';

class CarInfo extends StatefulWidget {
  const CarInfo({super.key});

  @override
  State<CarInfo> createState() => _CarInfoState();
}

class _CarInfoState extends State<CarInfo> {
  double volt = 0;
  double current = 0;
  double power = 0;
  double battery = 0;

  @override
  void initState() {
    // TODO: implement initState
    volt = 11.1;
    current = 1.21;
    power = volt * current;
    battery = 0.711;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BatteryIndicator(
              value: battery,
              trackHeight: 16,
            ),
            const SizedBox(width: 20),
            Text(
              "${(battery * 100).round()}%",
              style: const TextStyle(fontWeight: FontWeight.bold),
            )
          ],
        ),
        Column(
          children: [
            Text(
              "${power.round()}",
              style:
                  const TextStyle(fontSize: 100, fontWeight: FontWeight.bold),
            ),
            const Text(
              "W",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              volt.toStringAsFixed(1),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 5),
            const Text("V",
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black54)),
            const SizedBox(width: 10),
            Text(
              current.toStringAsFixed(1),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 5),
            const Text("mA",
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black54))
          ],
        )
      ],
    );
  }
}
