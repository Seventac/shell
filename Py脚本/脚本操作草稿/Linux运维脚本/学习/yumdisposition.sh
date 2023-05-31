#!/bin/bash

# 网络配置yum源

# 删除yum锁文件
yum_pid_file="/var/run/yum.pid"
if [ -f "$yum_pid_file" ]; then
    rm "$yum_pid_file"
fi

# 安装wget命令
yum -y install wget

# 备份原有的yum源文件
mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.bak

# 下载阿里云CentOS 7的yum源文件
wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo

# 清理yum缓存并重新生成
yum clean all
yum makecache