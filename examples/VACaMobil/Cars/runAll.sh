#!/bin/bash
CONFIGS="VACaMobil duaIterate duaroute"
for config in $CONFIGS
do
	opp_runall -j4 opp_run -r 0..9 -u Cmdenv -c $config -n ../..:../../../src -l ../../../src/inet omnetpp.ini
done
