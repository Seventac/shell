import xlwt

# 新建工作簿
work_book = xlwt.Workbook()
"_init_(self,encoding='ascii',style_compression=0):"
# 默认编码 ASCII

# 增加sheet表
work_sheet = work_book.add_sheet('Test')

"add_sheet(self,sheetname,cell_overwrite_ok=False):"

"Exception:Attempt to overwrite cell:sheetname='Test'"
# 保存文件
work_book.save('F:/Excel/Test.xls')