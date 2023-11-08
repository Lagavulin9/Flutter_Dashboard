import 'package:flutter/material.dart';
import 'package:flutter_dashboard/main.dart';

class MediaInfo extends StatefulWidget {
  const MediaInfo({super.key});

  @override
  State<MediaInfo> createState() => _MediaInfoState();
}

class _MediaInfoState extends State<MediaInfo> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DecoratedBox(
            decoration: BoxDecoration(boxShadow: const [
              BoxShadow(
                  color: Colors.black38, offset: Offset(2, 4), blurRadius: 4)
            ], borderRadius: BorderRadius.circular(10)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image(
                  width: 160,
                  height: 160,
                  image: AssetImage("assets/unknown-album.png")),
            )),
        SizedBox(height: 30),
        Column(
          children: [
            Text(
              "We don't talk anymore",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              "Charlie Puth",
              overflow: TextOverflow.ellipsis,
            ),
          ],
        )
      ],
    );
  }
}
