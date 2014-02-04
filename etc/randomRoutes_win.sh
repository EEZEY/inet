#!/bin/bash

NROUTES=5000;
SUMOTOOLS=/c/Users/alvaro/Desktop/sumo-0.17.1/tools;
NETFILE="examples/VACaMobil/erlangen.net.xml"
ROUTEFILE="output.rou"


USEDUAITERATE="1";
KEEPROUTE="0";
DUAROUTEROPS="--ignore-errors";
DUAITERATEOPTS="-L -C";
TRIPSFILE="trips.trips.xml";



##### DO NOT MODIFY AFTER THIS POINT ####

DUAROUTER=$(which duarouter.exe);

if [ "$DUAROUTER" == "" ]
then
	echo "DUAROUTER command not installed or not in the PATH";
	exit -1;
fi

TRIPGENERATOR=$SUMOTOOLS/trip/randomTrips.py;
DUAITERATE=$SUMOTOOLS/assign/duaIterate.py;

if [ ! -f $TRIPGENERATOR ]
then
	echo "Trip Generator $TRIPGENERATOR not found";
	exit -1;
fi

XMLSTARLET=$(which xml.exe);
if [ "$XMLSTARLET" == "" ]
then
	echo "xmlstarlet (xml.exe) command not installed or not in the PATH";
	exit -1;
fi

ROUTES=0;
TEMPROUTES=$ROUTEFILE.temp

rm -f $TEMPROUTES $TEMPROUTES.alt $ROUTEFILE $ROUTEFILE.alt trips.trips.xml;

AWKCOMMAND='BEGIN{FS="e e";} ($1=="  <rout"){count++; print $1 "e id=\"route"count"\" e" $2;} ($1 != "  <rout"){print $0;}';

  $TRIPGENERATOR -n $NETFILE -t $TRIPSFILE -b 0 -e $NROUTES
  if [ "$USEDUAITERATE" == "0" ]
  then
	echo "Using duarouter"
  	$DUAROUTER -n $NETFILE -t $TRIPSFILE -o $TEMPROUTES $DUAROUTEROPS;
  	if [ "$KEEPROUTE" == "1" ]
  	then
		cp $TEMPROUTES duaRoute.rou.xml;
  	fi
else
	echo "Using duaIterate"
	if [ ! -f $TRIPGENERATOR ]
	then
		echo "duaIterate command $DUATITERATE not found";
		exit -1;
	fi
	#$DUAITERATE -n $NETFILE -r $TEMPROUTES $DUAITERATEOPTS;
	$DUAITERATE -n $NETFILE -t $TRIPSFILE $DUAITERATEOPTS;
	mv *_049.rou.xml $TEMPROUTES;
	if [ "$KEEPROUTE" == "1" ]
	then
		cp $TEMPROUTES duaIterate.rou.xml;
	fi
	rm *_0*;
	rm dua-log.txt 
  fi
  
  $XMLSTARLET ed -m "//routes/vehicle/route" "//routes" $TEMPROUTES | 
  $XMLSTARLET ed -d "//routes/vehicle" | 
  awk "$AWKCOMMAND"  >> $ROUTEFILE;  
  ROUTES=$($XMLSTARLET sel -t -v "count(/routes/route)" $ROUTEFILE);
  echo "Created $ROUTES routes from $NROUTES";

rm $TEMPROUTES trips.trips.xml;
