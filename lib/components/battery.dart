import 'package:cupertino_battery_indicator/cupertino_battery_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dashboard/providers/car_info_provider.dart';
import 'package:provider/provider.dart';

class Battery extends StatelessWidget {
  const Battery({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CarInfoModel>(
      builder: (context, carInfo, child) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BatteryIndicator(
            value: carInfo.battery,
            trackHeight: 15,
          ),
          const SizedBox(width: 16),
          Text(
            "${(carInfo.battery * 100).round()}%",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
