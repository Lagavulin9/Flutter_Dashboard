import 'package:flutter/material.dart';
import 'package:flutter_dashboard/providers/speed_provider.dart';
import 'package:provider/provider.dart';

class Speedometer extends StatelessWidget {
  const Speedometer({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SpeedModel>(
      builder: (context, model, child) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "${model.speed}",
            style: const TextStyle(fontSize: 100, fontWeight: FontWeight.bold),
          ),
          const Text(
            "m/min",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
