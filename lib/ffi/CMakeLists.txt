cmake_minimum_required(VERSION 3.0)
project(ffi LANGUAGES CXX C)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++14")

find_package(CommonAPI 3.2.0 REQUIRED)
find_package(CanReceiver-someip REQUIRED)
find_package(CarControl-someip REQUIRED)
find_package(CarInfo-someip REQUIRED)

include_directories(
  ./include
  /home/jinholee/Flutter_Head-Unit/lib/ffi/src-gen/core
  /home/jinholee/DummyAPI/cf/src-gen/core
  ${CARINFO_INCLUDE_DIRS}
  ${CARCONTROL_INCLUDE_DIRS}
  ${CANRECEIVER_INCLUDE_DIRS}
  ${COMMONAPI_INCLUDE_DIRS}
)

add_library(myffi
  SHARED
  commonapi.cpp
  SpeedSensorProxy.cpp
  CarControlProxy.cpp
  CarInfoProxy.cpp
  HeadUnitProxy.cpp
  ParkDistanceControlProxy.cpp
)
target_link_libraries(myffi CommonAPI)