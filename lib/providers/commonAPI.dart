import 'dart:ffi';

import 'package:ffi/ffi.dart';

class CommonAPI {
  static final CommonAPI _instance = CommonAPI._privateConstructor();
  late final DynamicLibrary libffi;
  late final Function _init;
  late final Function _subscribe_speed;
  late final Function _subscribe_control;
  late final Function getSpeed;
  late final Function _getGearUtf8;
  late final Function _getIndicatorUtf8;

  bool _initializeFFI() {
    libffi = DynamicLibrary.open("libffi.so");
    _init = libffi
        .lookup<NativeFunction<Void Function()>>('init')
        .asFunction<void Function()>();
    _subscribe_speed = libffi
        .lookup<NativeFunction<Void Function()>>('subscribe_speed')
        .asFunction<void Function()>();
    _subscribe_control = libffi
        .lookup<NativeFunction<Void Function()>>('subscribe_control')
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
    return true;
  }

  CommonAPI._privateConstructor() {
    _initializeFFI();
    _init();
    _subscribe_speed();
    _subscribe_control();
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
}
