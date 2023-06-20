import os

# 返回当前工作目录的Unicode字符串
#print(os.getcwd())

# 将当前工作目录改为指定路径
#os.chdir('C:\Windows')
#print(os.getcwd())

# 返回一个文件目录中的文件列表
#print(os.listdir('E:\\'))

# 新建一个文件夹
#os.mkdir("E:\\testShell")

# 新建一个多级目录的文件夹
#os.makedirs("E:\\mkdirShell\\mkdirFirst\\mkdirSecond")

# 删除一个目录
#flag = os.rmdir("E:\\testShell")
#print(flag)

# 删除多级目录
#fileFlag = os.removedirs("E:\\mkdirShell\\mkdirFirst\\mkdirSecond")
#print(fileFlag)

#print(os.listdir('E:\\'))

# 打开一个文件并写入内容
# 步骤首先获取打开文件的对象，对该对象进行读写操作
#file = open("E:\\Zeng Wentao old color batch\\study.txt",'w')
#file.write("study web src")
#file.close()

# 重命名一个文件或目录
#os.rename("E:\\Zeng Wentao old color batch","E:\\HCX")

# 对给定的路径执行 stat 系统调用

#good_info = os.stat('Py脚本\\test.sh')
#print(good_info)

# 生成目录树

# for root,dirs,files in os.walk('F:\\Markdown\\Typora'):
#     for name in files:
#         print('file:'+os.path.join(root,name))
#     for name in dirs:
#         print('dir:'+os.path.join(root,name))

# 获取环境变量
#good_vals= os.environ
# for key,value in good_vals.items():
#     print(f"{key} = {value}")
#print(good_vals)

# 地址路径拼接
# home_vlas=os.environ.get('homedrive')
# joined=os.path.join(home_vlas,'/index.html')

# print(joined)

# 返回一个路径的末尾文件全称
# basename = os.path.basename('home/newfile/end.txt')
# print(basename)

# 路径分割,路径最后一个\后的内容进行分割
# splited_path=os.path.split('e:\脚本\Py脚本\OStest.py')
# print(splited_path)
# ('e:\\脚本\\Py脚本', 'OStest.py')

# 检测路径是否存在
# flag_exist=os.path.exists('F:\音乐')
# print(flag_exist)

# 检查当前路径下的文件是否是一个文件或路径是否是一个目录。【不好用】
# contents = os.listdir()
# print(contents)
# for item in contents:
#     if os.path.isdir(item):
#         print(item+ "is a directory")
#     elif os.path.isfile(item):
#         print(item+"is a file")

# 拓展名分割
# file_end_split=os.path.splitext("F:\翻译词典\YoudaoDictSetup.exe")
# print(file_end_split)


# 文本文件合并
# 文件夹内文本文件合并
# 目标文件夹的路径
filedir = r'E:/网页数据仓库/文件合并'
#获取目标文件的文件名称列表  
filenames=os.listdir(filedir)
#打开一个新文件，如果没有则创建
f=open(r'E:/网页数据仓库/文件合并/result.txt','w+',encoding='utf8')

#先遍历文件名
for filename in filenames:
    filepath = filedir+'/'+filename
    if os.path.isfile(filepath):
    #遍历单个文件，读取行数
        for line in open(filepath,encoding='utf8'):
            f.writelines(line)
        f.write('\n')
#关闭文件
f.close()
