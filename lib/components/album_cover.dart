import 'package:flutter/material.dart';
import 'package:flutter_dashboard/providers/media_provider.dart';
import 'package:provider/provider.dart';

class AlbumCover extends StatelessWidget {
  const AlbumCover({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(boxShadow: const [
        BoxShadow(color: Colors.black38, offset: Offset(2, 4), blurRadius: 4)
      ], borderRadius: BorderRadius.circular(10)),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Consumer<MediaModel>(
              builder: (context, model, child) => model.image)),
    );
  }
}
