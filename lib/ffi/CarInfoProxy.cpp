#ifndef EXTERNC
# define EXPORT extern "C" __attribute__((visibility("default"))) __attribute__((used))
#endif

#include <thread>
#include <iostream>
#include <CommonAPI/CommonAPI.hpp>
#include <CommonAPI/AttributeCacheExtension.hpp>
#include <v0/commonapi/CarInfoProxy.hpp>

using namespace v0::commonapi;

std::shared_ptr<typename CommonAPI::DefaultAttributeProxyHelper<CarInfoProxy, CommonAPI::Extensions::AttributeCacheExtension>::class_t> ciProxy;
CarInfo::batteryStruct	_carinfo;
std::mutex				_infoMutex;

struct BatteryStruct {
	double vol;
	double cur;
	double pwr;
	double bat;
};

void buildCarInfoProxy()
{
	std::shared_ptr<CommonAPI::Runtime> runtime = CommonAPI::Runtime::get();

	std::string domain = "local";
	std::string instance = "commonapi.CarInfo";
	std::string connection = "client-sample";

	ciProxy = runtime->buildProxyWithDefaultAttributeExtension<v0::commonapi::CarInfoProxy, CommonAPI::Extensions::AttributeCacheExtension>(domain, instance, connection);
	std::cout << "Waiting for service to become available." << std::endl;
	while (!ciProxy->isAvailable()) {
		std::this_thread::sleep_for(std::chrono::microseconds(10));
	}
	std::cout << "CarInfo service is available" << std::endl;

	CommonAPI::CallStatus callStatus;
	CommonAPI::CallInfo info(1000);
	info.sender_ = 5678;
	ciProxy->getBatteryAttribute().getValue(callStatus, _carinfo, &info);
	if (callStatus != CommonAPI::CallStatus::SUCCESS) {
		std::cerr << "Remote call A failed!\n";
		return;
	}
}

EXPORT
void subscribe_info()
{
	ciProxy->getBatteryAttribute().getChangedEvent().subscribe([&](const CarInfo::batteryStruct& val){
		std::cout << "Received value->"
		<< "vol: " << val.getVoltage()
		<< ", cur: " << val.getCurrent()
		<< ", pwr: " << val.getConsumption()
		<< ", bat: " << val.getLevel()
		<< std::endl;
		{
			std::lock_guard<std::mutex> lock(_infoMutex);
			_carinfo = val;
		}
	});
}

EXPORT
BatteryStruct getInfo()
{
	std::lock_guard<std::mutex> lock(_infoMutex);
	BatteryStruct ret = { 
		_carinfo.getVoltage(),
		_carinfo.getCurrent(),
		_carinfo.getConsumption(),
		_carinfo.getLevel()
	};
	return ret;
}