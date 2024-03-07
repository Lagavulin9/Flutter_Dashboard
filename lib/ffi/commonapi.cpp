#ifndef EXTERNC
# define EXPORT extern "C" __attribute__((visibility("default"))) __attribute__((used))
#endif

#include <iostream>
#include <thread>
#include <mutex>
#include <CommonAPI/CommonAPI.hpp>
#include <CommonAPI/AttributeCacheExtension.hpp>

std::shared_ptr<CommonAPI::Runtime> runtime;

void buildSpeedSensorProxy(void);
void buildCarControlProxy(void);
void buildCarInfoProxy(void);
void buildHeadUnitProxy(void);
void buildPDCProxy(void);

EXPORT
void init()
{
	std::cout << "init called" << std::endl;

	CommonAPI::Runtime::setProperty("LogContext", "InstrumentCluster");
	CommonAPI::Runtime::setProperty("LogApplication", "InstrumentCluster");

	buildSpeedSensorProxy();

	buildCarControlProxy();

	buildCarInfoProxy();

	buildHeadUnitProxy();

	buildPDCProxy();
}
