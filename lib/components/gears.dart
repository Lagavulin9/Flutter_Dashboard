import 'package:flutter/material.dart';
import 'package:flutter_dashboard/providers/control_provider.dart';
import 'package:provider/provider.dart';

class Gears extends StatelessWidget {
  const Gears({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: Consumer<ControlModel>(
        builder: (context, model, child) {
          final List<String> _gears = ["P", "R", "N", "D"];
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: _gears.map((gear) {
              if (gear == model.gear) {
                return Text(
                  gear,
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                );
              } else {
                return Text(
                  gear,
                  style: Theme.of(context).textTheme.labelMedium,
                );
              }
            }).toList(),
          );
        },
      ),
    );
  }
}
