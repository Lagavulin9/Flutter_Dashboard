import 'package:flutter/material.dart';

class CarInfo extends StatefulWidget {
  const CarInfo({super.key});

  @override
  State<CarInfo> createState() => _CarInfoState();
}

class _CarInfoState extends State<CarInfo> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text("battery"),
        Text("Power"),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [Text("volt"), Text("cur")],
        )
      ],
    );
  }
}
