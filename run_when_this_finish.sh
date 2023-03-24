#!/bin/bash

pid=$1
shift

process=$(ps $pid | grep $pid | tr -s ' ' | cut -d' ' -f5-)
echo $process
echo

[ -z "$process" ] && echo "No process with PID $pid" && exit

for i in {1..10000}
do
    if ! kill -0 $pid &> /dev/null
    then
        eval $*
        break
    else
        echo "Waiting for $i minutes"
        sleep 60
    fi
done

