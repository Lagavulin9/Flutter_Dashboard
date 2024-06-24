#ifndef EXTERNC
# define EXPORT extern "C" __attribute__((visibility("default"))) __attribute__((used))
#endif

#include <thread>
#include <iostream>
#include <CommonAPI/CommonAPI.hpp>
#include <CommonAPI/AttributeCacheExtension.hpp>
#include <v0/commonapi/SpeedSensorProxy.hpp>

using namespace v0::commonapi;

std::shared_ptr<typename CommonAPI::DefaultAttributeProxyHelper<SpeedSensorProxy, CommonAPI::Extensions::AttributeCacheExtension>::class_t> ssProxy;
std::atomic<unsigned int>	_speed(0);

void buildSpeedSensorProxy()
{
	std::shared_ptr<CommonAPI::Runtime> runtime = CommonAPI::Runtime::get();

	std::string domain = "local";
	std::string instance = "commonapi.SpeedSensor";
	std::string connection = "client-sample";

	ssProxy = runtime->buildProxyWithDefaultAttributeExtension<SpeedSensorProxy, CommonAPI::Extensions::AttributeCacheExtension>(domain, instance, connection);
	// std::cout << "Waiting for service to become available." << std::endl;
	// while (!ssProxy->isAvailable()) {
	// 	std::this_thread::sleep_for(std::chrono::microseconds(10));
	// }
	// std::cout << "SpeedSensor service is available" << std::endl;

	// initialize value
	CommonAPI::CallStatus callStatus;
	CommonAPI::CallInfo info(1000);
	info.sender_ = 5678;
	unsigned int response;
	ssProxy->getSpeedAttribute().getValue(callStatus, response, &info);
	if (callStatus != CommonAPI::CallStatus::SUCCESS) {
		std::cerr << "Remote call A failed!\n";
		return;
	}
	std::cout << "Got attribute value: " << response << std::endl;
	_speed = response;
}

EXPORT 
void subscribe_speed()
{
	// subscribe and attatch callback function
	ssProxy->getSpeedAttribute().getChangedEvent().subscribe([&](const int& val){
		//std::cout << "Received speed: " << val << std::endl;
		_speed = val;
	});
	std::cout << "SpeedSensor subscribed" << std::endl;
}

EXPORT
int getSpeed()
{
	return _speed;
}