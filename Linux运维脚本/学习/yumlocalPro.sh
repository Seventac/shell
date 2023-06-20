#!/bin/bash

# 本地配置yum源

# 安装过程中不需要光盘
umount /media/cdrom
mkdir -p /media/cdrom
mount /dev/cdrom /media/cdrom

# 备份原有yum源
yum_conf_dir="/etc/yum.repos.d"
yum_conf_backup="/tmp/yum.repos.d.bak"
if [ -d "$yum_conf_dir" ]; then
    mkdir -p "$yum_conf_backup"
    mv "$yum_conf_dir"/* "$yum_conf_backup"
fi

# 添加本地yum源
cat > /etc/yum.repos.d/yum.repo <<EOF
[yum]
name=cdrom
baseurl=file:///media/cdrom
enabled=1
gpgcheck=0
EOF

# 删除yum锁文件
yum_pid_file="/var/run/yum.pid"
if [ -f "$yum_pid_file" ]; then
    rm "$yum_pid_file"
fi