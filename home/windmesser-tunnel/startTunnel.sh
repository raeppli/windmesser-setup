#!/bin/bash
# eval $(ssh-agent)
autossh -M 5000 -f -N -T -o ExitOnForwardFailure=yes -o ServerAliveInterval=60 -i /home/windmesser-tunnel/.ssh/id_rsa -p 5022 -R2023:localhost:22 windmesser-tunnel@winduster.aeppli.org
