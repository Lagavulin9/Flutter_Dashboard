import 'package:flutter/material.dart';

class Gears extends StatefulWidget {
  const Gears({super.key});

  @override
  State<Gears> createState() => _GearsState();
}

class _GearsState extends State<Gears> {
  final List<String> gears = ["P", "R", "N", "D"];
  final String selected = "P";

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: gears.map((gear) {
        return Text(
          gear,
          style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: gear == selected ? Colors.black : Colors.grey),
        );
      }).toList(),
    );
  }
}
