#!/bin/bash
echo "Running black shell script"
iptables -P FORWARD ACCEPT
while read line
do
echo "Blocking traffic to $line"
iptables -I FORWARD -d $line -j DROP
done < black.txt

# 使用前先创建文本 black.txt
# 在里面写入要加入黑名单的ip地址
# 比如 
# www.baidu.com
# www.taobao.com# 使用前先创建文本 black.txt

# 防火墙黑名单脚本【无效】
