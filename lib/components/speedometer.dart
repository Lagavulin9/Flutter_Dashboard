import 'package:flutter/material.dart';

class Speedometer extends StatefulWidget {
  const Speedometer({super.key});

  @override
  State<Speedometer> createState() => _SpeedometerState();
}

class _SpeedometerState extends State<Speedometer> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "100",
          style: const TextStyle(fontSize: 100, fontWeight: FontWeight.bold),
        ),
        Text("m/min",
            style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black54))
      ],
    );
  }
}
