#!/bin/bash
for ((i=0 ; i <= 999 ; i++))
do
    a=i/100
    b=(i/10)%10
    c=i%10
    if (( a*a*a + b*b*b + c*c*c == i ))
    then
        echo  "$i"
    fi  
done


