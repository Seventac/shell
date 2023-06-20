"""
理论上可行
"""

import os

path='E:\\'
config_path ='E:\\Config_File'

"""
准备工作
"""

# 首先查看当前工作目录
now_workspace = os.getcwd()
print(now_workspace)

# 将当前工作目录改为指定路径
os.chdir(path)
# 进行判断，操作是否成功
changed_workspace = True if  os.chdir(path)==None else False
print(changed_workspace)

# 返回当前工作目录中的文件列表
dir_list = os.listdir(path)
print(dir_list)

# 新建一个外部配置文件目录
os.rmdir(config_path)


# 上传配置文件到指定位置配置文件目录【可作为扩展功能，可引用外部文件实现】
# 当前为手动通过xshell，的rz -y命令进行文件上传

os.chdir(config_path)



os.system('yum install dhcp')

# 执行配置文件替换命令 mv -f dhcpd.conf /etc/dhcp/dhcpd.conf

os.system('mv -f dhcpd.conf /etc/dhcp/dhcp.conf')

# 进行防火墙设置
"""
firewall-cmd --add-service=dhcp   	// 设置防火墙支持 dhcp
firewall-cmd --list-all				// 查看
firewall-cmd --runtime-to-permanent	// 将当前防火墙的规则永久保存
"""

os.system('firewall-cmd --add-service=dhcp')
os.system('firewall-cmd --runtime-to-permanent')

"""重启dhcp服务"""

os.system('systemctl restart dhcpd')