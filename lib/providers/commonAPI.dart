import 'dart:ffi';
import 'dart:typed_data';

import 'package:ffi/ffi.dart';

final class InfoStruct extends Struct {
  @Double()
  external double vol;
  @Double()
  external double cur;
  @Double()
  external double pwr;
  @Double()
  external double bat;
}

class CommonAPI {
  static final CommonAPI _instance = CommonAPI._privateConstructor();
  late final DynamicLibrary libffi;
  late final Function _init;
  late final Function _subscribeSpeed;
  late final Function _subscribeControl;
  late final Function _subscribeInfo;
  late final Function _subscribeTheme;
  late final Function _subscribeImage;
  late final Function getSpeed;
  late final Function _getGearUtf8;
  late final Function _getIndicatorUtf8;
  late final Function getInfo;
  late final Function getLightMode;
  late final Function _getImage;
  late final Function _getImageSize;

  bool _initializeFFI() {
    libffi = DynamicLibrary.open("libffi.so");
    _init = libffi
        .lookup<NativeFunction<Void Function()>>('init')
        .asFunction<void Function()>();
    _subscribeSpeed = libffi
        .lookup<NativeFunction<Void Function()>>('subscribe_speed')
        .asFunction<void Function()>();
    _subscribeControl = libffi
        .lookup<NativeFunction<Void Function()>>('subscribe_control')
        .asFunction<void Function()>();
    _subscribeInfo = libffi
        .lookup<NativeFunction<Void Function()>>('subscribe_info')
        .asFunction<void Function()>();
    _subscribeTheme = libffi
        .lookup<NativeFunction<Void Function()>>('subscribe_theme')
        .asFunction<void Function()>();
    _subscribeImage = libffi
        .lookup<NativeFunction<Void Function()>>('subscribe_image')
        .asFunction<void Function()>();
    getSpeed = libffi
        .lookup<NativeFunction<Int32 Function()>>('getSpeed')
        .asFunction<int Function()>();
    _getGearUtf8 = libffi
        .lookup<NativeFunction<Pointer<Utf8> Function()>>('getGear')
        .asFunction<Pointer<Utf8> Function()>();
    _getIndicatorUtf8 = libffi
        .lookup<NativeFunction<Pointer<Utf8> Function()>>('getIndicator')
        .asFunction<Pointer<Utf8> Function()>();
    getInfo = libffi
        .lookup<NativeFunction<InfoStruct Function()>>("getInfo")
        .asFunction<InfoStruct Function()>();
    getLightMode = libffi
        .lookup<NativeFunction<Bool Function()>>('getLightMode')
        .asFunction<bool Function()>();
    _getImage = libffi
        .lookup<NativeFunction<Pointer<Uint8> Function()>>('getImage')
        .asFunction<Pointer<Uint8> Function()>();
    _getImageSize = libffi
        .lookup<NativeFunction<Int Function()>>('getImageSize')
        .asFunction<int Function()>();
    return true;
  }

  CommonAPI._privateConstructor() {
    _initializeFFI();
    _init();
    _subscribeSpeed();
    _subscribeControl();
    _subscribeInfo();
    _subscribeTheme();
    _subscribeImage();
  }

  factory CommonAPI() {
    return _instance;
  }

  String getGear() {
    Pointer<Utf8> raw = _getGearUtf8();
    return raw.toDartString();
  }

  String getIndicator() {
    Pointer<Utf8> raw = _getIndicatorUtf8();
    return raw.toDartString();
  }

  Uint8List getImage() {
    Pointer<Uint8> rawImage = _getImage();
    if (rawImage == nullptr) {
      return Uint8List(0);
    }
    return rawImage.asTypedList(_getImageSize());
  }
}
