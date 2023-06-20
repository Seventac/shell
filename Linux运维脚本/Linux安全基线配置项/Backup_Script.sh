#!/bin/bash

# 适用于centos7
cp /etc/login.defs /etc/login.defs.bak
cp /etc/security/limits.conf /etc/security/limits.conf.bak
cp /etc/pam.d/su  /etc/pam.d/su.bak
cp /etc/profile /etc/profile.bak
cp /etc/issue.net /etc/issue.net.bak
cp /etc/shadow /etc/shadow.bak
cp /etc/passwd /etc/passwd.bak
cp /etc/pam.d/passwd  /etc/pam.d/passwd.bak
# 如果是乌班图的系统中有下面一句，文件密码复杂度设置配置文件
# cp /etc/pam.d/common-password /etc/pam.d/common-password.bak
cp /etc/pam.d/system-auth /etc/pam.d/system-auth.bak
cp /etc/host.conf /etc/host.conf.bak
cp /etc/hosts.allow /etc/hosts.allow.bak
# 如果找不到该文件，说明每安装ntp服务，可以先安装ntp服务
# yum install -y ntp
cp /etc/ntp.conf /etc/ntp.conf.bak
cp -p /etc/sysctl.conf /etc/sysctl.conf.bak
echo "============备份完成=================="