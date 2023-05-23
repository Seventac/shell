#!/bin/bash

echo "---关闭防火墙及强制访问控制系统---"
systemctl stop firewalld
systemctl disable firewalld
setenforce 0

echo "---检测yum源仓库是否已挂载及安装相应环境依赖包---"
df | grep "sr0"
if [ $? -eq 0 ];then
        yum -y install gcc gcc-c++ make pcre pcre-devel expat-devel perl &>/dev/null
        else
        mount /dev/sr0 /mnt
        yum -y install gcc gcc-c++ make pcre pcre-devel expat-devel perl &>/dev/null
fi

echo "---检查之前是否安装过httpd服务，避免出现端口冲突等问题！---"
rpm -q httpd
if [ $? -eq 0 ];then
        yum remove httpd
fi

cd /opt/ || exit
echo "---开始配置软件模块---"
tar zxvf apr-1.6.2.tar.gz
tar zxvf apr-util-1.6.0.tar.gz
tar jxvf httpd-2.4.29.tar.bz2

mv apr-1.6.2 /opt/httpd-2.4.29/srclib/apr
mv apr-util-1.6.0 /opt/httpd-2.4.29/srclib/apr-util

cd /opt/httpd-2.4.29/ || exit
./configure --prefix=/usr/local/httpd --enable-so --enable-rewrite --enable-charset-lite --enable-cgi

echo "---开始编译及安装---"
make -j 4
make install

echo "---优化配置文件路径，并把httpd服务的可执行程序文件放入路径环境变量的目录中便于系>统识别---"
ln -s /usr/local/httpd/conf/httpd.conf /etc/
ln -s /usr/local/httpd/bin/* /usr/local/bin/

echo "---添加httpd系统服务---"
cd /lib/systemd/system || exit
touch httpd.service

echo "[Unit]
Description=The Apache HTTP Server
After=network.target
[Service]
Type=forking
PIDFile=/usr/local/httpd/logs/httpd.pid
ExecStart=/usr/local/bin/apachectl $OPTIONS
ExecReload=/bin/kill -HUP $MAINPID
[Install]
WantedBy=multi-user.target" >/lib/systemd/system/httpd.service

systemctl start httpd.service
systemctl enable httpd.service

echo "---修改httpd服务配置文件---"
read -p "请输入您当前主机的IP地址：" q
sed -i 's/Listen 80/Listen $q:80/g' /etc/httpd.conf
sed -i 's/#ServerName www.example.com:80/ServerName www.jx.com:80/g'  /etc/httpd.conf

systemctl restart httpd.service

echo "$q www.jx.com" >> /etc/hosts

echo "---apachectl httpd 服务已安装成功！---"