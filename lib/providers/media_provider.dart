import 'dart:async';
import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dashboard/providers/commonAPI.dart';

class MediaModel extends ChangeNotifier {
  final CommonAPI bridge = CommonAPI();
  late Timer timer;
  Image _image = Image.asset(
    'assets/unknown-album.png',
    fit: BoxFit.cover,
  );
  String _title = "Unknown Title";
  String _artist = "Unknown Artist";

  MediaModel() {
    timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (bridge.isMetaUpdated()) {
        MetadataStruct newMeta = bridge.getMetaData();
        Uint8List rawBytes = newMeta.albumcover.asTypedList(newMeta.imageSize);
        String newArtist = newMeta.artist.toDartString();
        String newTitle = newMeta.title.toDartString();
        _image = Image.memory(rawBytes);
        _artist = newArtist;
        _title = newTitle;
        notifyListeners();
      }
    });
  }

  Image get image => _image;
  String get title => _title;
  String get artist => _artist;
}
