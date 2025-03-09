#!/bin/bash
#
# Script zum setzen des aktuellen Ladezustands in Var1 des Tasmota-Schalters
# Das eigentliche Schalten passiert auf dem Schalter, durch Vergleich mit Mem1:
# (Definieren der Regel) 18:37:30 RSL: RESULT = {"Rule1":"ON","Once":"OFF","StopOnError":"OFF","Length":83,"Free  ":428,"Rules":"on Var1#state > %Mem1% do Power ON endon on Var1#state <= %Mem1% do Power OFF endon"}
# (Aktivieren der Regel) rule1 1

date >> /home/raeppli/logBoiler
ipkostal=$(cat /home/raeppli/nmap-hosts | grep -i "f8:36:9b:a2:76:84" | cut -d ' ' -f3)
if [ "$ipkostal" == "" ]; then ipkostal=$(cat /home/raeppli/lastipkostal.txt);
else echo -n "$ipkostal" > /home/raeppli/lastipkostal.txt;
fi

val=$(/home/raeppli/mbmd read -a $ipkostal:1502 -d kostal:71 -e hex 210 2 2>&1)
valhex="0x${val:4:4}${val:0:4}"
valf=$(gdb --batch -ex "print/f(float *) $valhex" | cut -d" " -f3)
echo "Value: $valf" >> /home/raeppli/logBoiler

sonofflist="E8:68:E7:44:C3:26 A4:CF:12:B6:15:46"
for i in $sonofflist; do
        ipsonoff=$(cat /home/raeppli/nmap-hosts | grep -i "$i" | cut -d ' ' -f3)
        if [ "$ipsonoff" == "" ]; then ipsonoff=$(cat /home/raeppli/lastip-$i.txt);
        else echo -n "$ipsonoff" > /home/raeppli/lastip-$i.txt;
        fi
        echo -n "$ipsonoff:" >> /home/raeppli/logBoiler
        #wget -q -O - -t 2 -T 3 "$ipsonoff/cm?cmnd=Var1%20$valf" > /dev/null
        wget -q -O - -t 2 -T 3 "$ipsonoff/cm?cmnd=Var1%20$valf" >> /home/raeppli/logBoiler
        echo >> /home/raeppli/logBoiler
done
echo "----------------" >> /home/raeppli/logBoiler