import paramiko
import time

def ssh_connect(hostname,username,password):
    Channel =paramiko.SSHClient()
    Channel.set_missing_host_key_policy(paramiko.AutoAddPolicy)
    Channel.connect(hostname,username,password,look_for_keys=False,allow_agent=False)
    shell =Channel.invoke_shell()
    shell.send("ifconfig \n")
    time.sleep(2)
    output = shell.recv(65535).decode("utf-8")
    print(output)
    Channel.close()

if __name__ == '__main__':
    ssh_connect("192.168.20.128","root",'123456')