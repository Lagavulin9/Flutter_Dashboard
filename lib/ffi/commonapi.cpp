#define EXPORT extern "C" __attribute__((visibility("default"))) __attribute__((used))

#include <iostream>
#include <thread>
#include <mutex>
#include <CommonAPI/CommonAPI.hpp>
#include <CommonAPI/AttributeCacheExtension.hpp>
#include <v1/commonapi/speedsensor/SpeedSensorProxy.hpp>

using namespace v1::commonapi::speedsensor;

std::shared_ptr<CommonAPI::Runtime> runtime;
std::shared_ptr<typename CommonAPI::DefaultAttributeProxyHelper<SpeedSensorProxy, CommonAPI::Extensions::AttributeCacheExtension>::class_t> ssProxy;

static int _speed;
static std::mutex _mutex;

EXPORT
void init()
{
	std::cout << "init called" << std::endl;

	CommonAPI::Runtime::setProperty("LogContext", "Headunit");
	CommonAPI::Runtime::setProperty("LogApplication", "HeadUnit");
	CommonAPI::Runtime::setProperty("LibraryBase", "speedsensor");
	runtime = CommonAPI::Runtime::get();

	std::string domain = "local";
	std::string instance = "commonapi.speedsensor.SpeedSensor";
	std::string connection = "client-sample";

	ssProxy = runtime->buildProxyWithDefaultAttributeExtension<SpeedSensorProxy, CommonAPI::Extensions::AttributeCacheExtension>(domain, instance, connection);

	std::cout << "Waiting for service to become available." << std::endl;
	while (!ssProxy->isAvailable()) {
		std::this_thread::sleep_for(std::chrono::microseconds(10));
	}

	std::cout << "SpeedSensor service is available" << std::endl;
}

EXPORT
void subscribe()
{
	CommonAPI::CallStatus callStatus;
	CommonAPI::CallInfo info(1000);
	info.sender_ = 5678;
	ssProxy->getSpeedAttribute().getValue(callStatus, _speed, &info);
	if (callStatus != CommonAPI::CallStatus::SUCCESS) {
		std::cerr << "Remote call A failed!\n";
		return;
	}
	std::cout << "Got attribute value: " << _speed << std::endl;
	ssProxy->getSpeedAttribute().getChangedEvent().subscribe([&](const int& val){
		std::cout << "Received speed: " << val << std::endl;
		{
			std::lock_guard<std::mutex> lock(_mutex);
			_speed = val;
		}
	});
	std::cout << "subscribed" << std::endl;
}

EXPORT
int getSpeed()
{
	std::lock_guard<std::mutex> lock(_mutex);
	return _speed;
}
