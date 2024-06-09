/*
* This file was generated by the CommonAPI Generators.
* Used org.genivi.commonapi.core 3.2.0.v202012010850.
* Used org.franca.core 0.13.1.201807231814.
*
* This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0.
* If a copy of the MPL was not distributed with this file, You can obtain one at
* http://mozilla.org/MPL/2.0/.
*/
#ifndef V0_COMMONAPI_Head_Unit_PROXY_HPP_
#define V0_COMMONAPI_Head_Unit_PROXY_HPP_

#include <v0/commonapi/HeadUnitProxyBase.hpp>


#if !defined (COMMONAPI_INTERNAL_COMPILATION)
#define COMMONAPI_INTERNAL_COMPILATION
#define HAS_DEFINED_COMMONAPI_INTERNAL_COMPILATION_HERE
#endif

#include <CommonAPI/AttributeExtension.hpp>
#include <CommonAPI/Factory.hpp>

#if defined (HAS_DEFINED_COMMONAPI_INTERNAL_COMPILATION_HERE)
#undef COMMONAPI_INTERNAL_COMPILATION
#undef HAS_DEFINED_COMMONAPI_INTERNAL_COMPILATION_HERE
#endif

namespace v0 {
namespace commonapi {

template <typename ... _AttributeExtensions>
class HeadUnitProxy
    : virtual public HeadUnit,
      virtual public HeadUnitProxyBase,
      virtual public _AttributeExtensions... {
public:
    HeadUnitProxy(std::shared_ptr<CommonAPI::Proxy> delegate);
    ~HeadUnitProxy();

    typedef HeadUnit InterfaceType;


    /**
     * Returns the CommonAPI address of the remote partner this proxy communicates with.
     */
    virtual const CommonAPI::Address &getAddress() const;

    /**
     * Returns true if the remote partner for this proxy is currently known to be available.
     */
    virtual bool isAvailable() const;

    /**
     * Returns true if the remote partner for this proxy is available.
     */
    virtual bool isAvailableBlocking() const;

    /**
     * Returns the wrapper class that is used to (de-)register for notifications about
     * the availability of the remote partner of this proxy.
     */
    virtual CommonAPI::ProxyStatusEvent& getProxyStatusEvent();

    /**
     * Returns the wrapper class that is used to access version information of the remote
     * partner of this proxy.
     */
    virtual CommonAPI::InterfaceVersionAttribute& getInterfaceVersionAttribute();

    virtual std::future<void> getCompletionFuture();

    /**
     * Returns the wrapper class that provides access to the attribute lightMode.
     */
    virtual LightModeAttribute& getLightModeAttribute() {
        return delegate_->getLightModeAttribute();
    }
    /**
     * Returns the wrapper class that provides access to the attribute unit.
     */
    virtual UnitAttribute& getUnitAttribute() {
        return delegate_->getUnitAttribute();
    }
    /**
     * Returns the wrapper class that provides access to the attribute metadata.
     */
    virtual MetadataAttribute& getMetadataAttribute() {
        return delegate_->getMetadataAttribute();
    }



 private:
    std::shared_ptr< HeadUnitProxyBase> delegate_;
};

typedef HeadUnitProxy<> HeadUnitProxyDefault;

namespace HeadUnitExtensions {
    template <template <typename > class _ExtensionType>
    class LightModeAttributeExtension {
     public:
        typedef _ExtensionType< HeadUnitProxyBase::LightModeAttribute> extension_type;
    
        static_assert(std::is_base_of<typename CommonAPI::AttributeExtension< HeadUnitProxyBase::LightModeAttribute>, extension_type>::value,
                      "Not CommonAPI Attribute Extension!");
    
        LightModeAttributeExtension(HeadUnitProxyBase& proxy): attributeExtension_(proxy.getLightModeAttribute()) {
        }
    
        inline extension_type& getLightModeAttributeExtension() {
            return attributeExtension_;
        }
    
     private:
        extension_type attributeExtension_;
    };

    template <template <typename > class _ExtensionType>
    class UnitAttributeExtension {
     public:
        typedef _ExtensionType< HeadUnitProxyBase::UnitAttribute> extension_type;
    
        static_assert(std::is_base_of<typename CommonAPI::AttributeExtension< HeadUnitProxyBase::UnitAttribute>, extension_type>::value,
                      "Not CommonAPI Attribute Extension!");
    
        UnitAttributeExtension(HeadUnitProxyBase& proxy): attributeExtension_(proxy.getUnitAttribute()) {
        }
    
        inline extension_type& getUnitAttributeExtension() {
            return attributeExtension_;
        }
    
     private:
        extension_type attributeExtension_;
    };

    template <template <typename > class _ExtensionType>
    class MetadataAttributeExtension {
     public:
        typedef _ExtensionType< HeadUnitProxyBase::MetadataAttribute> extension_type;
    
        static_assert(std::is_base_of<typename CommonAPI::AttributeExtension< HeadUnitProxyBase::MetadataAttribute>, extension_type>::value,
                      "Not CommonAPI Attribute Extension!");
    
        MetadataAttributeExtension(HeadUnitProxyBase& proxy): attributeExtension_(proxy.getMetadataAttribute()) {
        }
    
        inline extension_type& getMetadataAttributeExtension() {
            return attributeExtension_;
        }
    
     private:
        extension_type attributeExtension_;
    };

} // namespace HeadUnitExtensions

//
// HeadUnitProxy Implementation
//
template <typename ... _AttributeExtensions>
HeadUnitProxy<_AttributeExtensions...>::HeadUnitProxy(std::shared_ptr<CommonAPI::Proxy> delegate):
        _AttributeExtensions(*(std::dynamic_pointer_cast< HeadUnitProxyBase>(delegate)))...,
        delegate_(std::dynamic_pointer_cast< HeadUnitProxyBase>(delegate)) {
}

template <typename ... _AttributeExtensions>
HeadUnitProxy<_AttributeExtensions...>::~HeadUnitProxy() {
}


template <typename ... _AttributeExtensions>
const CommonAPI::Address &HeadUnitProxy<_AttributeExtensions...>::getAddress() const {
    return delegate_->getAddress();
}

template <typename ... _AttributeExtensions>
bool HeadUnitProxy<_AttributeExtensions...>::isAvailable() const {
    return delegate_->isAvailable();
}

template <typename ... _AttributeExtensions>
bool HeadUnitProxy<_AttributeExtensions...>::isAvailableBlocking() const {
    return delegate_->isAvailableBlocking();
}

template <typename ... _AttributeExtensions>
CommonAPI::ProxyStatusEvent& HeadUnitProxy<_AttributeExtensions...>::getProxyStatusEvent() {
    return delegate_->getProxyStatusEvent();
}

template <typename ... _AttributeExtensions>
CommonAPI::InterfaceVersionAttribute& HeadUnitProxy<_AttributeExtensions...>::getInterfaceVersionAttribute() {
    return delegate_->getInterfaceVersionAttribute();
}


template <typename ... _AttributeExtensions>
std::future<void> HeadUnitProxy<_AttributeExtensions...>::getCompletionFuture() {
    return delegate_->getCompletionFuture();
}

} // namespace commonapi
} // namespace v0

namespace CommonAPI {
template<template<typename > class _AttributeExtension>
struct DefaultAttributeProxyHelper< ::v0::commonapi::HeadUnitProxy,
    _AttributeExtension> {
    typedef typename ::v0::commonapi::HeadUnitProxy<
            ::v0::commonapi::HeadUnitExtensions::LightModeAttributeExtension<_AttributeExtension>, 
            ::v0::commonapi::HeadUnitExtensions::UnitAttributeExtension<_AttributeExtension>, 
            ::v0::commonapi::HeadUnitExtensions::MetadataAttributeExtension<_AttributeExtension>
    > class_t;
};
}


// Compatibility
namespace v0_1 = v0;

#endif // V0_COMMONAPI_Head_Unit_PROXY_HPP_