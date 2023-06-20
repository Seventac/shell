#!/bin/bash

banner1=00
banner2=0

for i in $(seq 1 100)
do
    if [[ $i -lt 10 ]]
    then
        adduser $banner1$i
        echo "123456" | passwd --stdin $banner1$i
    elif [[ $i -gt 10 && $i -lt 100 ]]
    then
        adduser $banner2$i
        echo "123456" | passwd --stdin $banner2$i
    else
        adduser $i
        echo "123456" | passwd --stdin $i
    fi
done