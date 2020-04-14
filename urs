#!/bin/bash

source $HOME/scripts/rs2.sh
if [ "$HOSTNAME" == "Timothy-Mak.local" ]; then
  direction="$(pwd)/ gpu1:$linuxcurrentdir/"
else 
  direction="mymac:$maccurrentdir/ ./"
fi
bash $HOME/scripts/$file2run $options $direction
