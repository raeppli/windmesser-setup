#!/bin/bash
# eval $(ssh-agent)
chk=$(netstat -t -e | grep "windmesser-tunnel" | grep "VERBUNDEN" | grep "5022" | wc -l)
if [ $chk -lt 1 ]; then
        p=$(pidof autossh)
        kill $p
        sleep 5
        autossh -M 5000 -f -N -T -o ExitOnForwardFailure=yes -o ServerAliveInterval=60 -i /home/windmesser-tunnel/.ssh/id_rsa -p 5022 -R2023:localhost:22 windmesser-tunnel@winduster.aeppli.org
fi
