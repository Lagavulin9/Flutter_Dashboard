#ifndef EXTERNC
# define EXPORT extern "C" __attribute__((visibility("default"))) __attribute__((used))
#endif

#include <iostream>
#include <thread>
#include <mutex>
#include <CommonAPI/CommonAPI.hpp>
#include <CommonAPI/AttributeCacheExtension.hpp>

#include <v0/commonapi/CarControlProxy.hpp>
#include <v0/commonapi/CarInfoProxy.hpp>
#include <v0/commonapi/HeadUnitProxy.hpp>

std::shared_ptr<CommonAPI::Runtime> runtime;
std::shared_ptr<typename CommonAPI::DefaultAttributeProxyHelper<v0::commonapi::CarControlProxy, CommonAPI::Extensions::AttributeCacheExtension>::class_t> ccProxy;
std::shared_ptr<typename CommonAPI::DefaultAttributeProxyHelper<v0::commonapi::CarInfoProxy, CommonAPI::Extensions::AttributeCacheExtension>::class_t> ciProxy;
std::shared_ptr<typename CommonAPI::DefaultAttributeProxyHelper<v0::commonapi::HeadUnitProxy, CommonAPI::Extensions::AttributeCacheExtension>::class_t> huProxy;

static std::string _gear;
static v0::commonapi::CarInfo::batteryStruct _carinfo;
static std::string _indicator;
static std::mutex _mutex;
static bool _lightmode;
static v0::commonapi::HeadUnit::MetaData _metadata;

struct carinfo {
	double vol;
	double cur;
	double pwr;
	double bat;
};

struct metadata {
	uint8_t* albumcover;
	size_t image_size;
	char* artist;
	char* title;
};

void buildSpeedSensorProxy(void);

EXPORT
void init()
{
	std::cout << "init called" << std::endl;

	CommonAPI::Runtime::setProperty("LogContext", "InstrumentCluster");
	CommonAPI::Runtime::setProperty("LogApplication", "InstrumentCluster");
	//CommonAPI::Runtime::setProperty("LibraryBase", "speedsensor");
	runtime = CommonAPI::Runtime::get();

	std::string domain = "local";
	std::string instance = "commonapi.SpeedSensor";
	std::string connection = "client-sample";

	buildSpeedSensorProxy();

	instance = "commonapi.CarControl";
	ccProxy = runtime->buildProxyWithDefaultAttributeExtension<v0::commonapi::CarControlProxy, CommonAPI::Extensions::AttributeCacheExtension>(domain, instance, connection);
	std::cout << "Waiting for service to become available." << std::endl;
	while (!ccProxy->isAvailable()) {
		std::this_thread::sleep_for(std::chrono::microseconds(10));
	}
	std::cout << "CarControl service is available" << std::endl;


	instance = "commonapi.CarInfo";
	ciProxy = runtime->buildProxyWithDefaultAttributeExtension<v0::commonapi::CarInfoProxy, CommonAPI::Extensions::AttributeCacheExtension>(domain, instance, connection);
	std::cout << "Waiting for service to become available." << std::endl;
	while (!ciProxy->isAvailable()) {
		std::this_thread::sleep_for(std::chrono::microseconds(10));
	}
	std::cout << "CarInfo service is available" << std::endl;

	instance = "commonapi.HeadUnit";
	huProxy = runtime->buildProxyWithDefaultAttributeExtension<v0::commonapi::HeadUnitProxy, CommonAPI::Extensions::AttributeCacheExtension>(domain, instance, connection);
	std::cout << "Waiting for service to become available." << std::endl;
	while (!huProxy->isAvailable()) {
		std::this_thread::sleep_for(std::chrono::microseconds(10));
	}
	std::cout << "HeadUnit service is available" << std::endl;
}

EXPORT
void subscribe_control()
{
	CommonAPI::CallStatus callStatus;
	CommonAPI::CallInfo info(1000);
	info.sender_ = 5678;
	ccProxy->getGearAttribute().getValue(callStatus, _gear, &info);
	if (callStatus != CommonAPI::CallStatus::SUCCESS) {
		std::cerr << "Remote call A failed!\n";
		return;
	}
	std::cout << "Got attribute value: " << _gear << std::endl;
	ccProxy->getGearAttribute().getChangedEvent().subscribe([&](const std::string& val){
		std::cout << "Received gear: " << val << std::endl;
		{
			std::lock_guard<std::mutex> lock(_mutex);
			_gear = val;
		}
	});
	
	ccProxy->getIndicatorAttribute().getValue(callStatus, _indicator, &info);
	if (callStatus != CommonAPI::CallStatus::SUCCESS) {
		std::cerr << "Remote call A failed!\n";
		return;
	}
	std::cout << "Got attribute value: " << _indicator << std::endl;
	ccProxy->getIndicatorAttribute().getChangedEvent().subscribe([&](const std::string& val){
		std::cout << "Received indicator: " << val << std::endl;
		{
			std::lock_guard<std::mutex> lock(_mutex);
			_indicator = val;
		}
	});
	std::cout << "subscribed" << std::endl;
}

EXPORT
void subscribe_info()
{
	CommonAPI::CallStatus callStatus;
	CommonAPI::CallInfo info(1000);
	info.sender_ = 5678;
	ciProxy->getBatteryAttribute().getValue(callStatus, _carinfo, &info);
	if (callStatus != CommonAPI::CallStatus::SUCCESS) {
		std::cerr << "Remote call A failed!\n";
		return;
	}
	ciProxy->getBatteryAttribute().getChangedEvent().subscribe([&](const v0::commonapi::CarInfo::batteryStruct& val){
			std::cout << "Received value->"
			<< "vol: " << val.getVoltage()
			<< ", cur: " << val.getCurrent()
			<< ", pwr: " << val.getConsumption()
			<< ", bat: " << val.getLevel()
			<< std::endl;
		{
			std::lock_guard<std::mutex> lock(_mutex);
			_carinfo = val;
		}
	});
}

EXPORT
void subscribe_theme()
{
	CommonAPI::CallStatus callStatus;
	CommonAPI::CallInfo info(1000);
	info.sender_ = 5678;
	huProxy->getLightModeAttribute().getChangedEvent().subscribe([&](const bool& val) {
		std::cout << "Theme changed. LightMode? " << val << std::endl;
		{
			std::lock_guard<std::mutex> lock(_mutex);
			_lightmode = val;
		}
	});
}

EXPORT
void subscribe_metadata()
{
	CommonAPI::CallStatus callStatus;
	CommonAPI::CallInfo info(1000);
	info.sender_ = 5678;
	huProxy->getMetadataAttribute().getValue(callStatus, _metadata, &info);
	if (callStatus != CommonAPI::CallStatus::SUCCESS) {
		std::cerr << "Remote call A failed!\n";
		return;
	}
	huProxy->getMetadataAttribute().getChangedEvent().subscribe([&](const v0::commonapi::HeadUnit::MetaData& _val){
		std::cout << "New metadata" << std::endl;
		{
			std::lock_guard<std::mutex> lock(_mutex);
			_metadata = _val;
		}
	});
}

EXPORT
const char* getGear()
{
	std::lock_guard<std::mutex> lock(_mutex);
	return _gear.c_str();
}

EXPORT
const char* getIndicator()
{
	std::lock_guard<std::mutex> lock(_mutex);
	return _indicator.c_str();
}

EXPORT
carinfo getInfo()
{
	std::lock_guard<std::mutex> lock(_mutex);
	carinfo ret = {
		_carinfo.getVoltage(),\
		_carinfo.getCurrent(),\
		_carinfo.getConsumption(),\
		_carinfo.getLevel()\
	};
	return ret;
}

EXPORT
bool getLightMode()
{
	std::lock_guard<std::mutex> lock(_mutex);
	return _lightmode;
}

EXPORT
metadata getMetaData()
{
	std::lock_guard<std::mutex> lock(_mutex);
	metadata ret = {
		(unsigned char*)_metadata.getAlbumcover().data(),
		_metadata.getAlbumcover().size(),
		(char*)_metadata.getArtist().c_str(),
		(char*)_metadata.getTitle().c_str()
	};
	return ret;
}