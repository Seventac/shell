import pickle
import json
import os
"""
序列化方案
"""

# pickle方案,加密
# 原理：二进制加密
dict = dict(name='hcx',age= 23)
str =pickle.dumps(dict)
print(str)

# 二进制写入文件
file = open(os.path.join(os.path.abspath('.'), 'test.txt'), 'wb')
print(file)
pickle.dump(dict, file)
file.close()

# json方案,明文
dictchar={'name':'lichaojun', 'age':'12'}
str=json.dumps(dictchar)
print(str)
