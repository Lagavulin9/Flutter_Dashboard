# Flutter Dashboard
This project is part of DES_03_Head-Unit to provide instrument cluster feature.
Flutter was used to implement front end application.
It uses CommonAPI and SOME/IP binding as IPC

# Features
- Speedometer
- Current Gear
- Battery Info
- Clock
- Now Playing
- Turn Indicator
- Dark Mode

# Dendencies
All these applications should be installed in your build host to build this project
- [vSOME/IP](https://github.com/COVESA/vsomeip) v3.4.10
- [CommonAPI Core Runtime](https://github.com/COVESA/capicxx-core-runtime) v3.2.3
- [CommonAPI SOME/IP Runtime](https://github.com/COVESA/capicxx-someip-runtime) v3.2.3
- [CanReceiver](https://github.com/SeungWoo-L/can_receiver) 
- [CarControl](https://github.com/kianwasabi/car_control)
- [CarInfo](https://github.com/kianwasabi/car_info)
- [HeadUnit](https://github.com/Lagavulin9/Flutter_Head-Unit)


# How it works
This application uses CommonAPI plugin to communicate with other applications.
```mermaid
classDiagram
      Dashboard <|-- CanReceiver
      Dashboard <|-- CarControl
      Dashboard <|-- CarInfo
      Dashboard <|-- HeadUnit
      Dashboard : UInt32 speed
      Dashboard : String gear
      Dashboard : String indicator
      Dashboard : BatteryStruct battery
      Dashboard : bool lightMode
      Dashboard : MetaData metadata
      class CanReceiver{
          UInt32 rpm
          UInt32 speed
      }
      class CarControl{
          String gear
          String indicator
          gearSelectionHeadUnit(gear)
      }
      class CarInfo{
          BatteryStruct battery
      }
      class HeadUnit{
	      bool lightMode
	      MetaData metadata
      }
```
 Each of the applications listed above provide proxy which will make it possible to subscribe to it's attributes. Since flutter does not have CommonAPI related libraries like dbus, I had to make a workaround using Foreign Function Interface(FFI). I created my own wrapper code to use CommonAPI proxies and modified CMakeLists.txt so that my flutter app will generate ffi shared object and include it in the bundle.
Now, flutter can use proxies and will subscribes to all of the attributes from each applications listed on the diagram by using ffi plugin in ffi folder. Once subscribed, ChangeNotifier will check for new values and update flutter widgets.
