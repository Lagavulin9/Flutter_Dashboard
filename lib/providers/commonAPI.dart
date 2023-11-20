import 'dart:ffi';

class CommonAPI {
  static final CommonAPI _instance = CommonAPI._privateConstructor();
  late final DynamicLibrary libffi;
  late final Function _init;
  late final Function _subscribe;
  late final Function getSpeed;

  bool _initializeFFI() {
    libffi = DynamicLibrary.open("libffi.so");
    _init = libffi
        .lookup<NativeFunction<Void Function()>>('init')
        .asFunction<void Function()>();
    _subscribe = libffi
        .lookup<NativeFunction<Void Function()>>('subscribe')
        .asFunction<void Function()>();
    getSpeed = libffi
        .lookup<NativeFunction<Int32 Function()>>('getSpeed')
        .asFunction<int Function()>();
    return true;
  }

  CommonAPI._privateConstructor() {
    _initializeFFI();
    _init();
    _subscribe();
  }

  factory CommonAPI() {
    return _instance;
  }
}
