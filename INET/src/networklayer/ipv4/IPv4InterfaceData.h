//
// Copyright (C) 2000 Institut fuer Telematik, Universitaet Karlsruhe
// Copyright (C) 2004 Andras Varga
//
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation; either version 2
// of the License, or (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program; if not, write to the Free Software
// Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
//

//
//  Author: Andras Varga
//

#ifndef __IPv4INTERFACEDATA_H
#define __IPv4INTERFACEDATA_H

#include <vector>
#include <omnetpp.h>
#include "INETDefs.h"
#include "IPAddress.h"
#include "InterfaceEntry.h"


/**
 * IPv4-specific data in an InterfaceEntry. Stores interface IP address,
 * netmask, metric, etc.
 *
 * @see InterfaceEntry
 */
class INET_API IPv4InterfaceData : public InterfaceProtocolData
{
  public:
    typedef std::vector<IPAddress> IPAddressVector;

  protected:
    IPAddress inetAddr;  ///< IP address of interface
    IPAddress netmask;   ///< netmask
    int metric;          ///< link "cost"; see e.g. MS KB article Q299540
    IPAddressVector multicastGroups; ///< multicast groups

  private:
    // copying not supported: following are private and also left undefined
    IPv4InterfaceData(const IPv4InterfaceData& obj);
    IPv4InterfaceData& operator=(const IPv4InterfaceData& obj);

  public:
    IPv4InterfaceData();
    virtual ~IPv4InterfaceData() {}
    virtual std::string info() const;
    virtual std::string detailedInfo() const;

    /** @name Getters */
    //@{
    IPAddress getIPAddress() const {return inetAddr;}
    IPAddress getNetmask() const {return netmask;}
    int getMetric() const  {return metric;}
    const IPAddressVector& getMulticastGroups() const {return multicastGroups;}
    //@}

    /** @name Setters */
    //@{
    virtual void setIPAddress(IPAddress a) {inetAddr = a;}
    virtual void setNetmask(IPAddress m) {netmask = m;}
    virtual void setMetric(int m) {metric = m;}
    virtual void setMulticastGroups(const IPAddressVector& v) {multicastGroups = v;}
    //@}
};

#endif

