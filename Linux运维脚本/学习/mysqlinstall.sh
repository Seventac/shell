#!/bin/bash

read -rp "输入5个数字以空格隔开：" first second third fourth fiveth

array=( "$first" "$second" "$third" "$fourth" "$fiveth" )

# 长度计算
len=${#array[*]}

for((exterior=1;exterior < $len;exterior++))
do
    for((interior=0;interior < $len-1;interior++))
    do
        if ((${array[$interior]} > ${array[$interior+1]}))
        then
            temp=${array[$interior]}
            array[$interior]=${array[$interior+1]}
            array[$interior+1]=$temp
        fi
    done
done


echo "排序过后的数组元素为：${array[*]}"
echo "最后一个数组元素为：${array[$len-1]}"

