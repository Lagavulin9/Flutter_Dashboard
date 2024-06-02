cmake_minimum_required(VERSION 3.0)
project(ffi LANGUAGES CXX C)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++14")

find_package(CommonAPI 3.2.0 REQUIRED)

include_directories(
  ./src-gen/core
  ./src-gen/someip
)

add_library(myffi
  SHARED
  ./src/commonapi.cpp
  ./src/CarControlProxy.cpp
  ./src/CarInfoProxy.cpp
  ./src/HeadUnitProxy.cpp
  ./src/CanTransceiverProxy.cpp
  # ./src/SpeedSensorProxy.cpp
  # ./src/ParkDistanceControlProxy.cpp
)
target_link_libraries(myffi CommonAPI)