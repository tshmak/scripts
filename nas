#!/bin/bash

pwd=$(realpath $1)
target=$(realpath /home/tshmak/localnas/tshmak)
echo $pwd | sed "s,.*/tshmak/ssd,$target," | sed "s,.*ssd/tshmak,$target,"
