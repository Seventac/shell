import os
import pandas as pd

"""
用于对一个文件夹中的所有Excel文件的数据合并至一个Excel（新建）中不同Sheet表的过程，其中每一个Sheet对应文件夹中的一个Excel文件，也可选择固定的列进行合并。
"""

os.chdir(r'=============')
# 写入文件夹位置，=处填入文件夹位置

Result = pd.ExcelWriter(r'***********')
# 使用ExcelWriter()函数将多个文件分别导出到不同Sheet中，*处填入写入文件位置

for name in os.listdir():
    df = pd.read_excel(name)
    df = df[["#######","#######"]]
# 选择所需要的列，如果是一列，则只需传入一个列名；如果同时选择多列，则传入多个列名即可，多个列名用列表形式封存
# 如果多个excel文件中的列名一致，则不需此项
# #处填入列名

    df.to_excel(Result,sheet_name=name)
# 按文件夹中各Excel的文件名作为合并后相应的Sheet名字

Result.save()  
