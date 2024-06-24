/*
 * This file was generated by the CommonAPI Generators.
 * Used org.genivi.commonapi.someip 3.2.14.v202310241606.
 * Used org.franca.core 0.13.1.201807231814.
 *
 * This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0.
 * If a copy of the MPL was not distributed with this file, You can obtain one at
 * http://mozilla.org/MPL/2.0/.
 */
#include <v0/commonapi/CarInfoSomeIPStubAdapter.hpp>
#include <v0/commonapi/CarInfo.hpp>

#if !defined (COMMONAPI_INTERNAL_COMPILATION)
#define COMMONAPI_INTERNAL_COMPILATION
#define HAS_DEFINED_COMMONAPI_INTERNAL_COMPILATION_HERE
#endif

#include <CommonAPI/SomeIP/AddressTranslator.hpp>

#if defined (HAS_DEFINED_COMMONAPI_INTERNAL_COMPILATION_HERE)
#undef COMMONAPI_INTERNAL_COMPILATION
#undef HAS_DEFINED_COMMONAPI_INTERNAL_COMPILATION_HERE
#endif

namespace v0 {
namespace commonapi {

std::shared_ptr<CommonAPI::SomeIP::StubAdapter> createCarInfoSomeIPStubAdapter(
                   const CommonAPI::SomeIP::Address &_address,
                   const std::shared_ptr<CommonAPI::SomeIP::ProxyConnection> &_connection,
                   const std::shared_ptr<CommonAPI::StubBase> &_stub) {
    return std::make_shared< CarInfoSomeIPStubAdapter<::v0::commonapi::CarInfoStub>>(_address, _connection, _stub);
}

void initializeCarInfoSomeIPStubAdapter() {
    CommonAPI::SomeIP::AddressTranslator::get()->insert(
        "local:commonapi.CarInfo:v0_1:commonapi.CarInfo",
         0x1388, 0x1389, 0, 1);
    CommonAPI::SomeIP::Factory::get()->registerStubAdapterCreateMethod(
        "commonapi.CarInfo:v0_1",
        &createCarInfoSomeIPStubAdapter);
}

INITIALIZER(registerCarInfoSomeIPStubAdapter) {
    CommonAPI::SomeIP::Factory::get()->registerInterface(initializeCarInfoSomeIPStubAdapter);
}

} // namespace commonapi
} // namespace v0
