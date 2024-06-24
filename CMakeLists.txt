cmake_minimum_required(VERSION 3.0)
project(ffi LANGUAGES CXX C)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++14")

find_package(CommonAPI 3.2.0 REQUIRED)

include_directories(
  ./lib/ffi/src-gen/core
  ./lib/ffi/src-gen/someip
)

add_library(myffi
  SHARED
  ./lib/ffi/src/commonapi.cpp
  ./lib/ffi/src/CarControlProxy.cpp
  ./lib/ffi/src/CarInfoProxy.cpp
  ./lib/ffi/src/HeadUnitProxy.cpp
  ./lib/ffi/src/CanTransceiverProxy.cpp
)
target_link_libraries(myffi CommonAPI)

### Library Sources ###
FILE(GLOB CANTRANSCEIVER_LIB_SRCS ./lib/ffi/src-gen/someip/v0/commonapi/CanTransceiver*.cpp)
add_library(CanTransceiver-someip SHARED ${CANTRANSCEIVER_LIB_SRCS})
target_link_libraries(CanTransceiver-someip CommonAPI CommonAPI-SomeIP)

FILE(GLOB CARCONTROL_LIB_SRCS ./lib/ffi/src-gen/someip/v0/commonapi/CarControl*.cpp)
add_library(CarControl-someip SHARED ${CARCONTROL_LIB_SRCS})
target_link_libraries(CarControl-someip CommonAPI CommonAPI-SomeIP)

FILE(GLOB CARINFO_LIB_SRCS ./lib/ffi/src-gen/someip/v0/commonapi/CarInfo*.cpp)
add_library(CarInfo-someip SHARED ${CARINFO_LIB_SRCS})
target_link_libraries(CarInfo-someip CommonAPI CommonAPI-SomeIP)

FILE(GLOB HEADUNIT_LIB_SRCS ./lib/ffi/src-gen/someip/v0/commonapi/HeadUnit*.cpp)
add_library(HeadUnit-someip SHARED ${HEADUNIT_LIB_SRCS})
target_link_libraries(HeadUnit-someip CommonAPI CommonAPI-SomeIP)

# Include GNUInstallDirs to use standard install directories
include(GNUInstallDirs)

# Install libraries
install(TARGETS myffi CanTransceiver-someip CarControl-someip CarInfo-someip HeadUnit-someip
        LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR})
