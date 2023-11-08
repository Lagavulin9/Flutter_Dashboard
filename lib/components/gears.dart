import 'package:flutter/material.dart';

class Gears extends StatefulWidget {
  const Gears({super.key});

  @override
  State<Gears> createState() => _GearsState();
}

class _GearsState extends State<Gears> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [Text("P"), Text("R"), Text("N"), Text("D")],
    );
  }
}
