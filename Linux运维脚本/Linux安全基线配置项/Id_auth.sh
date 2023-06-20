#!/bin/bash



# 编辑/etc/login.defs添加身份标识基线配置
sed -i "25s/99999/90/" /etc/login.defs
sed -i "26s/0/1/" /etc/login.defs
sed -i "27s/5/8/" /etc/login.defs

sed '5 i auth        required      /lib/security/pam_tally.so onerr=fail no_magic root' /etc/pam.d/system-auth
sed '15 i account     required      /lib/security/pam_tally.so deny=3 no_magic root reset' /etc/pam.d/system-auth



# 添加登录连接超时自动退出配置
echo 'TMOUT= 300s' >> /etc/profile
echo 'source /etc/profile' >> /etc/profile



# 防止网络信息被窃听
# 通过iptables防火墙关闭23端口，确认仅22端口可以进行远程操作
# 首先安装iptables命令工具，
yum install -y iptables-services
# 设置开机启动
systemctl enable iptables
# 重启过滤命令行
systemctl restart iptables
# 启动服务
systemctl start iptables
iptables -A INPUT -p tcp --dport 23
service iptables save
# 查看端口情况
lsof -i:22
lsof -i:23
# 通过firewall-cmd防火墙关闭23端口，确认仅22端口可以进行远程操作
firewall-cmd --list-ports
firewall-cmd --zone=public --remove-port=23/tcp --permanent
firewall-cmd --reload

# 以下三点需要人工完成

# 访问控制

# 权限控制
# 禁用root用户登录，修改默认远程控制端口





# 安全审计




# 入侵防范

# 查看开放的服务列表
chkconfig --list
# 查看并确认是否开放的端口都为业务需要端口，是否已经关闭非必需的端口
netstat -ntlp

# 查看系统最小化安装原则
yum list installed



