#!/bin/bash
#
# Script zum setzen des aktuellen Ladezustands in Var1 des Tasmota-Schalters
# Das eigentliche Schalten passiert auf dem Schalter, durch Vergleich mit Mem1:
# (Definieren der Regel) 18:37:30 RSL: RESULT = {"Rule1":"ON","Once":"OFF","StopOnError":"OFF","Length":83,"Free":428,"Rules":"on Var1#state > %Mem1% do Power ON endon on Var1#state <= %Mem1% do Power OFF endon"}
# (Aktivieren der Regel) rule1 1

date >> /home/raeppli/logBoiler
ipkostal=$(cat /home/raeppli/nmap-hosts | grep -i "f8:36:9b:a2:76:84" | cut -d ' ' -f3)
if [ "$ipkostal" == "" ]; then ipkostal=$(cat /home/raeppli/lastipkostal.txt);
else echo -n "$ipkostal" > /home/raeppli/lastipkostal.txt;
fi

val=$(/home/raeppli/mbmd read -a $ipkostal:1502 -d kostal:71 -e hex 252 2 2>&1)
valhex="0x${val:4:4}${val:0:4}"
valf=$(gdb --batch -ex "print/f(float *) $valhex" | cut -d" " -f3)
#echo $valf
valf=$(printf %.0f "$valf")
#echo "Value: $valf"
valf=$(echo "$valf * -1" | bc)

curl "https://winduster.aeppli.org/logGridPower.php?currentPower=$valf"