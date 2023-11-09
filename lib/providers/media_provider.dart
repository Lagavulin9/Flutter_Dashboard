import 'package:flutter/material.dart';

class MediaModel extends ChangeNotifier {
  Image _image = Image.asset(
    'assets/unknown-album.png',
    fit: BoxFit.cover,
  );
  String _title = "We don't talk anymore";
  String _artist = "Charlie Puth";

  Image get image => _image;
  String get title => _title;
  String get artist => _artist;
}
