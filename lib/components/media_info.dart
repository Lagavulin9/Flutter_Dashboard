import 'package:flutter/material.dart';
import 'package:flutter_dashboard/providers/media_provider.dart';
import 'package:provider/provider.dart';

class MediaInfo extends StatelessWidget {
  const MediaInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MediaModel>(
        builder: (context, model, child) => Column(
              children: [
                Text(
                  model.title,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  model.artist,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w600),
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ));
  }
}
