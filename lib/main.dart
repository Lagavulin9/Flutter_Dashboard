import 'package:flutter/material.dart';
import 'package:flutter_dashboard/components/album_cover.dart';
import 'package:flutter_dashboard/components/alerts.dart';
import 'package:flutter_dashboard/components/battery.dart';
import 'package:flutter_dashboard/components/clock.dart';
import 'package:flutter_dashboard/components/gears.dart';
import 'package:flutter_dashboard/components/indicator.dart';
import 'package:flutter_dashboard/components/media_info.dart';
import 'package:flutter_dashboard/components/power.dart';
import 'package:flutter_dashboard/components/speedometer.dart';
import 'package:flutter_dashboard/components/volt_current.dart';
import 'package:flutter_dashboard/providers/alert_provider.dart';
import 'package:flutter_dashboard/providers/car_info_provider.dart';
import 'package:flutter_dashboard/providers/control_provider.dart';
import 'package:flutter_dashboard/providers/media_provider.dart';
import 'package:flutter_dashboard/providers/sonar_provider.dart';
import 'package:flutter_dashboard/providers/speed_provider.dart';
import 'package:flutter_dashboard/providers/theme_provider.dart';
import 'package:provider/provider.dart';

const double displayWidth = 1280;
const double displayHeight = 400;
void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CarInfoModel()),
        ChangeNotifierProvider(create: (context) => SpeedModel()),
        ChangeNotifierProvider(create: (context) => ControlModel()),
        ChangeNotifierProvider(create: (context) => MediaModel()),
        ChangeNotifierProvider(create: (context) => AlertModel()),
        ChangeNotifierProvider(create: (context) => ThemeModel()),
        ChangeNotifierProvider(create: (context) => SonarModel())
      ],
      child: Consumer<ThemeModel>(
        builder: (context, model, child) => MaterialApp(
          title: 'Dashboard',
          theme: ThemeData(
            colorScheme: const ColorScheme.light(
                background: Color.fromRGBO(0xe1, 0xe1, 0xe1, 1)),
            textTheme: Typography.blackCupertino.copyWith(
                labelMedium: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade400)),
            useMaterial3: true,
          ),
          darkTheme: ThemeData(
            colorScheme: const ColorScheme.dark(),
            textTheme: Typography.whiteCupertino.copyWith(
                labelMedium: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade800)),
            useMaterial3: true,
          ),
          themeMode: model.mode,
          home: const Dashboard(),
        ),
      ),
    );
  }
}

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
          width: displayWidth,
          height: displayHeight,
          child: Stack(
            children: [
              const Indicator(),
              Center(
                child: SizedBox(
                    width: displayWidth * 0.85,
                    height: displayHeight,
                    child: Table(
                      children: [
                        const TableRow(children: [
                          SizedBox(height: 25),
                          SizedBox(height: 25),
                          SizedBox(height: 25)
                        ]),
                        const TableRow(children: [
                          SizedBox(height: 40, child: Center(child: Battery())),
                          SizedBox(height: 40, child: Center(child: Alert())),
                          SizedBox(
                              height: 40, child: Center(child: Clock(size: 22)))
                        ]),
                        TableRow(children: [
                          const SizedBox(
                              height: 240, child: Center(child: Power())),
                          const SizedBox(
                              height: 240, child: Center(child: Speedometer())),
                          SizedBox(
                              height: 240,
                              child: Center(
                                  child: Consumer<SonarModel>(
                                      builder: (context, model, child) =>
                                          model.tooClose
                                              ? Container(color: Colors.amber)
                                              : const AlbumCover())))
                        ]),
                        const TableRow(children: [
                          SizedBox(height: 50, child: Center(child: VolCur())),
                          SizedBox(height: 50, child: Center(child: Gears())),
                          SizedBox(
                              height: 50, child: Center(child: MediaInfo()))
                        ])
                      ],
                    )),
              )
            ],
          )),
    );
  }
}
