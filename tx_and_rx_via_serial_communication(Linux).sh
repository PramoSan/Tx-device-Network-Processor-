#!/bin/bash

echo "Enter File Name"
read name
file="$name"

echo "Define Payload Size"
read y

sleep 1
echo $(echo 'AT+I 0001<CR>' >  /dev/ttyACM2)
echo $(echo 'AT+I 0001<CR>' >  /dev/ttyACM0)  
sleep 1
echo $(echo 'ATPFR=868000000<CR>' >  /dev/ttyACM2)
echo $(echo 'ATPFR=868000000' >  /dev/ttyACM0)
sleep 1
echo $(echo 'ATPBM=0<CR>' >  /dev/ttyACM2) #0,1,1B for decimal,hex,binary
sleep 1
   
x=$(wc -c "$name" | awk '{print $1}' ) #get file size in bytes
#####let "y= $x/$pack" #divide into chunks
let "packs = $x/$y" #divide into chunks

echo "-----------------------------------"
echo "-----------------------------------"
echo "Total bytes: $x >>>> Payload: $y >>>> Total Chunks: $packs"
echo "-----------------------------------"
echo "-----------------------------------"

n=0
r=$x 
while [ $n -le $x ]
do
r=$((x-n))

echo $(echo 'AT+RX' >  /dev/ttyACM2) #ready forthe rx

echo "Starting Byte:$n ------------ Remaining:$r"
#dd if="$name" ibs=1 skip=$n count=$y>> wr.txt #write to file
sleep 0.02
echo "------------------------------------------"
echo $(echo "AT+TX $(dd if="$name" ibs=1 skip=$n count=$y)" >  /dev/ttyACM0)
sleep 0.02
n=$((n+y))

done

echo "Remaining: $((r-r))"
echo $(echo 'AT+RX' >  /dev/ttyACM2) #ready forthe rx
echo $(echo "AT+TX Total sent:$n and Remaining:$r" >  /dev/ttyACM0)

#done < $file
