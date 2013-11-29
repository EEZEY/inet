//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Lesser General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
// 
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Lesser General Public License for more details.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with this program.  If not, see http://www.gnu.org/licenses/.
// 

#include "MovStats.h"
#include "MobilityBase.h"
#include <fstream>

#define HEATMAP_AREA "area.dat"
#define HEATMAP_ROADS "road.dat"

Define_Module(MovStats);

MovStats::MovStats() {
    // TODO Auto-generated constructor stub

}

MovStats::~MovStats() {
    // TODO Auto-generated destructor stub
}

void MovStats::initialize(int stage) {
    if(stage!=2){
        return;
    }
    manager = VACaMobilAccess().get();
    ASSERT(manager!=NULL);
    mobModuleName = par("mobModuleName").stringValue();
    manager->subscribeUpdates(this);
    ASSERT(manager!=NULL);
}

void MovStats::handleMessage(cMessage* msg) {
}

void MovStats::onMobilityUpdated(std::map<std::string, cModule*> hosts){
    std::map<std::string, cModule*>::iterator it;
    for(it = hosts.begin(); it != hosts.end(); it++){
        std::string id = it->first;
        //Roads
        std::string currentEdge = manager->commandGetEdgeId(id);
        std::map<std::string,  int >::iterator eit = this->heatmapRoads.find(currentEdge);
        if(eit != this->heatmapRoads.end()){
            eit->second++;
        } else {
            this->heatmapRoads.insert(std::make_pair(currentEdge, 1));
        }
        //Area
        MobilityBase *mob = dynamic_cast<MobilityBase*>(it->second->getModuleByPath(("."+mobModuleName).c_str()));

        Coord pos = mob->getCurrentPosition();
        std::pair<int,int> currentij = std::make_pair(pos.x, pos.y);
        std::map<std::pair<int,int>,  int >::iterator ait = this->heatmapArea.find(currentij);
        if(ait != this->heatmapArea.end()){
            ait->second++;
        } else {
            this->heatmapArea.insert(std::make_pair(currentij, 1));
        }
    }
}

void MovStats::finish() {
    std::string prefix = par("statFiles").stringValue();
    std::ofstream f1((prefix+HEATMAP_ROADS).c_str(),std::ios_base::out);
    std::map<std::string, int >::iterator eit;
    for(eit = this->heatmapRoads.begin(); eit != this->heatmapRoads.end(); eit++){
        f1 << eit->first << " " << eit->second << endl;
    }
    f1.close();

    std::ofstream f2((prefix+HEATMAP_AREA).c_str(),std::ios_base::out);
    std::map<std::pair<int, int>, int >::iterator ait;
    for(ait= this->heatmapArea.begin(); ait != this->heatmapArea.end(); ait++){
        for(int i=0; i< ait->second; i++){
            f2 << ait->first.first << " " << ait->first.second << endl;
        }
    }
    f2.close();
    manager->unSubscribeUpdates(this);
}
