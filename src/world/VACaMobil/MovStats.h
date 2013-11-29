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

#ifndef MOVSTATS_H_
#define MOVSTATS_H_

#include <cmodule.h>
#include <Coord.h>
#include <VACaMobil.h>

class MovStats: public cSimpleModule, MobilitySubscriber{
public:
    MovStats();
    virtual ~MovStats();
protected:
    virtual int numInitStages() const { return 3; }
    virtual void initialize(int stage);
    virtual void handleMessage(cMessage *msg);
    virtual void finish();
private:
    virtual void onMobilityUpdated(std::map<std::string, cModule*> hosts);
    std::string mobModuleName;
    VACaMobil *manager;
    std::map<std::pair<int, int>, int > heatmapArea;
    std::map<std::string, int > heatmapRoads;

};

#endif /* MOVSTATS_H_ */
