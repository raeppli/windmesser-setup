#!/bin/bash
windmCount=`ps -elaf | grep "java -jar Windmesser.jar" | wc -l`
if [ $windmCount -lt 2 ]
then
	echo -n "Windmesser not active anymore"
	date
	loggedin=`ps -elaf | grep "pi@pts" | wc -l`
	if [ $loggedin -gt 1 ]
	then
        	echo "=> Not restarting Windmesser since pi is logged in"
	else
		echo "=> restarting"
		date
		sudo /etc/init.d/windmesser start
	fi
fi
