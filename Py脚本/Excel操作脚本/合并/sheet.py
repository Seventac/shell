import xlrd
import pandas as pd
from openpyxl import load_workbook

"""
将同一个excel表格内的sheet相同字段归入到一个新的excel内的sheet内
"""

excel_name = r'F:/Excel/student.xlsx'
# 写入文件位置，*处填入文件位置

Wb = xlrd.open_workbook(excel_name) 
# 获取工作表中所有的表格

Sheets = Wb.sheet_names()
# 获取工作表中所有表格名

Merge_data = pd.DataFrame()
# 建立空DataFrame，存储数据

for i in range(len(Sheets)):  
# 循环遍历所有Sheets
    df = pd.read_excel(excel_name, sheet_name=i,)
    # 仅适用于公共表项
    cols_name= df[["学生","姓名"]]
    # 适用于不同表
# 选择所需要的列，如果是一列，则只需传入一个列名；如果同时选择多列，则传入多个列名即可，多个列名用列表形式封存
# 如果多个excel文件中的列名一致，则不需此项
# #处填入列名
    Merge_data = Merge_data._append(cols_name)

#保存为新的Excel文件，且所有数据在一个Sheet中
Merge_data.to_excel(r'F:/Excel/studentsum.xlsx')