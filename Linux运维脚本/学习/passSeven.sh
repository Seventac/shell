#!/bin/bash

str=7

for((i=0;i<=500;i++))
do
    result=$(echo $i | grep "${str}")
	if [[ "$((i%7))" -eq 0 ]]
	then
		echo ""
    elif [[ "$result" != "" ]]
    then
        echo ""
    else
        echo $i
	fi
    
done
