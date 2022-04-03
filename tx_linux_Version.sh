#!/bin/bash

echo "Enter File Name"
read name 
file="$name"

echo "Define Payload Size"
read y

sleep 1
echo $(echo 'AT+I 0001<CR>' >  /dev/ttyACM0) #mode configure
sleep 1
echo $(echo 'ATPFR=868000000<CR>' >  /dev/ttyACM0) #frequnecy configure
sleep 1
echo $(echo 'ATPBM=0<CR>' >  /dev/ttyACM0) #0,1,1B for decimal,hex,binary
sleep 1
   
x=$(wc -c "$name" | awk '{print $1}' ) #get file size in bytes
#let "y= $x/$pack" #divide into chunks this is OLD method

let "packs = $x/$y" #divide into chunks

echo "-----------------------------------"
echo "-----------------------------------"
echo "Total bytes: $x >>>> Payload: $y >>>> Total Chunks: $packs"
echo "-----------------------------------"
echo "-----------------------------------"

n=0 #start byte
r=$x #remaining bytes
while [ $n -le $x ] #loop start here
do
r=$((x-n)) #remaining counter 

echo "Starting Byte:$n ------------ Remaining:$r"
#dd if="$name" ibs=1 skip=$n count=$y>> wr.txt #write to local file name wr.txt in same folder
#sleep 0.02
echo "------------------------------------------"
echo $(echo "AT+TX $(dd if="$name" ibs=1 skip=$n count=$y)" >  /dev/ttyACM0) #send the chunk via AT command
sleep 0.1 #this is where changed to measure time

n=$((n+y)) #count and shift to next payload

done

echo "Remaining: $((r-r))" #final check for remaining bytes

