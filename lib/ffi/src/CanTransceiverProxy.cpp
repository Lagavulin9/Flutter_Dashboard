#ifndef EXTERNC
# define EXPORT extern "C" __attribute__((visibility("default"))) __attribute__((used))
#endif

#include <thread>
#include <mutex>
#include <iostream>
#include <CommonAPI/CommonAPI.hpp>
#include <CommonAPI/AttributeCacheExtension.hpp>
#include <v0/commonapi/CanTransceiverProxy.hpp>

using namespace v0::commonapi;

std::shared_ptr<typename CommonAPI::DefaultAttributeProxyHelper<CanTransceiverProxy, CommonAPI::Extensions::AttributeCacheExtension>::class_t> canProxy;
std::atomic<unsigned int>	_speed(0);
std::atomic<unsigned int>	_frontSonar(100);
std::atomic<unsigned int>	_rearSonar(100);

struct SonarStruct
{
	unsigned int front;
	unsigned int rear;
};

void buildCanTransceiverProxy()
{
	std::shared_ptr<CommonAPI::Runtime> runtime = CommonAPI::Runtime::get();

	std::string domain = "local";
	std::string instance = "commonapi.CanTransceiver";
	std::string connection = "client-sample";

	canProxy = runtime->buildProxyWithDefaultAttributeExtension<CanTransceiverProxy, CommonAPI::Extensions::AttributeCacheExtension>(domain, instance, connection);
	// std::cout << "Waiting for service to become available." << std::endl;
	// while (!canProxy->isAvailable()) {
	// 	std::this_thread::sleep_for(std::chrono::microseconds(10));
	// }
	// std::cout << "CanTrasnceiver service is available" << std::endl;

	// initialize value
	// CommonAPI::CallStatus callStatus;
	// CommonAPI::CallInfo info(1000);
	// info.sender_ = 5678;
	// unsigned int response;
	// canProxy->getSpeedAttribute().getValue(callStatus, response, &info);
	// if (callStatus != CommonAPI::CallStatus::SUCCESS) {
	// 	std::cerr << "Remote call A failed!\n";
	// 	return;
	// }
	// std::cout << "Got attribute value: " << response << std::endl;
	// _speed = response;
}

EXPORT 
void subscribe_speed()
{
	// subscribe and attatch callback function
	canProxy->getSpeedAttribute().getChangedEvent().subscribe([&](const int& val){
		//std::cout << "Received speed: " << val << std::endl;
		_speed = val;
	});
	std::cout << "CanTransceiver Speed subscribed" << std::endl;
}

EXPORT
void subscribe_sonar()
{
	// subscribe and attatch callback function
	canProxy->getSonarFrontAttribute().getChangedEvent().subscribe([&](const int& val){
		// std::cout << "Received sonar front: " << val << std::endl;
		_frontSonar = val;
	});
	canProxy->getSonarRearAttribute().getChangedEvent().subscribe([&](const int& val){
		// std::cout << "Received sonar rear: " << val << std::endl;
		_rearSonar = val;
	});
	std::cout << "CanTransceiver Sonar subscribed" << std::endl;
}

EXPORT
unsigned int getSpeed()
{
	return _speed;
}

EXPORT
unsigned int getSonarFront()
{
	return _frontSonar;
}

EXPORT
unsigned int getSonarRear()
{
	return _rearSonar;
}

EXPORT
SonarStruct getSonar()
{
	return {_frontSonar, _rearSonar};
}