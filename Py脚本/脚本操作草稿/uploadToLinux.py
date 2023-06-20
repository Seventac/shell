"""
操作可行
"""

import paramiko
import sys
src_file = sys.argv[1]   #windows下的源文件
dsc_path = sys.argv[2]   #linux上的目录路径
key_path = '私钥路径'
password = '密码'
ssh = paramiko.SSHClient() # 创建SSH对象
private_key = paramiko.RSAKey.from_private_key_file(key_path) # 指定私钥
ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())# 允许连接不在know_hosts文件中的主机
transport = paramiko.Transport(('ip', 80))
transport.connect(username='root', pkey=private_key) # 连接服务器
def upload():
    sftp = paramiko.SFTPClient.from_transport(transport)
    try:
        sftp.put(src_file, dsc_path + '/' + src_file)
        print('上传成功')
    except Exception as e:
        print(e)
    ssh.close()
def unzip():
    ssh._transport = transport
    stdin, stdout, stderr = ssh.exec_command('cd ' + dsc_path + '&&' + 'unzip -o ' + src_file)
    result = stdout.read().decode()
    if result.strip() != '':
        print('解压成功')
    else:
        print('Error message ' + stderr.read().decode())
    ssh.close()
if __name__ == '__main__':
    upload()
    unzip()