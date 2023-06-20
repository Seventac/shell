#!/bin/bash
# 其中的hcx1为用户目录
# 试验环境为centos7
echo ---------------开始--------------------
echo ---------------aboutkey----------------
cd /etc || exit
if [ -f login.defs ];then
cp /etc/login.defs  /home/hcx1
MINDAY=$(cat -n /home/hcx1/login.defs | grep -v ".*#.*"| grep PASS_MIN_DAYS|awk '{print $1}')
sed -i ''"$MINDAY"'s/.*PASS_MIN_DAYS.*/PASS_MIN_DAYS 6/' /home/hcx1/login.defs
WARNAGE=$(cat -n /home/hcx1/login.defs | grep -v ".*#.*"| grep PASS_WARN_AGE|awk '{print $1}')
sed -i ''"$WARNAGE"'s/.*PASS_WARN.*/PASS_WARN_AGE 30/' /home/hcx1/login.defs
MAXDAY=$(cat -n /home/hcx1/login.defs | grep -v ".*#.*"| grep PASS_MAX_DAYS|awk '{print $1}')
sed -i ''"$MAXDAY"'s/.*PASS_MAX.*/PASS_MAX_DAYS 90/' /home/hcx1/login.defs
MINLEN=$(cat -n /home/hcx1/login.defs | grep -v ".*#.*"| grep PASS_MIN_LEN|awk '{print $1}')
sed -i ''"$MINDAY"'s/.*PASS_MIN_LEN.*/PASS_MIN_ LEN 6/' /home/hcx1/login.defs
fi
echo --------------------ok---------------------------
echo -------------------stop the del------------------------
cd /etc/init.d || exit
if [ -f control-alt-delete.conf ];then
cp /etc/init/control-alt-delete.conf /home/hcx1
#delete=`grep -n "/sbin/shutdown -r now" /home/test1/control-alt-delete.conf | cut -d ":" -f 1`
#sed -i ''$delete' r s/^/#/' /home/test1/control-alt-delete.conf
#cp /etc/init/control-alt-delete.conf /home/test1
#num1=`grep -n "/sbin/shutdown" /home/test1/control-alt-delete.conf | cut -d "" -f 1`
#sed -i ''$num' r s/^/#/' /home/test1/control-alt-delete.conf
#a=`cat -n /home/test1/control-alt-delete.conf|grep -v "#" | grep "/sbin/shutdown" | awk '{print $1}'`
#text=`sed -n "$a"p /home/test1/control-alt-delete.conf`
#sed -i ''$a'c # '$text'' /home/test1/control-alt-delete.conf
a=$(cat -n /home/hcx1/control-alt-delete.conf|grep -v "#" | grep /sbin/shutdown | awk '{print $1}')
    if [ -z "$a" ];then
    echo ok
    else
    sed -i ''"$a"' s/^/#/' /home/hcx1/control-alt-delete.conf
    fi
fi
echo ---------------------ok---------------------------------------
echo ------------------------grub and lilo key------------------------
grub="/home/hcx1/menu.lst"
if [ ! -x "$grub" ];then
touch "$grub"
echo password=123456 >> "$grub"
else 
echo password=123456 >> "$grub"
fi
lilo="/home/hcx1/lilo.conf"
if [ ! -x "$lilo" ];then
touch "$lilo"
echo password=123456 >> "$lilo"
else
echo password=123456 >> "$lilo"
fi
echo ---------------------ok--------------------------------------
echo ----------------------the history of mouthpasswd------------------
cd /etc || exit
if [ -f profile ];then
cp /etc/profile /home/hcx1
#num=`sed -n /home/test1/profile | grep HISTFILESIZE | awk '{print $1}'`
 #/home/test1/profile | sed $num'c HISTFILESIZE=5'
echo "HISTFILESIZE=5" >> /home/hcx1/profile
echo "ulimit -S -c unlimited" >> /home/hcx1/profile
fi
echo -------------------------ok--------------------- 
echo ------------------------issue-----------------
#issu="/etc/issue.net"
cd /etc || exit
if [ -f issue.net ];then
cp  issue.net  /home/hcx1/issue.net.bak
echo ok
fi
echo ok
if [ -f issue ];then
cp issue /home/hcx1/issue.bak
echo ok
fi
echo -----------------------allow/deny ip-------------------
cd /etc || exit
if [ -f hosts.allow ];then
cp /etc/hosts.allow /home/hcx1
echo "all:172.18.12.:all" >> /home/hcx1/hosts.allow
echo "sshd:172.18.12.:all" >> /home/hcx1/hosts.allow
fi
cd /etc || exit
if [ -f hosts.deny ];then
cp /etc/hosts.deny /home/hcx1
echo "all:all" >> /home/hcx1/hosts.deny
fi
echo -----------------ok------------------------
#/etc/init.d/xinetd restart
echo -----------------------------core dump-------------------
cd /etc/security || exit
if [ -f limits.conf ];then 
cp /etc/security/limits.conf  /home/hcx1
echo "*soft core 0" >> /home/hcx1/limits.conf
echo "*hard core 0" >> /home/hcx1/limits.conf
fi
echo --------------ok-------------------------
echo ----------------------------passwdrepeat---------------------
cd /etc/pam.d || exit
if [ -f system-auth ];then
cp /etc/pam.d/system-auth  /home/hcx1
#num=`grep -n "md5" /home/test1/system-auth | cut -d ":" -f 1`
#sed -i ''$num'    r s/$/ remember=5' /home/test1/system-auth
kk=$(cat -n /home/hcx1/system-auth | grep -v ".*#.*"| grep md5|awk '{print $1}')
echo "$kk"
version="password    sufficient    pam_unix.so md5 shadow nullok try_first_pass use_authtok remember=500"
sed -i """$kk""c $version" /home/hcx1/system-auth
letter=$(cat -n /home/hcx1/system-auth |grep password | grep requisite | awk '{print $1}')
sed -i ''"$letter"'s/pam_cracklib.so/& ucredit=-1 lcredit=-1 dcredit=-1 /' /etc/pam.d/system-auth
fi
echo -----------------ok--------------------
echo --------------------超出退出--------------
cd /etc || exit
if [ -f profile ];then
cp /etc/profile /home/hcx1
echo "export TMOUT=600" >> /home/hcx1/profile
fi
echo ------------------ok-------------------
echo ------------------权限-------------------
chmod 644 /etc/passwd
chmod 644 /etc/group
chmod 400 /etc/shadow
#chmod 600 /etc/xinetd.conf
chmod 644 /etc/services
chmod 600 /etc/security
# 引导操作系统文件
chmod 600 /etc/grub2.cfg
chmod 600 /boot/grub2/grub.cfg
# 引导管理器配置文件,该文件不在文件系统中，需要手动下载
# chmod 600 /etc/lilo.conf
 
echo ------------------unmask--------------------
cp /etc/csh.cshrc /home/hcx1
cp /etc/csh.login /home/hcx1
cp /etc/bashrc /home/hcx1
cp /etc/profile /home/hcx1
sed -i '11 s/.*umask.*/umask 077/' /home/hcx1/csh.cshrc
 
sed -i '58 s/.*umask.*/umask 077/' /home/hcx1/csh.login
 
sed -i '66 s/.*UMASK.*/UMASK 077/' /home/hcx1/bashrc
 
sed -i '62s/.*umask.*/umask 077/' /home/hcx1/profile
echo --------------------before login banner-------------------
cd /etc || exit
if [ -f ssh_banner ];then
touch /etc/ssh_banner
chown bin:bin /etc/ssh_banner
chmod 644 /etc/ssh_banner
echo "Authorized only.All activity will be monitored and reported" > /etc/ssh_banner
fi
echo -----------------------ok----------------------------
echo -------------------stop root ssh login------------------
cp /etc/pam.d/login /home/hcx1
echo "auth   required   pam_securetty.so" >> /home/hcx1/login
cp /etc/ssh/sshd_config /home/hcx1
echo "Banner /etc/ssh_banner" >> /home/hcx1/sshd_config
echo "PermitRootLogin no" >> /home/hcx1/sshd_config
service sshd restart
echo -------------------------ok-------------------
echo --------------------openssh----------------------------
openssh=$(cat -n /home/hcx1/sshd_config | grep -v ".*#.*"| grep Protocol |awk '{print $1}')
sed -i ''"$openssh"'s/.*Protocol.*/Protocol 2/' /home/hcx1/sshd_config
echo -------------ok---------------------------