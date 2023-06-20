#!/bin/bash

echo run black shell

iptables -P FORWARD ACCEPT

cat black.txt | while read line
do
    echo iptables -I FORWARD -d $line -j DROP
    iptables -I FORWARD -d $line -j DROP
done

# 使用前先创建文本 black.txt
# 在里面写入要加入黑名单的ip地址
# 比如 
# www.baidu.com
# www.taobao.com

# 防火墙黑名单脚本【无效】