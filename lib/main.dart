import 'package:flutter/material.dart';
import 'package:flutter_dashboard/components/alerts.dart';
import 'package:flutter_dashboard/components/car_info.dart';
import 'package:flutter_dashboard/components/clock.dart';
import 'package:flutter_dashboard/components/gears.dart';
import 'package:flutter_dashboard/components/indicator.dart';
import 'package:flutter_dashboard/components/media_info.dart';
import 'package:flutter_dashboard/components/speedometer.dart';
import 'package:window_manager/window_manager.dart';

const double displayWidth = 1280;
const double displayHeight = 400;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
    size: Size(displayWidth, displayHeight),
    center: true,
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const Dashboard(),
    );
  }
}

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: displayWidth,
          height: displayHeight,
          child: Stack(
            children: [
              const Indicator(),
              Center(
                child: Row(
                  children: [
                    SizedBox(width: MediaQuery.sizeOf(context).width * 0.1),
                    SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.25,
                        child: const CarInfo()),
                    SizedBox(width: MediaQuery.sizeOf(context).width * 0.025),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width * 0.25,
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Alert(),
                          Speedometer(),
                          Gears(),
                        ],
                      ),
                    ),
                    SizedBox(width: MediaQuery.sizeOf(context).width * 0.025),
                    SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.25,
                        child: const Column(
                          children: [
                            SizedBox(height: 36),
                            Clock(size: 20),
                            SizedBox(height: 35),
                            MediaInfo(),
                          ],
                        )),
                    SizedBox(width: MediaQuery.sizeOf(context).width * 0.1),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
