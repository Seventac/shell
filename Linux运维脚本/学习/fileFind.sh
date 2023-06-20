#!/bin/bash

# 可以直接使用find
function findFile(){
    local PATH=$1
    local PBTH=$PATH
    local num=$(ls $PATH | wc -l)
    local i=1
    for ((;i<=num;i++))
    do
        local name=$PATH/$(ls $PATH | head -$i | tail -1)
        if [ -d $name ]
        then
            findFile $name $2
        else
            grep "$2" $name
            if [ $? -eq 0 ]
            then
                echo $name
            fi
        fi
    done
}
# $1 --> 目录  $2 --> 指定内容
findFile $1 $2