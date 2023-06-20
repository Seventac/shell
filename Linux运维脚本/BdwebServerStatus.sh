#!/bin/bash
TARGETS=$(cat /root/mywebStatus.txt)
PROBE=".feeler.html"
for i in $TARGETS
do
    echo "##目标站点 $i"
    echo -n "  端口状态："
    nmap -sS $i -p 80 | awk '/80\/tcp/{print $2}'
    echo -n "   业务系统状态："
    wget -q http://$i/$PROBE && echo ok || echo not ok
    echo
done

