#!/bin/bash

file=$1
shift

[ -e "$file" ] && echo "$file already exists." && exit

for i in {1..10000}
do
    if [ -e "$file" ]
    then
        eval $*
        break
    else
        echo "Waiting for $i minutes"
        sleep 60
    fi
done

