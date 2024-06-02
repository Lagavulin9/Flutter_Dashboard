#ifndef EXTERNC
# define EXPORT extern "C" __attribute__((visibility("default"))) __attribute__((used))
#endif

#include <thread>
#include <iostream>
#include <CommonAPI/CommonAPI.hpp>
#include <CommonAPI/AttributeCacheExtension.hpp>
#include <v0/commonapi/ParkDistanceControlProxy.hpp>

using namespace v0::commonapi;

std::shared_ptr<typename CommonAPI::DefaultAttributeProxyHelper<ParkDistanceControlProxy, CommonAPI::Extensions::AttributeCacheExtension>::class_t> pdcProxy;
ParkDistanceControl::SonarArrayStruct	_sonarArr;
std::mutex	_pdcMutex;

struct SonarStruct {
	unsigned int left;
	unsigned int middle;
	unsigned int right;
};

void buildPDCProxy()
{
	std::shared_ptr<CommonAPI::Runtime> runtime = CommonAPI::Runtime::get();

	std::string domain = "local";
	std::string instance = "commonapi.ParkDistanceControl";
	std::string connection = "client-sample";

	pdcProxy = runtime->buildProxyWithDefaultAttributeExtension<v0::commonapi::ParkDistanceControlProxy, CommonAPI::Extensions::AttributeCacheExtension>(domain, instance, connection);
	// std::cout << "Waiting for service to become available." << std::endl;
	// while (!pdcProxy->isAvailable()) {
	// 	std::this_thread::sleep_for(std::chrono::microseconds(10));
	// }
	// std::cout << "ParkDistanceControl service is available" << std::endl;

	CommonAPI::CallStatus callStatus;
	CommonAPI::CallInfo info(1000);
	info.sender_ = 5678;
	pdcProxy->getDistancesAttribute().getValue(callStatus, _sonarArr, &info);
	if (callStatus != CommonAPI::CallStatus::SUCCESS) {
		std::cerr << "Remote call A failed!\n";
		return;
	}
}

EXPORT
void subscribe_pdc()
{
	pdcProxy->getDistancesAttribute().getChangedEvent().subscribe([&](const ParkDistanceControl::SonarArrayStruct& val){
		std::cout << "Received value->"
		<< "left: " << val.getSensorfrontleft()
		<< ", middle: " << val.getSensorfrontmiddle()
		<< ", right: " << val.getSensorfrontright()
		<< std::endl;
		{
			std::lock_guard<std::mutex> lock(_pdcMutex);
			_sonarArr = val;
		}
	});
}

EXPORT
SonarStruct getSonar()
{
	std::lock_guard<std::mutex> lock(_pdcMutex);
	SonarStruct ret = { 
		_sonarArr.getSensorfrontleft(),
		_sonarArr.getSensorfrontmiddle(),
		_sonarArr.getSensorfrontright(),
	};
	return ret;
}