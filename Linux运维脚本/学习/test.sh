#!/bin/bash
function funWithReturn(){
    
    echo "对输入数值的每一位上的数字进行相加得出结果"
    # 设置最后结果容器
    sum=0
    # 五秒后不输入自动退出
    read -p "请输入数字:" -t 10 Number
    # 首先判断一下输入的是否是数字，不是就退出
    if ! [[ "$Number" =~ ^[1-9]+$ ]]
    then
        echo "您输入的不是数字，程序退出"
        exit
    fi
    
    # 如果是数字判断数字的位数
    len=${#Number}
    # 进行循环取模和除以取位
    for i in $(seq 1 $len)
    do
        let "g=$Number%10"
        let "Number=$Number/10"
        let "sum=$sum+$g"
    done
    echo "最后结果：" $sum
    
    if [ $sum -gt 30 ]
    then
        echo "恭喜你中奖了"
        exit
    elif [ $sum -gt 20 ]
    then
        echo "你中了二等奖"
        exit
    elif [ $sum -gt 10 ]
    then
        echo "你中了三等奖"
        exit
    else
        echo "谢谢惠顾"
    fi
}

funWithReturn
