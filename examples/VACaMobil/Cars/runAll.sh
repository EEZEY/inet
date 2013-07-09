#!/bin/bash
CONFIGS="VACaMobil duaIterate duaroute"
for config in $CONFIGS
do
	opp_run -r 0 -u Cmdenv -c $config -n ../..:../../../src -l ../../../src/inet omnetpp.ini
done
