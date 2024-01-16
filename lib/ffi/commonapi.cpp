#ifndef EXTERNC
# define EXPORT extern "C" __attribute__((visibility("default"))) __attribute__((used))
#endif

#include <iostream>
#include <thread>
#include <mutex>
#include <CommonAPI/CommonAPI.hpp>
#include <CommonAPI/AttributeCacheExtension.hpp>

#include <v0/commonapi/HeadUnitProxy.hpp>

std::shared_ptr<CommonAPI::Runtime> runtime;

std::shared_ptr<typename CommonAPI::DefaultAttributeProxyHelper<v0::commonapi::HeadUnitProxy, CommonAPI::Extensions::AttributeCacheExtension>::class_t> huProxy;

static std::mutex _mutex;
static bool _lightmode;
static v0::commonapi::HeadUnit::MetaData _metadata;

struct metadata {
	uint8_t* albumcover;
	size_t image_size;
	char* artist;
	char* title;
};

void buildSpeedSensorProxy(void);
void buildCarControlProxy(void);
void buildCarInfoProxy(void);

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

	buildCarControlProxy();

	buildCarInfoProxy();

	instance = "commonapi.HeadUnit";
	huProxy = runtime->buildProxyWithDefaultAttributeExtension<v0::commonapi::HeadUnitProxy, CommonAPI::Extensions::AttributeCacheExtension>(domain, instance, connection);
	std::cout << "Waiting for service to become available." << std::endl;
	while (!huProxy->isAvailable()) {
		std::this_thread::sleep_for(std::chrono::microseconds(10));
	}
	std::cout << "HeadUnit service is available" << std::endl;
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