import 'package:flutter/material.dart';
import 'package:flutter_dashboard/providers/alert_provider.dart';
import 'package:provider/provider.dart';

class Alert extends StatelessWidget {
  const Alert({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AlertModel>(
      builder: (context, model, child) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          model.sensorLost
              ? const Icon(Icons.sensors_off, size: 24, color: Colors.red)
              : const SizedBox(),
          model.lowBattery
              ? const Icon(Icons.battery_alert, size: 24, color: Colors.red)
              : const SizedBox(),
          model.sensorLost
              ? const Icon(Icons.car_crash, size: 24, color: Colors.red)
              : const SizedBox(),
          model.whatever
              ? const Icon(Icons.roundabout_left, size: 24, color: Colors.red)
              : const SizedBox()
        ],
      ),
    );
  }
}
