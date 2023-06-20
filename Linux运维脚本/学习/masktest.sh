#!/bin/bash
read -rp "请输入网卡名称：ifcfg-" nname
read -rp "使用DHCP请输入1，使用STATIC请输入2 : " DHCP           #由后面的if语句判断1和2的结果
read -rp "请输入您要使用的IP地址： " IP
read -rp "请输入您的网关：" GATEWAY
read -rp "请输入您要使用的DNS地址： " DNS
read -rp "请输入您的子网掩码： " NETMASK
npath="/etc/sysconfig/network-scripts/ifcfg-$nname"        #定义网卡路径变量

### 当 NETMASK 缺省时，自动根据 IP 匹配 NETMASK

if [ -z $NETMASK ]
then
    IP=$(echo $IP | awk -F '.' '{print $1}')
    # if [ $IP -eq 0 ] || [ $IP -eq 127 ] || [ $IP -gt 223 ]
    # then
    #     echo "请输入正确的IP"
    #     exit 1
    # fi
    if [ $IP -lt 127 ] && [ $IP -gt 0 ]
    then
        NETMASK="255.0.0.0"
    elif [ $IP -lt 192 ] && [ $IP -gt 127 ]
    then
        NETMASK="255.255.0.0"
    elif [ $IP -lt 224 ] && [ $IP -gt 192 ]
    then
        NETMASK="255.255.255.0"
    fi
fi



###

function echo_network_file(){                              #使用函数及函数名称
    echo "TYPE=Ethernet" > $npath
    echo "BOOTPROTO="$A"" >> $npath                    #由if语句判断结果定义A的内容
    echo "DEFROUTE="no"" >> $npath
    echo "PEERDNS="yes"" >> $npath
    echo "PEERROUTES="yes"" >> $npath
    echo "IPV4_FAILURE_FATAL="no"" >> $npath
    echo "IPV6INIT="yes"" >> $npath
    echo "IPV6_AUTOCONF="no"" >> $npath
    echo "IPV6_DEFROUTE="no"" >> $npath
    echo "IPV6_PEERDNS="no"" >> $npath
    echo "IPV6_PEERROUTES="no"" >> $npath
    echo "IPV6_FAILURE_FATAL="no"" >> $npath
    echo "NAME="$nname"" >> $npath                     #由输入的网卡名称填写
    echo "UUID=$(cat /sys/class/dmi/id/product_uuid)" >> $npath           #提取uuid文件的内容填写
    echo "DEVICE="$nname"" >> $npath                   #由输入的网卡名称填写
    echo "ONBOOT="yes"" >> $npath
    echo "IPADDR="$IP"" >> $npath                      #写入IP地址
    echo "GATEWAY="$GATEWAY"" >> $npath                #写入网关地址
    echo "NETMASK="$NETMASK"" >> $npath                #写入子网掩码
    echo "DNS="$DNS"" >> $npath                        #写入DNS地址
}

if [ "$DHCP"  = 1 ];then                                #if语句判断等于1则使用DHCP，其他则使用静态ip
    A="dhcp"
    
else
    A="static"
fi

echo_network_file                                          #函数结尾

echo "nameserver "$DNS"" >>/etc/resolv.conf                #把DNS数据写入域名解析配置

systemctl restart network                                  #重启网卡

# 关闭防火墙和沙盒
systemctl stop firewalld

setenforce 0

echo "设置成功"
