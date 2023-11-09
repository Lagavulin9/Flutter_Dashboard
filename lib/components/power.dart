import 'package:flutter/material.dart';
import 'package:flutter_dashboard/providers/car_info_provider.dart';
import 'package:provider/provider.dart';

class Power extends StatelessWidget {
  const Power({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CarInfoModel>(
      builder: (context, model, child) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "${model.power.round()}",
            style: TextStyle(fontSize: 100, fontWeight: FontWeight.bold),
          ),
          Text(
            "W",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
