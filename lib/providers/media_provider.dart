import 'dart:async';
import 'dart:typed_data';

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
  Uint8List prevBytes = Uint8List(0);

  MediaModel() {
    timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      Uint8List rawBytes = bridge.getImage();
      if (!listEquals(prevBytes, rawBytes)) {
        _image = rawBytes.isEmpty
            ? Image.asset(
                'assets/unknown-album.png',
                fit: BoxFit.cover,
              )
            : Image.memory(rawBytes);
        prevBytes = rawBytes;
        notifyListeners();
      }
    });
  }

  String _title = "We don't talk anymore";
  String _artist = "Charlie Puth";

  Image get image => _image;
  String get title => _title;
  String get artist => _artist;
}
