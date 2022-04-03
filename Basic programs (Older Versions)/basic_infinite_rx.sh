#!/bin/bash
sleep 1
echo $(echo 'AT+I 0001<CR>' >  /dev/ttyACM2)
echo $(echo 'AT+I 0001<CR>' >  /dev/ttyACM0)  
sleep 1
echo $(echo 'ATPFR=868000000<CR>' >  /dev/ttyACM2)
echo $(echo 'ATPFR=868000000' >  /dev/ttyACM0)
sleep 1
echo $(echo 'ATPBM=1B<CR>' >  /dev/ttyACM2)
sleep 1

valid=true
c=1
p=10
while [ $valid ]
do
sleep 0.2
echo $(echo 'AT+RX' >  /dev/ttyACM2)
echo $(echo 'AT+TX Hello' >  /dev/ttyACM0)
##(stty raw; cat > received.txt) < /dev/ttyACM0 >

if [ $c -eq $p ];
then
break
fi
((c++))
done

echo "Done Receiving $p packets"
