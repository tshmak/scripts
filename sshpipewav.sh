waitfile=$1
if [[ -z $waitfile ]] 
then
    echo "No waitfile supplied"
    exit
fi

if [[ -f $waitfile ]] 
then
    echo "waitfile already exists. Please delete or use another one."
    exit
fi

if [[ ! $waitfile =~ \.wav$ ]] 
then
    echo "$waitfile does not end with .wav."
    exit
fi

while :
do
    if [[ -f $waitfile ]]
    then 
        sox $waitfile -t raw -r 44100 -e signed-integer -L -b 16 -c 2 - 
        mv $waitfile $waitfile.finished
    fi
    sleep 1
done

