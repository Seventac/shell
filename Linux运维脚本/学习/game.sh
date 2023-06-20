#!/bin/bash
startTime=`date +"%Y-%m-%d %H:%M:%S"`

for i in $(seq 1 1008690)
do
    if [[ "$((i%2))" -eq 0 ]]
    then
    a=$(($a+$i))
    fi
done
echo $a

endTime=`date +"%Y-%m-%d %H:%M:%S"`
st=`date -d  "$startTime" +%s`
et=`date -d  "$endTime" +%s`
sumTime=$(($et-$st))
echo "Total time is : $sumTime second."

startTime=`date +"%Y-%m-%d %H:%M:%S"`

first=1
last=1008690
half=2
sum=$(($first+$last))
echo $(($(($sum*$last))/$half))

endTime=`date +"%Y-%m-%d %H:%M:%S"`
st=`date -d  "$startTime" +%s`
et=`date -d  "$endTime" +%s`
sumTime=$(($et-$st))
echo "Total time is : $sumTime second."


# for循环中的另外一种写法

for item in {0..500..7}
do
    echo $item
done

