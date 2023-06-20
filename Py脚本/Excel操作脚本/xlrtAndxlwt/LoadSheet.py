import xlrd
import xlwt
# 读取操作
excel_name=('F:/Excel/测试工作表.xlsx')
work_book = xlrd.open_workbook(excel_name)
sheets = work_book.sheet_names()
print(type(sheets))
print("sheets:"+ str(sheets))
print(sheets)

table = work_book.sheet_by_index(0)
print("总行数："+str(table.nrows))
print("总列数："+str(table.ncols))
print("整行值："+str(table.row_values(0)))
print("整列值："+str(table.col_values(1)))
# 写入与创建操作
tc_wb = xlwt.Workbook()

# 在工作蒲中田间三个新的工作表
sheet0 = tc_wb.add_sheet('Class_1')
sheet1 = tc_wb.add_sheet('Class_2')

# 设置字体
font = xlwt.Font()
font.bold = True
font.colour_index = 2
font.height = 240

# 设置模式
style = xlwt.XFStyle()
style.font = font

# 写入数据到工作表write(row,col,data,style)
sheet0.write(0, 0, 'Name', style)
sheet0.write(0, 1, 'Gender', style)
sheet0.write(0, 2, 'Age', style)

sheet0.write(1, 0, 'Jane')
sheet0.write(1, 1, 'Female')
sheet0.write(1, 2, 18)

sheet1.write(0, 0, 'Name', style)
sheet1.write(0, 1, 'Gender', style)
sheet1.write(0, 2, 'Age', style)

sheet1.write(1, 0, 'Mack')
sheet1.write(1, 1, 'Male')
sheet1.write(1, 2, 20)

#保存工作簿到文件中
tc_wb.save('F:/Excel/student.xlsx')
