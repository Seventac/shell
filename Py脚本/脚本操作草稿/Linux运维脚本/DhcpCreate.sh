#!/bin/bash
IP=192.168.2.129
GW=192.168.2.2
NIP=192.168.2.0
HMIP=192.168.2.200
ENIP=192.168.2.250
##############################static ip##############################
cd /etc/sysconfig/network-scripts || exit
sed -i 's/dhcp/static/g' ifcfg-eth0
sed -i 's/ONBOOT=no/ONBOOT=yes/g' ifcfg-eth0
cat >> ifcfg-eth0 << +END+
IPADDR=$IP
PREFIX=24
GATEWAY=$GW
DNS1=8.8.8.8
DOMAIN=114.114.114.114
+END+

service network restart
#############################vi dhcpd.conf###########################
cd  /etc/dhcp/ || exit
cat >> dhcpd.conf << +END+
#dhcpd.conf
default-lease-time 600;
max-lease-time 7200;
subnet $NIP netmask 255.255.255.0
 {
	range $HMIP $ENIP;
	option routers $GW;
	option domain-name-servers 8.8.8.8;
	option broadcast-address 192.168.137.255;
}
+END+
cd || exit
service dhcpd restart

