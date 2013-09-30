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

package inet.world.VACaMobil;

import inet.world.traci.TraCIScenarioManagerLaunchd;


//
//
simple VACaMobil extends TraCIScenarioManagerLaunchd
{
    parameters:
    @display("i=block/source");
    @class("VACaMobil");
    
    string vehicleRates = default("");
    
    string chooseVACaMobilMode @enum("Mean","InterArrivalTime") = default("Mean"); //If set to interArrivalTime VACaMobil do not ensures the restriction of "MeanNumbersOfCar+-carHystereisValue" to be accomplished but provides support for scenarios with low number of entry points (such as highways).
    
    //Variables for mean mode.
    int meanNumberOfCars = default(0);
    int carHysteresisValue = default(0);
    int warmUpSeconds @unit(s) = default(-1s); //With a value lower than firstStepAt uses simulation.getWarmupPeriod()
    
    //Variables for interArrivalTime mode.
    volatile double interArrivalInitialTime @unit(s) = default(1s); //When VACaMobil is working in InterArrivalTime Mode it adds vehicles with this interArrivalTime. exponential(${VehicleRate=1s,2s,3s})}
    
    bool getStatistics = default(false); //If set to true it generates some kind-of heat maps
    string statFiles = default("");
    bool doNothing = default(false); //If it's set to true it should work like TRACI Scenario Manager Launchd
    xml rsuPlacement = default(xml("<poas></poas>")); //VACaMobil supports the creation of Road Side Units which location is specified in this file
    string rsuModule = default(""); //The omnetpp module of RSU.
    string rsuPrefix = default(""); //The omnetpp module of RSU.
    int nRandomRsu = default(0); //number of RSU place randomly in joints.
    
    @signal[onSimulationCarsSignal];
    @statistic[onSimulationCars](title="Active cars";source="onSimulationCarsSignal";record=vector,stats);
}
