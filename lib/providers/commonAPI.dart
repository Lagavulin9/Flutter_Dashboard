import 'dart:ffi';

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

final class MetadataStruct extends Struct {
  external Pointer<Uint8> albumcover;
  @Uint64()
  external int imageSize;
  external Pointer<Utf8> artist;
  external Pointer<Utf8> title;
}

final class SonarStruct extends Struct {
  @Uint32()
  external int front;
  @Uint32()
  external int rear;
}

class CommonAPI {
  static final CommonAPI _instance = CommonAPI._privateConstructor();
  late final DynamicLibrary libffi;
  late final Function _init;
  late final Function _subscribeSpeed;
  late final Function _subscribeControl;
  late final Function _subscribeInfo;
  late final Function _subscribeTheme;
  late final Function _subscribeMetadata;
  late final Function _subscribeSonar;
  late final Function getSpeed;
  late final Function _getGearUtf8;
  late final Function _getIndicatorUtf8;
  late final Function getInfo;
  late final Function getLightMode;
  late final Function getMetaData;
  late final Function getSonar;
  late final Function isMetaUpdated;

  bool _initializeFFI() {
    libffi = DynamicLibrary.open("libmyffi.so");
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
    _subscribeMetadata = libffi
        .lookup<NativeFunction<Void Function()>>('subscribe_metadata')
        .asFunction<void Function()>();
    _subscribeSonar = libffi
        .lookup<NativeFunction<Void Function()>>('subscribe_sonar')
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
    getMetaData = libffi
        .lookup<NativeFunction<MetadataStruct Function()>>('getMetaData')
        .asFunction<MetadataStruct Function()>();
    getSonar = libffi
        .lookup<NativeFunction<SonarStruct Function()>>('getSonar')
        .asFunction<SonarStruct Function()>();
    isMetaUpdated = libffi
        .lookup<NativeFunction<Bool Function()>>('isMetaUpdated')
        .asFunction<bool Function()>();
    return true;
  }

  CommonAPI._privateConstructor() {
    _initializeFFI();
    _init();
    _subscribeSpeed();
    _subscribeControl();
    _subscribeInfo();
    _subscribeTheme();
    _subscribeMetadata();
    _subscribeSonar();
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
