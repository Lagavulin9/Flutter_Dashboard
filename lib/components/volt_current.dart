import 'package:flutter/widgets.dart';
import 'package:flutter_dashboard/providers/car_info_provider.dart';
import 'package:provider/provider.dart';

class VolCur extends StatelessWidget {
  const VolCur({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CarInfoModel>(
      builder: (context, model, child) =>
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          model.volt.toStringAsFixed(1),
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const Text(
          " V",
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 20),
        Text(
          model.current.toStringAsFixed(1),
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const Text(
          " mA",
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        )
      ]),
    );
  }
}
