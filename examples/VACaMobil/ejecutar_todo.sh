#!/bin/bash
for config in carGRCnator
do
	for run in 0 1 2
	do
		opp_run -r $run -u Cmdenv -c $config -n ../../3rdparty:..:../../src -l ../../src/inet -l ../../3rdparty/inet omnetpp.ini
	done
done