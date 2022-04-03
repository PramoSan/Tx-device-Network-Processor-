#!/bin/bash

echo "Enter File Name"
read name
file="$name"

echo "Define Packet Size"
read pack

   
x=$(wc -c "$name" | awk '{print $1}' ) #get file size in bytes
let "y= $x/$pack" #divide into chunks

echo "-----------------------------------"
echo "-----------------------------------"
echo "Total bytes: $x >>>> One Chunk: $y"
echo "-----------------------------------"
echo "-----------------------------------"

n=0
r=$x 
while [ $n -le $x ]
do
r=$((x-n))
echo "Starting Byte:$n ------------ Remaining:$r"
dd if="$name" ibs=1 skip=$n count=$y>> wr.txt #write to file
echo "------------------------------------------"

sleep 1
n=$((n+y))

done

echo "Remaining: $((r-r))"

#done < $file
