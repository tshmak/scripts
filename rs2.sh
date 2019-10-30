#!/bin/bash
# Script for parsing arguments

if [ "$1" == "local" ]; then
  shift
  file2run=rslocal.sh
else
  file2run=rs.sh
fi

currentdir=$(pwd)
maccurrentdir=$(echo $currentdir | sed "s/^\/home/\/Users/") 
linuxcurrentdir=$(echo $currentdir | sed "s/^\/Users/\/home/")
parentdir=$(dirname $currentdir)

POSITIONAL=()
exclfrom="--exclude-from $HOME/scripts/rs-exclude.txt"
maxsize="--max-size 100m"
while [[ $# -gt 0 ]]
do
  key="$1"
  case $key in
    --exclude-from)
    exclfrom="$1 $2"
    shift
    shift
    ;;
    --no-exclude-from)
    exclfrom=""
    shift
    ;;
    --max-size)
    maxsize="$1 $2"
    shift
    shift
    ;;
    --no-max-size)
    maxsize=""
    shift
    ;;
    --only)
    only="--include=$2 --exclude=*"
    shift
    shift
    ;;
    *)  # Unknown option
    POSITIONAL+=("$1") # save it in array for later
    shift
    ;;
  esac
done

export options="-a $exclfrom $maxsize $only ${POSITIONAL[@]}"
