#!/bin/bash
for config in duaroute duaIterate VACaMobil
do
	for run in 0 1 2 3
	do
		opp_run -r $run -u Cmdenv -c $config -n ../../3rdparty:..:../../src -l ../../src/inet omnetpp.ini
	done
done