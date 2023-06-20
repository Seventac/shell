#!/bin/bash
# 首先下载好对应http安装包到opt目录下
tar -zxf /root/opt/httpd-2.4.25.tar.gz -C /usr/src
cd /usr/src/httpd-2.4.25 || exit
yum install -y gcc* apr* pcre*
./configure --prefix=/usr/local/httpd --enable-so --enable-rewrite --enable-charset-lite --enable-cgi
make && make install
cd /usr/local/httpd/bin || exit
sed -i 's@#ServerName www.example.com:80@ServerName localhost:80@' /usr/local/httpd/conf/httpd.conf
/usr/local/httpd/bin/apachectl -k start
ln -s /usr/local/httpd/bin/* /usr/local/bin
cp -f /usr/local/httpd/bin/apachectl /etc/init.d/httpd
sed -i '2s@#@# chkconfig:35 85 21@' /etc/init.d/httpd
chkconfig  --add   httpd
# 启动测试
systemctl start httpd
if ! make mytarget;
then
    echo "httpd start failed"
else
    echo "httpd start succeed"
fi
systemctl stop httpd
echo "apache 服务安装完成，测试成功并关闭服务"