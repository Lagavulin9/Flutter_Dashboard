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

### Library Sources ###
FILE(GLOB CANTRANSCEIVER_LIB_SRCS ./src-gen/someip/v0/commonapi/CanTransceiver*.cpp)
add_library(CanTransceiver-someip SHARED ${CANTRANSCEIVER_LIB_SRCS})
target_link_libraries(CanTransceiver-someip CommonAPI CommonAPI-SomeIP)

FILE(GLOB CARCONTROL_LIB_SRCS ./src-gen/someip/v0/commonapi/CarControl*.cpp)
add_library(CarControl-someip SHARED ${CARCONTROL_LIB_SRCS})
target_link_libraries(CarControl-someip CommonAPI CommonAPI-SomeIP)

FILE(GLOB CARINFO_LIB_SRCS ./src-gen/someip/v0/commonapi/CarInfo*.cpp)
add_library(CarInfo-someip SHARED ${CARINFO_LIB_SRCS})
target_link_libraries(CarInfo-someip CommonAPI CommonAPI-SomeIP)

FILE(GLOB HEADUNIT_LIB_SRCS ./src-gen/someip/v0/commonapi/HeadUnit*.cpp)
add_library(HeadUnit-someip SHARED ${HEADUNIT_LIB_SRCS})
target_link_libraries(HeadUnit-someip CommonAPI CommonAPI-SomeIP)
