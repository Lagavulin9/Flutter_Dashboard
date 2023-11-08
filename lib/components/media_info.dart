import 'package:flutter/material.dart';

class MediaInfo extends StatefulWidget {
  const MediaInfo({super.key});

  @override
  State<MediaInfo> createState() => _MediaInfoState();
}

class _MediaInfoState extends State<MediaInfo> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [Text("album cover"), Text("title"), Text("artist")],
    );
  }
}
