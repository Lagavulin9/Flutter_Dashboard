#ifndef EXTERNC
# define EXPORT extern "C" __attribute__((visibility("default"))) __attribute__((used))
#endif

#include <thread>
#include <iostream>
#include <CommonAPI/CommonAPI.hpp>
#include <CommonAPI/AttributeCacheExtension.hpp>
#include <v0/commonapi/HeadUnitProxy.hpp>

using namespace v0::commonapi;

std::shared_ptr<typename CommonAPI::DefaultAttributeProxyHelper<HeadUnitProxy, CommonAPI::Extensions::AttributeCacheExtension>::class_t> huProxy;
std::mutex _metaMutex;
std::atomic<bool> _lightmode(true);
std::atomic<bool> _metaUpdated(false);
HeadUnit::MetaData _metadata;

struct metadata {
	uint8_t* albumcover;
	size_t image_size;
	char* artist;
	char* title;
};

void buildHeadUnitProxy()
{
	std::shared_ptr<CommonAPI::Runtime> runtime = CommonAPI::Runtime::get();

	std::string domain = "local";
	std::string instance = "commonapi.HeadUnit";
	std::string connection = "client-sample";

	huProxy = runtime->buildProxyWithDefaultAttributeExtension<HeadUnitProxy, CommonAPI::Extensions::AttributeCacheExtension>(domain, instance, connection);
	// std::cout << "Waiting for service to become available." << std::endl;
	// while (!huProxy->isAvailable()) {
	// 	std::this_thread::sleep_for(std::chrono::microseconds(10));
	// }
	// std::cout << "HeadUnit service is available" << std::endl;

	// initialize value
	// CommonAPI::CallStatus callStatus;
	// CommonAPI::CallInfo info(1000);
	// info.sender_ = 5678;

	// bool response;
	// huProxy->getLightModeAttribute().getValue(callStatus, response, &info);
	// if (callStatus != CommonAPI::CallStatus::SUCCESS) {
	// 	std::cerr << "Remote call A failed!\n";
	// 	return;
	// }
	// std::cout << "Got attribute value: " << response << std::endl;
	// _lightmode = response;

	// huProxy->getMetadataAttribute().getValue(callStatus, _metadata, &info);
	// if (callStatus != CommonAPI::CallStatus::SUCCESS) {
	// 	std::cerr << "Remote call A failed!\n";
	// 	return;
	// }
}

EXPORT
void subscribe_theme()
{
	huProxy->getLightModeAttribute().getChangedEvent().subscribe([&](const bool& val) {
		std::cout << "Theme changed. LightMode? " << val << std::endl;
		_lightmode = val;
	});
	std::cout << "Theme subscribed" << std::endl;
}

EXPORT
void subscribe_metadata()
{
	huProxy->getMetadataAttribute().getChangedEvent().subscribe([&](const HeadUnit::MetaData& _val){
		std::cout << "New metadata" << std::endl;
		if (!_val.getAlbumcover().empty())
		{
			std::lock_guard<std::mutex> lock(_metaMutex);
			_metadata = _val;
			_metaUpdated = true;
		}
	});
	std::cout << "Metadata subscribed" << std::endl;
}

EXPORT
bool getLightMode()
{
	return _lightmode;
}

EXPORT
bool isMetaUpdated()
{
	return _metaUpdated;
}

EXPORT
metadata getMetaData()
{
	std::lock_guard<std::mutex> lock(_metaMutex);
	metadata meta = {
		(unsigned char*)_metadata.getAlbumcover().data(),
		_metadata.getAlbumcover().size(),
		(char*)_metadata.getArtist().c_str(),
		(char*)_metadata.getTitle().c_str()
	};
	_metaUpdated = false;
	return meta;
}