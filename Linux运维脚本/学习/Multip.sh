#!/bin/bash

i=0
s=1
while [ $i != "20" ]
do
        i=$(($i+1))
        s=$(($i*$s))
done
echo "$s"