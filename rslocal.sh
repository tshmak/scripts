#!/bin/bash
# to be used by rrs and lrs
tempfile=/tmp/rstemp
echo "######## Command ###########"
echo "rsync -anvi --delete -f '- */' $@"
echo "############################"
echo

rsync -anvi --delete -f '- */' $@ > $tempfile
cat $tempfile
t=$(cat $tempfile | grep "^*del" | head -c 4)
if [ "$t" == "*del" ]; then
	read -p "Delete?" yn
	case $yn in
	[Yy]* ) delete="--delete";;
	esac
fi
	read -p "Update?" yn
	case $yn in
	[Yy]* )
	    rsync -a $delete -f '- */' $@
      ;;
	* )
  exit
  ;;
	esac
