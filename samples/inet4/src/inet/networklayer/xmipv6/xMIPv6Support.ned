//
// Copyright (C) 2007
// Faqir Zarrar Yousaf
// Communication Networks Institute, Dortmund University of Technology (TU Dortmund), Germany.
// Christian Bauer
// Institute of Communications and Navigation, German Aerospace Center (DLR)
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

package inet.networklayer.xmipv6;

import inet.networklayer.contract.IxMIPv6Support;

//
// Implements xMIPv6 (where x = F, H, F-H).
//
module xMIPv6Support like IxMIPv6Support
{
    parameters:
        bool isHomeAgent;
        bool isMobileNode;
        string interfaceTableModule;
        string ipv6TunnelingModule;
        string ipv6NeighbourDiscoveryModule;
        *.interfaceTableModule = default(absPath(this.interfaceTableModule));
        *.ipv6TunnelingModule = default(absPath(this.ipv6TunnelingModule));
        *.ipv6NeighbourDiscoveryModule = default(absPath(this.ipv6NeighbourDiscoveryModule));
        *.bindingUpdateListModule = default(absPath(".buList"));
        *.bindingCacheModule = default(absPath(".bindingCache"));
        @display("i=block/classifier2");
    gates:
        input fromIPv6;
        output toIPv6;
    submodules:
        xMobileIPv6: xMIPv6 {
            isHomeAgent = parent.isHomeAgent;
            isMobileNode = parent.isMobileNode;
            @display("p=250,150");
        }
        buList: BindingUpdateList {
            parameters:
                @display("p=100,100;i=old/harddisk");
        }
        bindingCache: BindingCache {
            parameters:
                @display("p=100,200;i=old/harddisk");
        }
    connections:
        fromIPv6 --> xMobileIPv6.fromIPv6;
        toIPv6 <-- xMobileIPv6.toIPv6;
}

