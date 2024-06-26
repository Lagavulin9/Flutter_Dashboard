/*
* This file was generated by the CommonAPI Generators.
* Used org.genivi.commonapi.core 3.2.0.v202012010850.
* Used org.franca.core 0.13.1.201807231814.
*
* This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0.
* If a copy of the MPL was not distributed with this file, You can obtain one at
* http://mozilla.org/MPL/2.0/.
*/
#ifndef V0_COMMONAPI_Head_Unit_STUB_DEFAULT_HPP_
#define V0_COMMONAPI_Head_Unit_STUB_DEFAULT_HPP_


#include <CommonAPI/Export.hpp>

#include <v0/commonapi/HeadUnitStub.hpp>
#include <cassert>
#include <sstream>

# if defined(_MSC_VER)
#  if _MSC_VER >= 1300
/*
 * Diamond inheritance is used for the CommonAPI::Proxy base class.
 * The Microsoft compiler put warning (C4250) using a desired c++ feature: "Delegating to a sister class"
 * A powerful technique that arises from using virtual inheritance is to delegate a method from a class in another class
 * by using a common abstract base class. This is also called cross delegation.
 */
#    pragma warning( disable : 4250 )
#  endif
# endif

namespace v0 {
namespace commonapi {

/**
 * Provides a default implementation for HeadUnitStubRemoteEvent and
 * HeadUnitStub. Method callbacks have an empty implementation,
 * remote set calls on attributes will always change the value of the attribute
 * to the one received.
 *
 * Override this stub if you only want to provide a subset of the functionality
 * that would be defined for this service, and/or if you do not need any non-default
 * behaviour.
 */
class COMMONAPI_EXPORT_CLASS_EXPLICIT HeadUnitStubDefault
    : public virtual HeadUnitStub {
public:
    COMMONAPI_EXPORT HeadUnitStubDefault()
        : remoteEventHandler_(this),
          interfaceVersion_(HeadUnit::getInterfaceVersion()) {
    }

    COMMONAPI_EXPORT const CommonAPI::Version& getInterfaceVersion(std::shared_ptr<CommonAPI::ClientId> _client) {
        (void)_client;
        return interfaceVersion_;
    }

    COMMONAPI_EXPORT HeadUnitStubRemoteEvent* initStubAdapter(const std::shared_ptr< HeadUnitStubAdapter> &_adapter) {
        CommonAPI::Stub<HeadUnitStubAdapter, HeadUnitStubRemoteEvent>::stubAdapter_ = _adapter;
        return &remoteEventHandler_;
    }

    COMMONAPI_EXPORT virtual const bool &getLightModeAttribute() {
        return lightModeAttributeValue_;
    }
    COMMONAPI_EXPORT virtual const bool &getLightModeAttribute(const std::shared_ptr<CommonAPI::ClientId> _client) {
        (void)_client;
        return getLightModeAttribute();
    }
    COMMONAPI_EXPORT virtual void setLightModeAttribute(bool _value) {
        const bool valueChanged = trySetLightModeAttribute(std::move(_value));
        if (valueChanged) {
            fireLightModeAttributeChanged(lightModeAttributeValue_);
        }
    }
    COMMONAPI_EXPORT virtual const std::string &getUnitAttribute() {
        return unitAttributeValue_;
    }
    COMMONAPI_EXPORT virtual const std::string &getUnitAttribute(const std::shared_ptr<CommonAPI::ClientId> _client) {
        (void)_client;
        return getUnitAttribute();
    }
    COMMONAPI_EXPORT virtual void setUnitAttribute(std::string _value) {
        const bool valueChanged = trySetUnitAttribute(std::move(_value));
        if (valueChanged) {
            fireUnitAttributeChanged(unitAttributeValue_);
        }
    }
    COMMONAPI_EXPORT virtual const ::v0::commonapi::HeadUnit::MetaData &getMetadataAttribute() {
        return metadataAttributeValue_;
    }
    COMMONAPI_EXPORT virtual const ::v0::commonapi::HeadUnit::MetaData &getMetadataAttribute(const std::shared_ptr<CommonAPI::ClientId> _client) {
        (void)_client;
        return getMetadataAttribute();
    }
    COMMONAPI_EXPORT virtual void setMetadataAttribute(::v0::commonapi::HeadUnit::MetaData _value) {
        const bool valueChanged = trySetMetadataAttribute(std::move(_value));
        if (valueChanged) {
            fireMetadataAttributeChanged(metadataAttributeValue_);
        }
    }


protected:
    COMMONAPI_EXPORT virtual bool trySetLightModeAttribute(bool _value) {
        if (!validateLightModeAttributeRequestedValue(_value))
            return false;

        bool valueChanged;
        std::shared_ptr<HeadUnitStubAdapter> stubAdapter = CommonAPI::Stub<HeadUnitStubAdapter, HeadUnitStubRemoteEvent>::stubAdapter_.lock();
        if(stubAdapter) {
            stubAdapter->lockLightModeAttribute(true);
            valueChanged = (lightModeAttributeValue_ != _value);
            lightModeAttributeValue_ = std::move(_value);
            stubAdapter->lockLightModeAttribute(false);
        } else {
            valueChanged = (lightModeAttributeValue_ != _value);
            lightModeAttributeValue_ = std::move(_value);
        }

       return valueChanged;
    }
    COMMONAPI_EXPORT virtual bool validateLightModeAttributeRequestedValue(const bool &_value) {
        (void)_value;
        return true;
    }
    COMMONAPI_EXPORT virtual bool trySetUnitAttribute(std::string _value) {
        if (!validateUnitAttributeRequestedValue(_value))
            return false;

        bool valueChanged;
        std::shared_ptr<HeadUnitStubAdapter> stubAdapter = CommonAPI::Stub<HeadUnitStubAdapter, HeadUnitStubRemoteEvent>::stubAdapter_.lock();
        if(stubAdapter) {
            stubAdapter->lockUnitAttribute(true);
            valueChanged = (unitAttributeValue_ != _value);
            unitAttributeValue_ = std::move(_value);
            stubAdapter->lockUnitAttribute(false);
        } else {
            valueChanged = (unitAttributeValue_ != _value);
            unitAttributeValue_ = std::move(_value);
        }

       return valueChanged;
    }
    COMMONAPI_EXPORT virtual bool validateUnitAttributeRequestedValue(const std::string &_value) {
        (void)_value;
        return true;
    }
    COMMONAPI_EXPORT virtual bool trySetMetadataAttribute(::v0::commonapi::HeadUnit::MetaData _value) {
        if (!validateMetadataAttributeRequestedValue(_value))
            return false;

        bool valueChanged;
        std::shared_ptr<HeadUnitStubAdapter> stubAdapter = CommonAPI::Stub<HeadUnitStubAdapter, HeadUnitStubRemoteEvent>::stubAdapter_.lock();
        if(stubAdapter) {
            stubAdapter->lockMetadataAttribute(true);
            valueChanged = (metadataAttributeValue_ != _value);
            metadataAttributeValue_ = std::move(_value);
            stubAdapter->lockMetadataAttribute(false);
        } else {
            valueChanged = (metadataAttributeValue_ != _value);
            metadataAttributeValue_ = std::move(_value);
        }

       return valueChanged;
    }
    COMMONAPI_EXPORT virtual bool validateMetadataAttributeRequestedValue(const ::v0::commonapi::HeadUnit::MetaData &_value) {
        (void)_value;
        return true;
    }
    class COMMONAPI_EXPORT_CLASS_EXPLICIT RemoteEventHandler: public virtual HeadUnitStubRemoteEvent {
    public:
        COMMONAPI_EXPORT RemoteEventHandler(HeadUnitStubDefault *_defaultStub)
            : 
              defaultStub_(_defaultStub) {
        }


    private:
        HeadUnitStubDefault *defaultStub_;
    };
protected:
    HeadUnitStubDefault::RemoteEventHandler remoteEventHandler_;

private:

    bool lightModeAttributeValue_ {};
    std::string unitAttributeValue_ {};
    ::v0::commonapi::HeadUnit::MetaData metadataAttributeValue_ {};

    CommonAPI::Version interfaceVersion_;
};

} // namespace commonapi
} // namespace v0


// Compatibility
namespace v0_1 = v0;

#endif // V0_COMMONAPI_Head_Unit_STUB_DEFAULT
