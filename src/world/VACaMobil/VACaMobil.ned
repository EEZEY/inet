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
// VACaMobil was presented in:
// 
// [1] M. Báguena, S. M. Tornell, A. Torres, C. T. Calafate, J.-C. Cano, and P. Manzoni, 
// “VACaMobil: VANET Car Mobility Manager for OMNeT++,” in IEEE International Conference
// on Communications 2013: IEEE ICC’13 - 3rd IEEE International Workshop on Smart 
// Communication Protocols and Algorithms (SCPA 2013) (ICC'13 - IEEE ICC'13 - Workshop SCPA), 2013.
//
// please cite our paper if you use it.
// 
// If you use VACaMobil for your publications, please inform us at www.grc.upv.es
//
//
//
simple VACaMobil extends TraCIScenarioManagerLaunchd
{
    parameters:
    @display("i=block/source");
    @class("VACaMobil");
    
    //we recommend to check the EV log file in the first simulation to ensure that the correct probabilities are stated. They are printed at initialization.
    //One working mode is to define the probabilities of the vehicles ordered ex. "0.1 0.3 0.6", the tricky part is that it should be the TraCI order wich is usually unknown
    //
    //The second working mode (the good one) is defining probabilities associated to certain types of vehicles.
    //ex. "Vehicle1=0.5 Vehicle2=0.3 Vehicle3=0.2"
    //So, a general rule will be: "<VehicleName>=<probability> <space> <VehicleName>=<probability>..." 
    //
    //In both cases, if the total sum is greater than one the result is normalized.
    string vehicleRates = default(""); //This is a tricky parameter, 
    
    // If set to RandomGeneration VACaMobil will simply introduce a new vehicle somewhere into the network every "interArrivalTime" seconds 
    // clearly it does not ensure the steady state behavior but provides support for scenarios with a low number of entry points (such as highways).
    // In SteadyState mode VACaMobil works according to our paper
    string chooseVACaMobilMode @enum("SteadyState","RandomGeneration") = default("SteadyState"); 
    
    //Variables for steady state mode.
    int meanNumberOfCars = default(0);
    int carHysteresisValue = default(0);
    int warmUpSeconds @unit(s) = default(-1s); //With a value lower than firstStepAt uses simulation.getWarmupPeriod()
    
    //Variables for RandomGeneration mode.
    volatile double interArrivalTime @unit(s) = default(1s);
    
    bool getStatistics = default(false); //If set to true it generates some kind-of heat maps
    string statFiles = default("");
    bool doNothing = default(false); //If it's set to true it should work like TRACI Scenario Manager Launchd
    xml rsuPlacement = default(xml("<poas></poas>")); //VACaMobil supports the creation of Road Side Units which location is specified in this file
    string rsuModule = default(""); //The omnetpp module for RSU.
    string rsuPrefix = default(""); //The omnetpp module for RSU.
    int nRandomRsu = default(0); //number of RSU place randomly in joints.
    
    @signal[onSimulationCarsSignal];
    @statistic[onSimulationCars](title="Active cars";source="onSimulationCarsSignal";record=vector,stats);
}
